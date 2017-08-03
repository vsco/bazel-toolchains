import base64
import hashlib
import functools
import json
import requests
import sys
import tempfile

# Given a revision of Chromium like "61.0.3153.4", these files are needed:
#
# Clang version download:
# https://chromium.googlesource.com/chromium/src/+/61.0.3153.4/tools/clang/scripts/update.py
# Then, use the Clang version to produce a download url used to calculate a sha256.
#
# Sysroot version download:
# https://chromium.googlesource.com/chromium/src/+/61.0.3153.4/build/linux/sysroot_scripts/sysroots.json
# Then, use the sysroot version found in the JSON to produce a download url used to calculate a sha256.
#
# libcxx download.
# Buildtools revision:
# https://chromium.googlesource.com/chromium/src/+/61.0.3153.4/DEPS
# Then, use the buildtools revision to download something like this:
# https://chromium.googlesource.com/chromium/buildtools/+/5ad14542a6a74dd914f067b948c5d3e8d170396b/DEPS
# Then, return the revisions for libcxx etc. found in that file.
#
# Binutils version download:
# https://chromium.googlesource.com/chromium/src/+/61.0.3153.4/third_party/binutils/Linux_x64/binutils.tar.bz2.sha1

SRC_REPO = "https://chromium.googlesource.com/chromium/src/+"
TOOLS_REPO = "https://chromium.googlesource.com/chromium/buildtools/+"
DATA_STORE = "https://commondatastorage.googleapis.com"

def download(url, stream=False):
    print >> sys.stderr, "Downloading %s" % url
    response = requests.get(url, stream=stream)
    if response.status_code != 200:
        raise Exception("Unexpected status code %d" % response.status_code)
    return response

def base64_dl(url):
    # Appending '?format=TEXT' downloads a base64 version of the raw file, instead of the HTML view.
    return base64.b64decode(download(url + "?format=TEXT").text)

def progressbar_download(url, f):
    with open(f, "wb") as f:
        response = download(url, stream=True)
        total_length = response.headers.get('content-length')
        if total_length is None: # no content length header
            f.write(response.content)
        else:
            dl = 0
            total_length = int(total_length)
            for data in response.iter_content(chunk_size=4096):
                dl += len(data)
                f.write(data)
                done = int(50 * dl / total_length)
                sys.stderr.write("\r[%s%s]" % ('=' * done, ' ' * (50-done)) )    
                sys.stderr.flush()
    sys.stderr.write("\n")

def download_clang_rev(revision):
    clang_script = base64_dl("%s/%s/tools/clang/scripts/update.py" % (SRC_REPO, revision))
    exec(clang_script)
    return "%s-%s" % (CLANG_REVISION, CLANG_SUB_REVISION)

def calc_sha256(url):
    with tempfile.NamedTemporaryFile() as f:
        progressbar_download(url, f.name)
        digest = hashlib.sha256()
        [digest.update(chunk) for chunk in iter(functools.partial(f.read, 65336), '')]
        return digest.hexdigest()

def clang_url(platform, clang_rev):
    return ("%(data_store)s/chromium-browser-clang/%(platform)s/clang-%(rev)s.tgz" %
        {"platform": platform, "data_store": DATA_STORE, "rev": clang_rev})

def download_clang_info(revision):
    clang_rev = download_clang_rev(revision)
    return [{
      "platform": p,
      "url": clang_url(p, clang_rev),
      "sha256": calc_sha256(clang_url(p, clang_rev))
    } for p in ["Mac", "Linux_x64"]]

def sysroot_url(sysroot):
    return ("%s/chrome-linux-sysroot/toolchain/%s/%s" % (DATA_STORE, sysroot["Revision"], sysroot["Tarball"])).encode('ascii', 'ignore')

# Only need a sysroot for amd64 at the moment
def download_sysroot_info(revision):
    sysroot_json = base64_dl("%s/%s/build/linux/sysroot_scripts/sysroots.json" % (SRC_REPO, revision))
    sysroots = json.loads(sysroot_json)
    amd64 = sysroots["jessie_amd64"]
    amd64["platform"] = "Linux_x64"
    return [{
        "platform": p["platform"],
        "url": sysroot_url(p),
        "sha256": calc_sha256(sysroot_url(p))
    } for p in [amd64]]

def binutils_url(sha):
    return "%s/chromium-binutils/%s" % (DATA_STORE, sha)

def download_binutils_info(revision):
    binutils_platforms = [
        (p, base64_dl("%s/%s/third_party/binutils/%s/binutils.tar.bz2.sha1" % (SRC_REPO, revision, p)))
    for p in ["Linux_x64"]]
    return [{
        "type": "tar.bz2",
        "platform": bp[0],
        "url": binutils_url(bp[1]),
        "sha256": calc_sha256(binutils_url(bp[1])),
    } for bp in binutils_platforms]

def download_toolchain_info(revision):
    # DEPS files call a function named "Var" that doesn't have to be correct
    # for this purpose, but must return a string. This shim works.
    def Var(s):
        return s
    deps = base64_dl("%s/%s/DEPS" % (SRC_REPO, revision))
    exec(deps)
    tool_deps = base64_dl("%s/%s/DEPS" % (TOOLS_REPO, vars['buildtools_revision']))
    exec(tool_deps)
    return [{'name': name, 'rev': vars[name + "_revision"]} for name in ["libcxx", "libcxxabi", "libunwind"]]

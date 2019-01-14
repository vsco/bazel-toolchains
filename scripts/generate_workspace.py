# Prints a Bazel WORKSPACE file to stdout.
# Download status updates are printed to stderr.

import argparse
import chromium_repo
import os

class Repository:
    def __init__(self, name, repo_type, **kwargs):
        self.name = name
        self.repo_type = repo_type
        self.args = dict((k,v) for k, v in kwargs.iteritems() if v is not None)

    def print_invocation(self):
        print "    " + self.name + "()"

    def print_def(self):
        print """
def %(name)s():
    %(repo_type)s(
        name = '%(name)s',
        build_file = str(Label('//build_files:%(name)s.BUILD')),""" % {'name': self.name, 'repo_type': self.repo_type}

        for key, value in self.args.iteritems():
            print \
"        %(key)s = %(value)s," % {'key': key, 'value': value}
        print \
"    )"

def get_archive_type(repo):
    archive_type = repo.get('type', None)
    if archive_type is None:
        return None

    return "'" + archive_type + "'"

def get_http_archives(revision, prefix, fetch_func):
    return [Repository(
        name = prefix + repo['platform'].lower(),
        repo_type = 'http_archive',
        urls = [repo['url']],
        sha256 = "'" + repo['sha256'] + "'",
        type = get_archive_type(repo),
    ) for repo in fetch_func(revision)]

def get_git_repositories(revision, fetch_func):
    return [Repository(
        name = 'org_chromium_' + repo['name'],
        repo_type = 'new_git_repository',
        remote = "'" + 'https://chromium.googlesource.com/chromium/llvm-project/' + repo['name'] + "'",
        commit = "'" + repo['rev'] + "'"
    ) for repo in fetch_func(revision)]

def print_workspace(revision):
    repos = (get_http_archives(revision, 'org_chromium_clang_', chromium_repo.download_clang_info) +
             get_http_archives(revision, 'org_chromium_sysroot_', chromium_repo.download_sysroot_info) +
             get_http_archives(revision, 'org_chromium_binutils_', chromium_repo.download_binutils_info) +
             get_git_repositories(revision, chromium_repo.download_toolchain_info))

    base_dir = os.path.dirname(os.path.abspath(__file__))
    with open(os.path.join(base_dir, 'license_block.txt')) as f:
        print f.read()
    print '# Defines external repositories needed by bazel-toolchains.'
    print '# Chromium toolchain corresponds to Chromium %s.\n' % revision
    print 'load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")'
    print 'load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")\n'
    print 'def bazel_toolchains_repositories():'
    for repo in repos:
        repo.print_invocation()
    for repo in repos:
        repo.print_def()
    print ''

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("-r", "--rev", action="store", required=True)
    args = parser.parse_args()
    print_workspace(args.rev)

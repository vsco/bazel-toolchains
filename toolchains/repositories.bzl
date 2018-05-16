# Copyright 2016 Google Inc.
# Copyright 2017 VSCO.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Defines external repositories needed by bazel-toolchains.
# Chromium toolchain corresponds to Chromium 64.0.3282.167.

def bazel_toolchains_repositories():
    org_chromium_clang_mac()
    org_chromium_clang_linux_x64()
    org_chromium_sysroot_linux_x64()
    org_chromium_binutils_linux_x64()
    org_chromium_libcxx()
    org_chromium_libcxxabi()

def org_chromium_clang_mac():
    native.new_http_archive(
        name = 'org_chromium_clang_mac',
        build_file = str(Label('//build_files:org_chromium_clang_mac.BUILD')),
        sha256 = '4f0aca6ec66281be94c3045550ae15a73befa59c32396112abda0030ef22e9b6',
        urls = ['https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-318667-1.tgz'],
    )

def org_chromium_clang_linux_x64():
    native.new_http_archive(
        name = 'org_chromium_clang_linux_x64',
        build_file = str(Label('//build_files:org_chromium_clang_linux_x64.BUILD')),
        sha256 = 'e63e5fe3ec8eee4779812cd16aae0ddaf1256d2e8e93cdd5914a3d3e01355dc1',
        urls = ['https://commondatastorage.googleapis.com/chromium-browser-clang/Linux_x64/clang-318667-1.tgz'],
    )

def org_chromium_sysroot_linux_x64():
    native.new_http_archive(
        name = 'org_chromium_sysroot_linux_x64',
        build_file = str(Label('//build_files:org_chromium_sysroot_linux_x64.BUILD')),
        sha256 = '84656a6df544ecef62169cfe3ab6e41bb4346a62d3ba2a045dc5a0a2ecea94a3',
        urls = ['https://commondatastorage.googleapis.com/chrome-linux-sysroot/toolchain/2202c161310ffde63729f29d27fe7bb24a0bc540/debian_stretch_amd64_sysroot.tar.xz'],
    )

def org_chromium_binutils_linux_x64():
    native.new_http_archive(
        name = 'org_chromium_binutils_linux_x64',
        build_file = str(Label('//build_files:org_chromium_binutils_linux_x64.BUILD')),
        sha256 = '24c3df44af5bd377c701ee31b9b704f2ea23456f20e63652c8235a10d7cf1be7',
        type = 'tar.bz2',
        urls = ['https://commondatastorage.googleapis.com/chromium-binutils/0cb5726d9701f8be6a81b199899de1de552922f2'],
    )

def org_chromium_libcxx():
    native.new_git_repository(
        name = 'org_chromium_libcxx',
        build_file = str(Label('//build_files:org_chromium_libcxx.BUILD')),
        commit = 'f56f1bba1ade4a408d403ff050d50e837bae47df',
        remote = 'https://chromium.googlesource.com/chromium/llvm-project/libcxx',
    )

def org_chromium_libcxxabi():
    native.new_git_repository(
        name = 'org_chromium_libcxxabi',
        build_file = str(Label('//build_files:org_chromium_libcxxabi.BUILD')),
        commit = '05ba3281482304ae8de31123a594972a495da06d',
        remote = 'https://chromium.googlesource.com/chromium/llvm-project/libcxxabi',
    )

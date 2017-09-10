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
# Chromium toolchain corresponds to Chromium 62.0.3202.9.

def bazel_toolchains_repositories():
    org_chromium_clang_mac()
    org_chromium_clang_linux_x64()
    org_chromium_sysroot_linux_x64()
    org_chromium_binutils_linux_x64()
    org_chromium_libcxx()
    org_chromium_libcxxabi()
    org_chromium_libunwind()

def org_chromium_clang_mac():
    native.new_http_archive(
        name = 'org_chromium_clang_mac',
        build_file = str(Label('//build_files:org_chromium_clang_mac.BUILD')),
        sha256 = '52a2da67eb5afbc3057e6a2868dcae000b2883798fd1376a1a2ef3f73b5547c8',
        urls = ['https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-310694-2.tgz'],
    )

def org_chromium_clang_linux_x64():
    native.new_http_archive(
        name = 'org_chromium_clang_linux_x64',
        build_file = str(Label('//build_files:org_chromium_clang_linux_x64.BUILD')),
        sha256 = '24c96b5a10cf6dc41b3c58c5b81cabf5f1949db16a4c462dbd902d5239cf503a',
        urls = ['https://commondatastorage.googleapis.com/chromium-browser-clang/Linux_x64/clang-310694-2.tgz'],
    )

def org_chromium_sysroot_linux_x64():
    native.new_http_archive(
        name = 'org_chromium_sysroot_linux_x64',
        build_file = str(Label('//build_files:org_chromium_sysroot_linux_x64.BUILD')),
        sha256 = '849abc23f3d6438409e720a89c5101e49ac18754feb947efcaa701e6d30de77b',
        urls = ['https://commondatastorage.googleapis.com/chrome-linux-sysroot/toolchain/e6ac45fd042859d2240e5d432c521df01ad5b7bf/debian_jessie_amd64_sysroot.tar.xz'],
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
        commit = '3a07dd740be63878167a0ea19fe81869954badd7',
        remote = 'https://chromium.googlesource.com/chromium/llvm-project/libcxx',
    )

def org_chromium_libcxxabi():
    native.new_git_repository(
        name = 'org_chromium_libcxxabi',
        build_file = str(Label('//build_files:org_chromium_libcxxabi.BUILD')),
        commit = '4072e8fd76febee37f60aeda76d6d9f5e3791daa',
        remote = 'https://chromium.googlesource.com/chromium/llvm-project/libcxxabi',
    )

def org_chromium_libunwind():
    native.new_git_repository(
        name = 'org_chromium_libunwind',
        build_file = str(Label('//build_files:org_chromium_libunwind.BUILD')),
        commit = '41f982e5887185b904a456e20dfcd58e6be6cc19',
        remote = 'https://chromium.googlesource.com/chromium/llvm-project/libunwind',
    )


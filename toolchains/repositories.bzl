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
# Chromium toolchain corresponds to Chromium 65.0.3325.69.

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")

def bazel_toolchains_repositories():
    org_chromium_clang_mac()
    org_chromium_clang_linux_x64()
    org_chromium_sysroot_linux_x64()
    org_chromium_binutils_linux_x64()
    org_chromium_libcxx()
    org_chromium_libcxxabi()

def org_chromium_clang_mac():
    http_archive(
        name = 'org_chromium_clang_mac',
        build_file = str(Label('//build_files:org_chromium_clang_mac.BUILD')),
        sha256 = '4b2a7a65ac1ee892b318c723eec8771f514bb306f346aa8216bb0006f19d87b7',
        urls = ['https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-321529-2.tgz'],
    )

def org_chromium_clang_linux_x64():
    http_archive(
        name = 'org_chromium_clang_linux_x64',
        build_file = str(Label('//build_files:org_chromium_clang_linux_x64.BUILD')),
        sha256 = '76d4eb1ad011e3127c4a9de9b9f5d4ac624b5a9395c4d7395c9e0a487b13daf6',
        urls = ['https://commondatastorage.googleapis.com/chromium-browser-clang/Linux_x64/clang-321529-2.tgz'],
    )

def org_chromium_sysroot_linux_x64():
    http_archive(
        name = 'org_chromium_sysroot_linux_x64',
        build_file = str(Label('//build_files:org_chromium_sysroot_linux_x64.BUILD')),
        sha256 = '84656a6df544ecef62169cfe3ab6e41bb4346a62d3ba2a045dc5a0a2ecea94a3',
        urls = ['https://commondatastorage.googleapis.com/chrome-linux-sysroot/toolchain/2202c161310ffde63729f29d27fe7bb24a0bc540/debian_stretch_amd64_sysroot.tar.xz'],
    )

def org_chromium_binutils_linux_x64():
    http_archive(
        name = 'org_chromium_binutils_linux_x64',
        build_file = str(Label('//build_files:org_chromium_binutils_linux_x64.BUILD')),
        sha256 = 'd3e03aa37dd59d6b3b0df4654b964ef5361d913d50c1e2724a6f1335762fcda6',
        type = 'tar.bz2',
        urls = ['https://commondatastorage.googleapis.com/chromium-binutils/5230f6066998df2f4d61d5fa586152ab20cca300'],
    )

def org_chromium_libcxx():
    new_git_repository(
        name = 'org_chromium_libcxx',
        build_file = str(Label('//build_files:org_chromium_libcxx.BUILD')),
        commit = 'f56f1bba1ade4a408d403ff050d50e837bae47df',
        remote = 'https://chromium.googlesource.com/chromium/llvm-project/libcxx',
    )

def org_chromium_libcxxabi():
    new_git_repository(
        name = 'org_chromium_libcxxabi',
        build_file = str(Label('//build_files:org_chromium_libcxxabi.BUILD')),
        commit = '05ba3281482304ae8de31123a594972a495da06d',
        remote = 'https://chromium.googlesource.com/chromium/llvm-project/libcxxabi',
    )

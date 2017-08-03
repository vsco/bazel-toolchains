package(default_visibility = ["//visibility:public"])

# Copyright 2017 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Based on the BUILD.gn version in the Chromium tree.

config_setting(
  name = "is_mac",
  values = {"cpu": "darwin"},
)

config_setting (
  name = "is_arm",
  values = {"cpu": "armeabi-v7a"}
)

filegroup(
  name = "libcxxabi_includes",
  srcs = glob(["include/**/*"])
)

cc_inc_library(
  name = "include",
  hdrs = [":libcxxabi_includes"]
)

cc_library(
  name = "cxxabi",
  includes = ["include"],
  defines = [
    "LIBCXX_BUILDING_LIBCXXABI",
  ],
  srcs = [
    "src/abort_message.h",
    "src/abort_message.cpp",
    "src/cxa_aux_runtime.cpp",
    "src/cxa_default_handlers.cpp",
    "src/cxa_demangle.cpp",
    "src/cxa_exception.hpp",
    "src/cxa_exception.cpp",
    "src/cxa_exception_storage.cpp",
    "src/cxa_guard.cpp",
    "src/cxa_handlers.hpp",
    "src/cxa_handlers.cpp",

    # This file is supposed to be used in fno-exception builds of
    # libc++abi.  We build lib++/libc++abi with exceptions enabled.
    #"src/cxa_noexception.cpp",

    "src/cxa_personality.cpp",
    "src/cxa_unexpected.cpp",
    "src/cxa_vector.cpp",
    "src/cxa_virtual.cpp",
    "src/fallback_malloc.h",
    "src/fallback_malloc.cpp",
    "src/private_typeinfo.h",
    "src/private_typeinfo.cpp",
    "src/stdlib_exception.cpp",
    "src/stdlib_stdexcept.cpp",
    "src/stdlib_typeinfo.cpp",
  ] + select({
    ":is_mac": [],
    "//conditions:default": [ "src/cxa_thread_atexit.cpp" ], 
  }),
  deps = select({
    ":is_arm": [ "@org_chromium_libunwind//:libunwind" ], 
    "//conditions:default": [],
  })
)

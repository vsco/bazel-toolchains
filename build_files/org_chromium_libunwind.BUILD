package(default_visibility = ['//visibility:public'])

# Copyright 2017 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Based on the BUILD.gn version in the Chromium tree.

cc_library(
  name = "unwind",
  defines = [
    "_LIBUNWIND_DISABLE_VISIBILITY_ANNOTATIONS",
  ],
  copts = [
    # ValueAsBitPattern in Unwind-EHABI.cpp is only used on Debug builds.
    "-Wno-unused-function",
  ],
  srcs = [
    "trunk/src/Unwind-EHABI.cpp",
    "trunk/src/libunwind.cpp",
    "trunk/src/Unwind-sjlj.c",
    "trunk/src/UnwindLevel1-gcc-ext.c",
    "trunk/src/UnwindLevel1.c",
    "trunk/src/UnwindRegistersRestore.S",
    "trunk/src/UnwindRegistersSave.S",
  ],
)

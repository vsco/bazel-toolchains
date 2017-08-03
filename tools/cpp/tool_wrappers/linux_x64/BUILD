package(default_visibility = ['//tools/cpp:__pkg__'])

filegroup(
  name = "clang",
  srcs = [
    "chromium_clang",
    "@org_chromium_clang_linux_x64//:clang",
  ],
)

filegroup(
  name = "ar",
  srcs = [
    "chromium_ar",
    "@org_chromium_binutils_linux_x64//:ar",
  ],
)

filegroup(
  name = "as",
  srcs = [
    "chromium_as",
    "@org_chromium_binutils_linux_x64//:as",
  ],
)

filegroup(
  name = "ld_and_symlink",
  srcs = [
    "chromium_ld",
    "ld",
    "@org_chromium_binutils_linux_x64//:ld",
  ],
)

filegroup(
  name = "nm",
  srcs = [
    "chromium_nm",
    "@org_chromium_binutils_linux_x64//:ar",
  ],
)

filegroup(
  name = "objcopy",
  srcs = [
    "chromium_objcopy",
    "@org_chromium_binutils_linux_x64//:objcopy",
  ],
)

filegroup(
  name = "objdump",
  srcs = [
    "chromium_objdump",
    "@org_chromium_binutils_linux_x64//:objdump",
  ],
)

filegroup(
  name = "strip",
  srcs = [
    "chromium_strip",
    "@org_chromium_binutils_linux_x64//:strip",
  ],
)

filegroup(
  name = "tool-wrappers",
  srcs = [
    ":clang",
    ":ar",
    ":as",
    ":ld_and_symlink",
    ":nm",
    ":objcopy",
    ":objdump",
    ":strip",
  ],
)

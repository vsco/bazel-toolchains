cc_toolchain_suite(
  name = "default-toolchain",
  toolchains = {
    "darwin|compiler": "cc_toolchain_apple",
    "k8|clang": "cc_toolchain_linux",
  },
  visibility = ["//visibility:public"],
)

cc_toolchain(
  name = "cc_toolchain_linux",
  all_files = ":linux_toolchain_deps",
  compiler_files = ":linux_toolchain_deps",
  cpu = "k8",
  dwp_files = ":linux_toolchain_deps",
  dynamic_runtime_libs = [":empty"],
  linker_files = ":linux_toolchain_deps",
  objcopy_files = ":linux_toolchain_deps",
  static_runtime_libs = [":empty"],
  strip_files = ":linux_toolchain_deps",
  supports_param_files = 0,
  visibility = ["//visibility:public"],
)

cc_toolchain(
  name = "cc_toolchain_apple",
  all_files = ":apple_toolchain_deps",
  compiler_files = ":apple_toolchain_deps",
  cpu = "darwin",
  dwp_files = ":apple_toolchain_deps",
  dynamic_runtime_libs = [":empty"],
  linker_files = ":apple_toolchain_deps",
  objcopy_files = ":apple_toolchain_deps",
  static_runtime_libs = [":empty"],
  strip_files = ":apple_toolchain_deps",
  supports_param_files = 0,
  visibility = ["//visibility:public"],
)

filegroup(
  name = "empty",
  srcs = [],
  visibility = ["//visibility:private"],
)

filegroup(
  name = "apple_toolchain_deps",
  srcs = [
    "//tools/cpp/tool_wrappers/mac:clang",
    "@org_chromium_clang_mac//:compiler_components",
  ],
  visibility = ["//visibility:private"],
)

filegroup(
  name = "linux_toolchain_deps",
  srcs = [
    "//tools/cpp/tool_wrappers/linux_x64:tool-wrappers",
    "@org_chromium_binutils_linux_x64//:binutils_components",
    "@org_chromium_clang_linux_x64//:compiler_components",
    "@org_chromium_sysroot_linux_x64//:sysroot",
    "@org_chromium_libcxx//:libcxx_includes",
    "@org_chromium_libcxxabi//:libcxxabi_includes",
  ],
  visibility = ["//visibility:private"],
)

config_setting(
  name = "debug",
  values = {"compilation_mode": "dbg"},
)

config_setting(
  name = "linux",
  values = {"cpu": "k8"},
)

config_setting(
  name = "apple",
  values = {"cpu": "darwin"},
)

config_setting(
  name = "clang-linux",
  values = {
    "compiler": "clang",
    "cpu": "k8",
  },
)

config_setting(
  name = "apple_debug",
  values = {
    "compilation_mode": "dbg",
    "cpu": "darwin",
  },
)

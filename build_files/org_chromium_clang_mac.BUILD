package(default_visibility = ["//visibility:public"])

filegroup(
  name = "clang",
  srcs = [
    "bin/clang",
  ],
)

filegroup(
  name = "include",
  srcs = glob(["include/**"]),
)

filegroup(
  name = "lib",
  srcs = glob(["lib/**"]),
)

filegroup(
  name = "compiler_components",
  srcs = [
    ":clang",
    ":include",
    ":lib",
  ],
)

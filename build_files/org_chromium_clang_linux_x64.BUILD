package(default_visibility = ["//visibility:public"])

filegroup(
  name = "clang",
  srcs = [
    "bin/clang",
  ],
)

filegroup(
  name = "lib",
  srcs = glob(["lib/**"]),
)

filegroup(
  name = "compiler_components",
  srcs = [
    ":clang",
    ":lib",
  ],
)

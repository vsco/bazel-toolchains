cc_library(
    name = "main",
    srcs = glob(
        ["src/*.cc"],
        exclude = ["src/gtest-all.cc"]
    ),
    hdrs = glob([
        "include/**/*.h",
        "src/*.h"
    ]),
    copts = [
      '-Iexternal/gtest/include',
      '-Wno-unused-const-variable',
    ],
    linkopts = ["-v"],
    visibility = ["//visibility:public"],
)

# Chromium toolchain corresponding to Chromium 64.0.3282.167
workspace(name = "co_vsco_bazel_toolchains")

load("//toolchains:repositories.bzl", "bazel_toolchains_repositories")
bazel_toolchains_repositories()

# GTest
new_http_archive(
  name = "gtest",
  url = "https://github.com/google/googletest/archive/release-1.8.0.zip",
  sha256 = "f3ed3b58511efd272eb074a3a6d6fb79d7c2e6a0e374323d1e6bcbcc1ef141bf",
  build_file = "build_files/gtest.BUILD",
  strip_prefix = "googletest-release-1.8.0/googletest",
)

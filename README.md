# Bazel Toolchains

A collection of [Bazel](https://bazel.build) C++ build infrastructure based on [Chromium](https://chromium.org)'s [LLVM](https://llvm.org) toolchain. There are tags corresponding to Chromium releases. The build targets currently supported are Linux x64 and macOS. As in Chromium, the Linux toolchain has a sysroot, bundled copies of binutils, and a copy of libc++. The macOS build is less hermetic, and relies on system binutils and libraries.

Use it in your Bazel WORKSPACE file like this:

```
git_repository(
    name = 'co_vsco_bazel_toolchains',
    remote = 'https://github.com/vsco/bazel-toolchains',
    tag = 'v62.0.3202.9',
)

load("@co_vsco_bazel_toolchains//toolchains:repositories.bzl", "bazel_toolchains_repositories")
bazel_toolchains_repositories()
```

Invoke Bazel with the custom toolchain:

`bazel build --crosstool_top=@co_vsco_bazel_toolchains//tools/cpp:default-toolchain //your/build:target`

## Prerequisites

On macOS, run `xcode-select --install` in Terminal.

## Running the Python scripts

The files in the `scripts/` directory are written in Python. Follow these [instructions](http://docs.python-guide.org/en/latest/starting/installation/) to install a version of Python that comes with the necessary tools for installation of third party libraries. On macOS, this means `brew install python`, and then following the instructions printed by `brew info python`.

Once that's working, type `pip install requests` to install the necessary dependencies.

From the root of this repository, type `python scripts/generate_workspace.py --rev="62.0.3202.9"` where --rev is the Chromium tag you wish to pull from. The script will print status messages to `stderr` and write a file similar to toolchains/repositories.bzl to `stdout`.

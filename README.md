# Bazel Toolchains

[![Build Status](https://travis-ci.org/vsco/bazel-toolchains.svg?branch=master)](https://travis-ci.org/vsco/bazel-toolchains)

A collection of [Bazel](https://bazel.build) C++ build infrastructure based on [Chromium](https://chromium.org)'s
[LLVM](https://llvm.org) toolchain. There are tags corresponding to Chromium releases. The build targets currently
supported are Linux x64 and macOS. As in Chromium, the Linux toolchain has a sysroot, bundled copies of binutils, and a
copy of libc++. The macOS build is less hermetic, and relies on system binutils and libraries.

Use it in your Bazel WORKSPACE file like this:

```
git_repository(
    name = 'co_vsco_bazel_toolchains',
    remote = 'https://github.com/vsco/bazel-toolchains',
    tag = 'v64.0.3282.167',
)

load("@co_vsco_bazel_toolchains//toolchains:repositories.bzl", "bazel_toolchains_repositories")
bazel_toolchains_repositories()
```

Invoke Bazel with the custom toolchain:

`bazel build --crosstool_top=@co_vsco_bazel_toolchains//tools/cpp:default-toolchain //your/build:target`

## Bazel Compatibility

`vsco/bazel-toolchains` is tested against the following build matrix:

| Bazel Version   | OSX | Linux |
| :-------------- | :-: | :---: |
| 0.20.0+         | ✗   | ✗    |
| 0.19.2          | ✓   | ✓    |
| 0.18.1          | ✓   | ✓    |
| 0.17.2          | ✓   | ✓    |
| 0.16.1          | ✓   | ✓    |
| 0.15.2          | ✓   | ✓    |
| 0.14.1          | ✓   | ✓    |
| 0.13.1          | ✓   | ✓    |
| 0.12.0          | ✓   | ✓    |
| ~0.11.x~        | ✗   | ✗     |
| ~0.10.x~        | ✗   | ✗     |
| ~0.9.x~         | ✗   | ✗     |

Builds beyond the listed versions are not currently tested.

Bazel `0.20.0+` introduced breaking changes to the [C++ Toolchain API](https://github.com/bazelbuild/bazel/issues/6434)
which need to be addressed for consumers of this repo in a non-breaking manner.

## Prerequisites

On macOS, run `xcode-select --install` in Terminal.

## Running the Python scripts

The files in the `scripts/` directory are written in Python. Follow these
[instructions](http://docs.python-guide.org/en/latest/starting/installation/)
to install a version of Python that comes with the necessary tools for installation of third party libraries. On macOS,
this means `brew install python`, and then following the instructions printed by `brew info python` (It's recommended to use `python@2` for macOS).

Once that's working, type `pip install requests` to install the necessary dependencies.

From the root of this repository, type `python scripts/generate_workspace.py --rev="64.0.3282.167"` where --rev is the
Chromium tag you wish to pull from. The script will print status messages to `stderr` and write a file similar to
toolchains/repositories.bzl to `stdout`.

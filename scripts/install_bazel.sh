#!/usr/bin/env bash
#
# This script installs Bazel for Debian or MacOS for usage in the Travis CI environment.
#
# Required config:
# - CI
# - TRAVIS
# - TRAVIS_OS_NAME
# - BAZEL_VERSION: Bazel version to install
#
# Optional configs:
# - BAZEL_INSTALL: Location to fetch the installers to, default: ${HOME}/bazel/install
#
set -e

if [ -z "$CI" ] || [ -z "$TRAVIS" ]; then
    echo "error: this is intended to be run under travis-ci, exiting..."
    exit 1;
fi

if [ -z "$BAZEL_VERSION" ]; then
    echo "error: BAZEL_VERSION required, exiting..."
    exit 1;
fi

if [ -z "$BAZEL_INSTALL" ]; then
   BAZEL_INSTALL="${HOME}/bazel/install"
fi

mkdir -p $BAZEL_INSTALL
pushd $BAZEL_INSTALL

if [ "$TRAVIS_OS_NAME" == "linux" ]; then
    echo "Installing Bazel ${BAZEL_VERSION} for Linux"
    DEBIAN_PACKAGE_NAME="bazel_${BAZEL_VERSION}-linux-x86_64.deb"
    wget --no-clobber "https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/${DEBIAN_PACKAGE_NAME}"
    sudo dpkg -i ${DEBIAN_PACKAGE_NAME}
elif [ "$TRAVIS_OS_NAME" == "osx" ]; then
    echo "Installing Bazel ${BAZEL_VERSION} for Darwin"
    DARWIN_INSTALL_SCRIPT=bazel-${BAZEL_VERSION}-without-jdk-installer-darwin-x86_64.sh
    curl -sLO https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/${DARWIN_INSTALL_SCRIPT}
    chmod +x ${DARWIN_INSTALL_SCRIPT}
    ./${DARWIN_INSTALL_SCRIPT} --user
else
    echo "error: unsupported TRAVIS_OS_NAME: ${TRAVIS_OS_NAME}, exiting"
    exit 1;
fi

popd

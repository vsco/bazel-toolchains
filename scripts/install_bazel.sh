#!/usr/bin/env bash
set -e

LOCAL_OS="$(uname)"

if [ -z "$BAZEL_VERSION" ]; then
   BAZEL_VERSION="0.11.1"
fi

if [ -z "$BAZEL_INSTALL" ]; then
   BAZEL_INSTALL="${HOME}/bazel/install"
fi

mkdir -p $BAZEL_INSTALL
pushd $BAZEL_INSTALL

if [ "$LOCAL_OS" == "Linux" ]; then
    echo "Installing Bazel ${BAZEL_VERSION} for Linux"
    wget --no-clobber "https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel_${BAZEL_VERSION}-linux-x86_64.deb"
    sudo dpkg -i "bazel_${BAZEL_VERSION}-linux-x86_64.deb"
elif [ "$LOCAL_OS" == "Darwin" ]; then
    echo "Installing Bazel ${BAZEL_VERSION} for Darwin"
    curl -sLO https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-without-jdk-installer-darwin-x86_64.sh
    chmod +x bazel-${BAZEL_VERSION}-without-jdk-installer-darwin-x86_64.sh
    ./bazel-${BAZEL_VERSION}-without-jdk-installer-darwin-x86_64.sh --user
else
    echo "Unsupported OS"
    exit 1;
fi

popd

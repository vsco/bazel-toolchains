#include "gtest/gtest.h"

namespace vsco {

TEST(CompilerMeta, AppleBuild) {
#if defined(__apple_build_version__)
  // __apple_build_version__ shouldn't be defined in the Chromium toolchain
  ASSERT_TRUE(false);
#else
  ASSERT_GE(__clang_major__, 6);
#endif
}

}

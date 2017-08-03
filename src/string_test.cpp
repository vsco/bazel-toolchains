#include "gtest/gtest.h"
#include <string>

namespace vsco {

TEST(String, PopBack) {
  std::string foo = "abcd";
  foo.pop_back();
  EXPECT_EQ("abc", foo);
}

}

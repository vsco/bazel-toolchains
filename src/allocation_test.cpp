#include "gtest/gtest.h"
#include <string>

namespace vsco {

TEST(Allocation, NewDelete) {
  std::string *foo = new std::string("abcd");
  foo->pop_back();
  EXPECT_STREQ("abc", foo->c_str());
  delete foo;
}

}

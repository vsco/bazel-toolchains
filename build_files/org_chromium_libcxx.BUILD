package(default_visibility = ["//visibility:public"])

filegroup(
  name = "libcxx_includes",
  srcs = glob(["include/**/*"])
)

cc_library(
  name = "cxxlib",
  copts = [
    "-fPIC",
    "-fstrict-aliasing",
    "-nostdinc++",
    "-std=c++11",
  ],
  hdrs = glob(["src/support/runtime/*.ipp"]),
  includes = ["include"],
  defines = [
    "_LIBCPP_DISABLE_VISIBILITY_ANNOTATIONS",
    "_LIBCXXABI_DISABLE_VISIBILITY_ANNOTATIONS",
    "_LIBCPP_BUILDING_LIBRARY",
    "LIBCXX_BUILDING_LIBCXXABI"

    # This resets the visibility to default only for the various
    # flavors of operator new and operator delete.  These symbols
    # are weak and get overriden by Chromium-provided ones, but if
    # these symbols had hidden visibility, this would make the
    # Chromium symbols hidden too because elf visibility rules
    # require that linkers use the least visible form when merging,
    # and if this is hidden, then when we merge it with tcmalloc's
    # operator new, hidden visibility would win. However, tcmalloc
    # needs a visible operator new to also override operator new
    # references from system libraries.
    # TODO(lld): Ask lld for a --force-public-visibility flag or
    # similar to that overrides the default elf merging rules, and
    # make tcmalloc's gn config pass that to all its dependencies,
    # then remove this override here.
    #"_LIBCPP_OVERRIDABLE_FUNC_VIS=__attribute__((__visibility__(\"\"default\"\"")))",
  ],
  srcs = [
    "src/algorithm.cpp",
    "src/any.cpp",
    "src/bind.cpp",
    "src/chrono.cpp",
    "src/condition_variable.cpp",
    "src/debug.cpp",
    "src/exception.cpp",
    "src/functional.cpp",
    "src/future.cpp",
    "src/hash.cpp",
    "src/ios.cpp",
    "src/iostream.cpp",
    "src/locale.cpp",
    "src/memory.cpp",
    "src/mutex.cpp",
    "src/new.cpp",
    "src/optional.cpp",
    "src/random.cpp",
    "src/regex.cpp",
    "src/shared_mutex.cpp",
    "src/stdexcept.cpp",
    "src/string.cpp",
    "src/strstream.cpp",
    "src/system_error.cpp",
    "src/thread.cpp",
    "src/typeinfo.cpp",
    "src/utility.cpp",
    "src/valarray.cpp",
    "src/variant.cpp",
    "src/include/atomic_support.h",
    "src/include/config_elast.h",
  ],
  deps = [
    "@org_chromium_libcxxabi//:include",
  ]
)

cc_library(
  name = "cxx",
  hdrs = [
    "libcxx_includes",
    "@org_chromium_libcxxabi//:include",
  ],
  deps = [
    "@org_chromium_libcxxabi//:cxxabi",
    ":cxxlib"
  ],
)
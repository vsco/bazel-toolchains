config_setting(
    name = 'darwin_mode',
    values = {'cpu': 'darwin'},
)

cc_test(
  name = 'test',
  srcs = glob(['*_test.cpp']),
  copts = ['-Iexternal/gtest/include'],
  deps = [
    '@gtest//:main',
  ] + select({
    ':darwin_mode': [], 
    '//conditions:default': [
    ],
  }),
)
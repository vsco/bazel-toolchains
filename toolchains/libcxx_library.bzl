# Mimics cc_library, but doesn't need the toolchain (which would be a circular dependency)

def _needs_pic():
  return True

def _dir(s):
  return "/".join(s.split("/")[:-1])

def _obj_directory(ctx):
  return "/".join([ctx.bin_dir.path, _dir(ctx.build_file_path), "_objs"])

def _compilation_output(ctx, src, suffix):
  return "/".join([_obj_directory(ctx), ctx.label.name, src.path.rstrip(".cpp") + suffix])

def _dep_file(ctx, src):
  suffix = ".pic.d" if _needs_pic() else ".d"
  return _compilation_output(ctx, src, suffix)

def _obj_file(ctx, src):
  suffix = ".pic.o" if _needs_pic() else ".o"
  return _compilation_output(ctx, src, suffix)

def _impl_libcxx_library(ctx):
  dep_files = depset()
  for dep in ctx.attr.deps:
    dep_files += dep.files

  deps_list = dep_files.to_list()
  srcs_list = depset(ctx.files.srcs).to_list()
  hdrs_list = depset(ctx.files.hdrs).to_list()
  cpp_options = [
    "--sysroot=external/org_chromium_sysroot_linux_x64", "-nostdinc++",
    "-isystem", "external/org_chromium_libcxxabi/include",
    "-isystem", "external/org_chromium_libcxx/include",
    "-isystem", "external/org_chromium_clang_linux_x64/lib/clang/6.0.0/include",
    "-isystem", "external/org_chromium_sysroot_linux_x64/usr/include/x86_64-linux-gnu",
    "-isystem", "external/org_chromium_sysroot_linux_x64/usr/include",
    "-U_FORTIFY_SOURCE", "-fstack-protector", "-fPIE", "-fdiagnostics-color=always", "-Wall",
    "-Wunused-parameter", "-Wno-sequence-point", "-fno-omit-frame-pointer"
  ]
  cxx_options = ["-std=c++1y"]
  unfiltered = [
    "-no-canonical-prefixes", "-Wno-builtin-macro-redefined",
    "-D__DATE__=\"redacted\"", "-D__TIMESTAMP__=\"redacted\"",
    "-D__TIME__=\"redacted\""
  ]

  obj_deps = []
  obj_files = []
  for src in srcs_list:
    if not src.path.endswith("cpp"):
      continue

    obj_dep = ctx.actions.declare_file(_dep_file(ctx, src))
    obj_deps.append(obj_dep)

    obj_file = ctx.actions.declare_file(_obj_file(ctx, src))
    obj_files.append(obj_file)

    ctx.actions.run(
      outputs = [ obj_file, obj_dep ],
      inputs = srcs_list + hdrs_list + deps_list,
      arguments = cpp_options + cxx_options + ctx.attr.copts +
        [
          "-MD", "-MF", obj_dep.path,
          "-frandom-seed=%s" % obj_file.path,
          "-fPIC" if _needs_pic() else "",
        ] + [
          "-D" + attr for attr in ctx.attr.defines
        ] + unfiltered + [
          "-c", src.path, "-o", obj_file.path
        ],
      executable = "external/co_vsco_bazel_toolchains/tools/cpp/tool_wrappers/linux_x64/chromium_clang",
      env = {"PWD": "/proc/self/cwd"},
    )

  ctx.actions.run(
    outputs = [ ctx.outputs.out ],
    inputs = obj_files + deps_list,
    arguments = ["rcsD", ctx.outputs.out.path] + [obj.path for obj in obj_files],
    executable = "external/co_vsco_bazel_toolchains/tools/cpp/tool_wrappers/linux_x64/chromium_ar",
    env = {"PWD": "/proc/self/cwd"},
  )

libcxx_library = rule(
  _impl_libcxx_library,
  attrs = {
    "copts": attr.string_list(),
    "hdrs": attr.label_list(allow_files = True),
    "defines": attr.string_list(),
    "srcs": attr.label_list(allow_files = True),
    "deps": attr.label_list(),
  },
  outputs = {
    "out": "lib%{name}.a",
  },
)

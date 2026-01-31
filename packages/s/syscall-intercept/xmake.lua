package("syscall-intercept")
    set_homepage("https://github.com/pmem/syscall_intercept")
    set_description("Userspace syscall intercepting library.")
    set_license("BSD-2-Clause")
    set_urls("https://github.com/pmem/syscall_intercept.git")

    add_deps("capstone")
    add_deps("cmake")

    add_versions("stable", "master")

    on_install("linux", function (package)
        local configs = {}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:is_debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_EXAMPLES=OFF")
        table.insert(configs, "-DBUILD_TESTS=OFF")
        table.insert(configs, "-DINSTALL_MAN=OFF")
        table.insert(configs, "-DPERFORM_STYLE_CHECKS=OFF")
        table.insert(configs, "-DTREAT_WARNINGS_AS_ERRORS=OFF")
        import("package.tools.cmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:has_cincludes("libsyscall_intercept_hook_point.h"))
        local code = [[
#include <errno.h>
#include <libsyscall_intercept_hook_point.h>
#include <syscall.h>
static int hook(long syscall_number, long arg0, long arg1, long arg2, long arg3,
                long arg4, long arg5, long *result) {
  if (syscall_number == SYS_getdents) {
    *result = -ENOTSUP;
    return 0;
  }
  return 1;
}
static __attribute__((constructor)) void init(void) {
  intercept_hook_point = hook;
}
        ]]
        assert(package:check_cxxsnippets({test = code}, {configs = {languages = "c++20"}}))
    end)

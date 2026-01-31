package("cppcoro-20")
    set_homepage("https://github.com/andreasbuhr/cppcoro")
    set_description("A library of C++ coroutine abstractions for the coroutines TS (C++20 build).")
    set_license("MIT")
    set_urls("https://github.com/andreasbuhr/cppcoro.git")
    add_deps("cmake")

    add_versions("latest", "main")

    on_install(function (package)
        local configs = {}
        table.insert(configs, "-DBUILD_TESTING=OFF")
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:is_debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
        import("package.tools.cmake").install(package, configs)
    end)

    on_test(function (package)
        local code = [[
            #include <cppcoro/task.hpp>
            cppcoro::task<void> example() { co_return; }
            int main() { return 0; }
        ]]
        assert(package:check_cxxsnippets({test = code}, {configs = {languages = "c++20"}}))
    end)

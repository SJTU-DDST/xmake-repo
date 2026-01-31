package("rdmapp")
    set_description("The rdmapp package")
    add_deps("ibverbs", {system=true})
    add_deps("pthread", {system=true})
    add_deps("spdlog 1.16.0", {private=true, configs={header_only=true}})

    add_versions("0.1.0", "47ab612121be63d95d699d6aacc74ef34ce9b47d")

    add_urls("https://github.com/SJTU-DDST/rdmapp.git")

    add_configs("docs", {default = false, description = "Build docs"})
    add_configs("asio_coro", {default = true, description = "Support Asio Coroutine"})
    add_configs("examples", {default = true, description = "Build examples"})
    add_configs("examples_pybind", {default = false, description = "Build pybind11 example"})
    add_configs("nortti", {default = true, description = "Build without RTTI"})
    add_configs("pic", {default = false, description = "Build with -fPIC for shared library"})

    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
            package:config_set("pic", true)
        end
        for _, name in ipairs({"docs", "asio_coro", "examples", "examples_pybind", "nortti", "pic"}) do
            configs[name] = package:config(name)
        end
        import("package.tools.xmake").install(package, configs)
    end)

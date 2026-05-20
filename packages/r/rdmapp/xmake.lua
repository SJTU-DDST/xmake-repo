package("rdmapp")
    set_description("The rdmapp package")
    add_deps("ibverbs", {system=true})
    add_deps("pthread", {system=true})

    add_versions("0.1.0", "d25f34ac32b5118064b558bfbeddd8a3c6eabc45")
    add_versions("0.1.1", "dfa5094c19926230aa32e9cf62ed92d7602337d6")

    add_urls("https://github.com/SJTU-DDST/rdmapp.git")

    add_configs("docs", {default = false, description = "Build docs"})
    add_configs("examples", {default = true, description = "Build examples"})
    add_configs("examples_pybind", {default = false, description = "Build pybind11 example"})
    add_configs("nortti", {default = true, description = "Build without RTTI"})
    add_configs("enable_pic", {default = false, description = "Build with -fPIC for shared library"})

    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
            package:config_set("pic", true)
        end
        for _, name in ipairs({"docs", "examples", "examples_pybind", "nortti"}) do
            configs[name] = package:config(name)
        end
        configs.pic = package:config("enable_pic")
        import("package.tools.xmake").install(package, configs)
    end)

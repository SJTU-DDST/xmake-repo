package("coverbs-rpc")
    set_description("The coverbs-rpc package")
    add_deps("rdmapp 0.1.1", {public=true,configs={enable_pic=true,asio_coro=false,examples=false,nortti=false}})
    add_deps("cppcoro-20", {public=true})
    add_deps("glaze 7.0.0", {public=true})
    add_deps("spdlog 1.16.0", {private=true,configs={header_only=true}})
    add_deps("concurrentqueue 1.0.4", {private=true})

    add_urls("https://github.com/SJTU-DDST/coverbs-rpc.git")
    add_versions("0.1.1", "b45b208d4255114dfe2b1430211a32f1cce6682a")
    add_versions("0.1.0", "4beb7e4b2ec9deb4b536058c28f5941e13e5c9d8")

    add_configs("tests", {default = false, description = "Build tests programs"})

    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end
        configs.tests = package:config("tests")
        import("package.tools.xmake").install(package, configs)
    end)

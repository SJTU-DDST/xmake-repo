package("coverbs-rpc")
    set_description("The coverbs-rpc package")
    add_deps("rdmapp 0.1.0", {public=true,configs={enable_pic=true,examples=false,nortti=false}})
    add_deps("cppcoro-20", {public=true})
    add_deps("glaze 7.0.0", {public=true})
    add_deps("concurrentqueue 1.0.4", {private=true})

    add_urls("https://github.com/SJTU-DDST/coverbs-rpc.git")
    add_versions("0.1.0", "1268063af22171265e43d6e8dc6a6b836122d827")
	add_versions("0.1.1", "d14fb56d430c0c97c58cf9073967619d9f093e1c")

    add_configs("tests", {default = false, description = "Build tests programs"})

    on_install(function (package)
        if package:version_str() == "dev" then
          print("coverbs-rpc(in-dev) on_install + git.pull")
          os.exec("git pull")
        end
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end
        configs.tests = package:config("tests")
        import("package.tools.xmake").install(package, configs)
    end)
package("cppcoro-20")
    set_urls("https://github.com/andreasbuhr/cppcoro.git")
    on_install("linux", function(package)
        local configs = {}
        import("package.tools.cmake").install(package, configs)
    end)
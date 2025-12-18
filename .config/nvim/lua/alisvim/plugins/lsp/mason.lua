return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            -- list of servers for mason to install
            ensure_installed = {
                "pyright",
                "clangd",
                "lua_ls",
                "stylua",
            },
        },
        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {
                    ui = {
                        icons = {
                            package_installed = "✓",
                            package_pending = "➜",
                            package_uninstalled = "✗",
                        },
                    },
                },
            },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "pylint",
            },
        },
        dependencies = {
            "mason-org/mason.nvim",
        },
    },
}

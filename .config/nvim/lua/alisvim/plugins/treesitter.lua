return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    branch = "master",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        -- import nvim-treesitter plugin
        local treesitter = require("nvim-treesitter.configs")

        -- configure treesitter
        treesitter.setup({
            -- enable syntax highlighting
            highlight = {
                enable = true,
            },
            -- enable indentation
            indent = { enable = true },
            -- enable autotagging (w/ nvim-ts-autotag plugin)
            autotag = {
                enable = true,
            },
            -- ensure these language parsers are installed
            ensure_installed = {
                "json",
                "html",
                "markdown",
                "markdown_inline",
                "lua",
                "vim",
                "gitignore",
                "vimdoc",
                "c",
                "cpp",
                "python",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<Tab>",
                    node_incremental = "<Tab>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end,
}

vim.pack.add({
    "https://github.com/nvim-lualine/lualine.nvim",
})

require("lualine").setup({
    options = {
        theme = "palenight",
    },
    sections = {
        lualine_b = {
            "branch",
            "diff",
            {
                "diagnostics",
                symbols = {
                    error = " ",
                    warn  = " ",
                    info  = " ",
                },
            },
        },
    },
})

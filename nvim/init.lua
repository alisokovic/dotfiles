-- vim ui2
require("vim._core.ui2").enable({
    enable = true,
    msg = {
        target = "cmd",
        pager  = { height = 0.5 },
        dialog = { height = 0.5 },
        cmd    = { height = 0.5 },
        msg    = { height = 0.5, timeout = 4500 },
    },
})

vim.cmd.colorscheme "alistheme"

-- Core Config
require("alisvim.core.options")
require("alisvim.core.autocmds")
require("alisvim.core.keymaps")
require("alisvim.core.pack")

-- Plugins Config
require("alisvim.plugins.mini")
require("alisvim.plugins.treesitter")
require("alisvim.plugins.bars")
require("alisvim.plugins.dashboard")
require("alisvim.plugins.interface")
require("alisvim.plugins.nvim-tree")
require("alisvim.plugins.telescope")
require("alisvim.plugins.completion")
require("alisvim.plugins.lsp")
require("alisvim.plugins.diagnostics")
require("alisvim.plugins.editing")
require("alisvim.plugins.git")
require("alisvim.plugins.debug")

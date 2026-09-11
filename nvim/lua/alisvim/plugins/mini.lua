vim.pack.add({
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
})

---- Mini Icons ----
local MiniIcons = require("mini.icons")
MiniIcons.setup()
MiniIcons.tweak_lsp_kind()

---- Mini Pairs ----
require("mini.pairs").setup()

---- Mini Indentscope ----
require("mini.indentscope").setup({
    symbol = "│",
    options = { try_as_border = true },
})

---- Mini Surround ----
-- Default Keymaps
-- | `sa` | Add surrounding or Direct with 'saiw' |
-- | `sd` | Delete surrounding |
-- | `sr` | Replace surrounding |
-- | `sf` | Find surrounding (right) |
-- | `sF` | Find surrounding (left) |
-- | `sh` | Highlight surrounding |
-- | `sn` | Update n_lines |
-- | `l` / `n` | as suffix for prev/next |
require("mini.surround").setup()

---- Mini Move ----
require("mini.move").setup({
    mappings = {
        -- Move visual selection in visual mode
        left = "<M-Left>",
        right = "<M-Right>",
        up = "<M-Up>",
        down = "<M-Down>",

        -- Move current line in normal mode
        line_left = "<M-Left>",
        line_right = "<M-Right>",
        line_up = "<M-Up>",
        line_down = "<M-Down>",
    },
})

---- Mini Jump ----
require("mini.jump").setup()

---- Mini CmdLine Completion ----
require("mini.cmdline").setup({
    autocorrect = { enable = false },
})

---- Mini Completions ---- 
require("mini.completion").setup({
    lsp_completion = {
        auto_setup = true,
    },
    window = {
        info      = { border = "rounded" },
        signature = { border = "rounded" },
    },
})

---- Mini Snippets ----
local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
    snippets = {
        MiniSnippets.gen_loader.from_lang(), -- loads friendly-snippets
    },
    mappings = {
        expand = "<C-j>",
        jump_next = "<Tab>",
        jump_prev = "<S-Tab>",
        stop = "<Esc>",
    },
})
MiniSnippets.start_lsp_server({ match = false })


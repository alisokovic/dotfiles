vim.pack.add({
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
})

---- Mini Notify ----
require("mini.notify").setup({
    -- only show messages
    content = {
        format = function(notif)
            return notif.msg
        end,
    },
})

---- Mini CmdLine Completion ----
require("mini.cmdline").setup({
    autocorrect = { enable = false },
})

---- Mini Surround ----
require("mini.surround").setup()
-- Default Keymaps
-- | `sa` | Add surrounding or Direct with 'saiw' |
-- | `sd` | Delete surrounding |
-- | `sr` | Replace surrounding |
-- | `sf` | Find surrounding (right) |
-- | `sF` | Find surrounding (left) |
-- | `sh` | Highlight surrounding |
-- | `sn` | Update n_lines |
-- | `l` / `n` | as suffix for prev/next |

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
})
MiniSnippets.start_lsp_server({ match = false })


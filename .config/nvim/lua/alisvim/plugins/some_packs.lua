vim.pack.add({
    "https://github.com/sphamba/smear-cursor.nvim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/folke/trouble.nvim",
    "https://github.com/stevearc/dressing.nvim",
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/kdheepak/lazygit.nvim",
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/szw/vim-maximizer",
    "https://github.com/numtostr/comment.nvim",
    "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})


---- smear cursor ----
require("smear_cursor").setup({
    cursor_color = "#C4206F",
})

---- autopairs ----
require("nvim-autopairs").setup({
    check_ts = true,
    ts_config = {
        lua = { "string" },
    },
})

---- which key ----
vim.o.timeout = true
vim.o.timeoutlen = 500
require("which-key").setup()

---- indent blankline ----
require("ibl").setup({
    indent = { char = "┊" },
})

---- trouble ----
require("trouble").setup({
    focus = true,
})

vim.keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>",              { desc = "Open trouble workspace diagnostics" })
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Open trouble document diagnostics" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<CR>",                 { desc = "Open trouble quickfix list" })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>",                  { desc = "Open trouble location list" })
vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>",      { desc = "Open symbols" })
vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<CR>",                     { desc = "Open todos in trouble" })

---- todo comments ----
require("todo-comments").setup()

-- TODO: todo comment
-- HACK: hack comment
-- BUG: bug comment
-- PERF: perf comment
-- NOTE: note comment

---- gitsigns ----
require("gitsigns").setup({
    on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage hunk")
        map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset hunk")

        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")

        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")

        map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
        end, "Blame line")
        map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")

        map("n", "<leader>hd", gs.diffthis, "Diff this")
        map("n", "<leader>hD", function()
            gs.diffthis("~")
        end, "Diff this ~")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
    end,
})

---- lazygit ----
vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "Open lazygit" })

---- bufferline ----
require("bufferline").setup({
    options = {
        mode = "tabs",
        separator_style = "thick",
        always_show_bufferline = false,
        indicator = {
            style = "underline",
        },
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true,
            }
        },
        hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
        },
    },
})

---- vim maximizer ----
vim.keymap.set("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" })

---- comment ----
local comment = require("Comment")
local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

comment.setup({
    pre_hook = ts_context_commentstring.create_pre_hook()
})

---- render markdown ----
require("render-markdown").setup({
    completions = {
        lsp = { enabled = true },
    },
})

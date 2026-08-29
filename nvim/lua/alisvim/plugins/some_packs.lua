vim.pack.add({
    "https://github.com/sphamba/smear-cursor.nvim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/numtostr/comment.nvim",
    "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/rcarriga/nvim-notify",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/folke/trouble.nvim",
    "https://github.com/stevearc/dressing.nvim",
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/akinsho/toggleterm.nvim",
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/kdheepak/lazygit.nvim",
    "https://github.com/szw/vim-maximizer",
    "https://github.com/danymat/neogen",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

---- Colors ----
local palette = {
    text     = "#cdd6f4",
    subtext0 = "#a6adc8",
    overlay1 = "#7f849c",
    surface0 = "#313244",
    mauve    = "#cba6f7",
    blue     = "#89b4fa",
    red      = "#f38ba8",
    yellow   = "#f9e2af",
    peach    = "#fab387",
    cursor   = "#C4206F",
    none     = "NONE",
}

---- Smear Cursor ----
require("smear_cursor").setup({
    cursor_color = palette.cursor,
})

---- Autopairs ----
require("nvim-autopairs").setup({
    check_ts = true,
    ts_config = {
        lua = { "string" },
    },
})

---- Comment ----
local comment = require("Comment")
local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

comment.setup({
    pre_hook = ts_context_commentstring.create_pre_hook()
})

---- Which Key ----
vim.o.timeout = true
vim.o.timeoutlen = 500
require("which-key").setup({
    win = {
        border = "rounded",
    },
})

---- Indent Blankline ----
require("ibl").setup({
    indent = { char = "┊" },
})

---- Notify ----
local notify = require("notify")
notify.setup({
    timeout = 3000,
    background_colour = "#000000"
})
vim.notify = notify

vim.keymap.set("n", "<leader>nn", function()
    notify.dismiss({ silent = true, pending = true })
end, { desc = "Dismiss all notifications" })

---- Trouble ----
require("trouble").setup({
    focus = true,
})

vim.keymap.set(
    "n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",
    { desc = "Workspace trouble diagnostics" }
)
vim.keymap.set(
    "n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
    { desc = "Buffer trouble diagnostics" }
)
vim.keymap.set(
    "n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>",
    { desc = "Trouble symbols" }
)
vim.keymap.set(
    "n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
    { desc = "Trouble LSP references" }
)
vim.keymap.set(
    "n", "<leader>xL", "<cmd>Trouble loclist toggle<CR>",
    { desc = "Trouble location list" }
)
vim.keymap.set(
    "n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>",
    { desc = "Open trouble quickfix list" }
)
vim.keymap.set(
    "n", "<leader>xt", "<cmd>Trouble todo toggle<CR>",
    { desc = "Open todos in trouble" }
)

---- Bufferline ----
require("bufferline").setup({
    options = {
        mode = "tabs",
        separator_style = "thin",
        show_buffer_close_icons = true,
        show_close_icon = false,
        always_show_bufferline = false,
        diagnostics = "nvim_lsp",

        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and "" or ""
            return icon .. " " .. count
        end,

        -- Align tabline cleanly with NvimTree sidebar
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "center",
                separator = true,
            }
        },
    },

    highlights = {
    -- Transparent Bar Fill
    fill = { bg = palette.none },

    -- Unselected / Inactive Tabs (Floating Text, No Dark Boxes)
    background             = { fg = palette.overlay1, bg = palette.none },
    buffer_visible         = { fg = palette.subtext0, bg = palette.none },
    close_button           = { fg = palette.overlay1, bg = palette.none },
    close_button_visible   = { fg = palette.subtext0, bg = palette.none },
    separator              = { fg = palette.surface0, bg = palette.none },
    separator_visible      = { fg = palette.surface0, bg = palette.none },
    modified               = { fg = palette.peach, bg = palette.none },
    modified_visible       = { fg = palette.peach, bg = palette.none },

    -- Active / Selected Tab
    buffer_selected        = { fg = palette.text, bg = palette.none, bold = true },
    close_button_selected  = { fg = palette.red, bg = palette.none },
    separator_selected     = { fg = palette.surface0, bg = palette.none },
    indicator_selected     = { fg = palette.mauve, bg = palette.none },
    modified_selected      = { fg = palette.peach, bg = palette.none },

    -- Diagnostics inside Tabs
    error             = { fg = palette.red, bg = palette.none },
    error_selected    = { fg = palette.red, bg = palette.none, bold = true },
    warning           = { fg = palette.yellow, bg = palette.none },
    warning_selected  = { fg = palette.yellow, bg = palette.none, bold = true },
    },
})

---- Toggle-Term ----
require("toggleterm").setup({
    direction = "float",
    size = function(term)
        if term.direction == "horizontal" then
            return 16
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    shade_terminals = false,
    highlights = {
        FloatBorder = {
            guifg = palette.blue,
            guibg = palette.none,
        },
    },
    float_opts = {
        border = "curved",
    }
})

vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>",   { desc = "vertical terminal"})
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "horizontal terminal" })
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>",      { desc = "float terminal" })
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>",        { desc = "terminal in new tab" })

---- Todo Comments ----
require("todo-comments").setup()

-- TODO: todo comment
-- HACK: hack comment
-- BUG: bug comment
-- PERF: perf comment
-- NOTE: note comment

---- Gitsigns ----
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

---- Lazygit ----
vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "Open lazygit" })


---- Vim Maximizer ----
vim.keymap.set("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" })

---- Neogen ----
local neogen = require("neogen")
neogen.setup({
    enabled = true,
    languages = {
        cpp = {
            template = {
                annotation_convention = "doxygen", --- forces doxygen style
            },
        },
    },
})

vim.keymap.set("n", "<leader>k", "<cmd>lua require('neogen').generate()<CR>", { desc = "Generate neogen documentation" })

---- Render Markdown ----
require("render-markdown").setup({
    completions = {
        lsp = { enabled = true },
    },
})

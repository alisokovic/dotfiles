---- Dependencies ----
vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
})

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        path_display = { "smart" },
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,   -- move to prev result
                ["<C-j>"] = actions.move_selection_next,       -- move to next result
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
})

--- Load extensions
telescope.load_extension("fzf")
telescope.load_extension("notify")

---- Keymaps ----
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files,          { desc = "Fuzzy find files in cwd" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles,            { desc = "Fuzzy find recent files" })
vim.keymap.set("n", "<leader>fs", builtin.live_grep,           { desc = "Find string in cwd" })
vim.keymap.set("n", "<leader>fc", builtin.grep_string,         { desc = "Find string under cursor in cwd" })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>",    { desc = "Find todos" })  -- requires todo-comments.nvim
vim.keymap.set("n", "<leader>fb", builtin.buffers,             { desc = "List open buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags,           { desc = "Search help tags" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps,             { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>fo", builtin.vim_options,         { desc = "Search vim options" })
vim.keymap.set("n", "<leader>fn", "<cmd>Telescope notify<CR>", { desc = "Search notification history" })

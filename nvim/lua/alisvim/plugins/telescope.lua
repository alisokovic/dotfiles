-- Build telescope-fzf-native after installation or update
vim.api.nvim_create_autocmd("PackChanged", {
    pattern = "telescope-fzf-native.nvim",
    callback = function(ev)
        local fzf_dir = vim.fs.joinpath(
            vim.fn.stdpath("data"),
            "site", "pack", "core", "opt",
            "telescope-fzf-native.nvim"
        )

        local kind = ev.data.kind
        if kind == "install" or kind == "update" then
            vim.notify("Building telescope-fzf-native...", vim.log.levels.INFO)
            vim.system({ "make" }, { cwd = fzf_dir }, function(obj)
                if obj.code == 0 then
                    vim.notify("telescope-fzf-native built succesfully!", vim.log.levels.INFO)
                else
                    vim.notify("Failed to build telescope-fzf-native:\n" .. obj.stderr, vim.log.levels.ERROR)
                end
            end)
        end
    end,
})

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
                ["<C-v>"] = false,
                ["<C-s>"] = actions.select_vertical,
            },
            n = {
                ["<C-v>"] = false,
                ["<C-s>"] = actions.select_vertical,
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
vim.keymap.set("n", "<leader>fo", builtin.vim_options,         { desc = "Search vim opions" })
vim.keymap.set("n", "<leader>fn", "<cmd>Telescope notify<CR>", { desc = "Search notification history" })  -- requires nvim-notify

-- Keymaps when LSP is attached
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        vim.keymap.set("n", "<leader>fd",
            builtin.diagnostics,
            { buffer = ev.buf, desc = "Workspace diagnostics" }
        )
    end
})

-- Helper function to compile telescope-fzf-native
local function build_fzf(dir)
    vim.notify("Building telescope-fzf-native...", vim.log.levels.INFO)
    local res = vim.system({ "make" }, { cwd = dir }):wait()
    if res.code == 0 then
        vim.notify("telescope-fzf-native built successfully!", vim.log.levels.INFO)
    else
        vim.notify("Failed to build telescope-fzf-native:\n" .. (res.stderr or ""), vim.log.levels.ERROR)
    end
end

-- Hook for future installs & updates via vim.pack
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
        local name = ev.data.spec and ev.data.spec.name
        local kind = ev.data.kind
        if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
            build_fzf(ev.data.path)
        end
    end,
})

vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
})

-- Fallback: Build once if binary is currently missing
local fzf_path = vim.fs.joinpath(
    vim.fn.stdpath("data"),
    "site", "pack", "core", "opt",
    "telescope-fzf-native.nvim"
)
if vim.uv.fs_stat(fzf_path) and not vim.uv.fs_stat(vim.fs.joinpath(fzf_path, "build", "libfzf.so")) then
    build_fzf(fzf_path)
end

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
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { buffer = ev.buf, desc = "Workspace diagnostics" })
    end,
})

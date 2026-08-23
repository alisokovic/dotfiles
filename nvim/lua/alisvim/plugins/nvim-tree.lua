-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add({
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' }, -- optional
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
})

local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
        }
    end

    -- Apply the default mappings first
    api.config.mappings.default_on_attach(bufnr)

    -- Remove the default <C-v> mapping
    vim.keymap.del("n", "<C-v>", { buffer = bufnr })

    -- Remap vertical split to another key
    vim.keymap.set("n", "<C-s>", api.node.open.vertical, opts("Open: Vertical Split"))
end


require("nvim-tree").setup({
    on_attach = my_on_attach,
    view = {
        width = 33,
        relativenumber = true,
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
        icons = {
            glyphs = {
                folder = {
                    arrow_closed = "", -- arrow when folder is closed
                    arrow_open = "", -- arrow when folder is open
                },
            },
        },
    },
    actions = {
        open_file = {
            window_picker = {
                enable = false,
            },
        },
    },
    filters = {
        custom = { ".DS_Store" },
    },
    git = {
        ignore = false,
    },
})

-- Keymaps
vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>",         { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>",       { desc = "Collapse file explorer" })
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>",        { desc = "Refresh file explorer" })

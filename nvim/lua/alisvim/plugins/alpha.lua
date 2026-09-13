vim.pack.add({
    "https://github.com/goolord/alpha-nvim",
})

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
}

-- Set header color (as the same as lualine)
local lualine_hl = vim.api.nvim_get_hl(0, { name = "lualine_a_normal" })
vim.api.nvim_set_hl(0, "AlphaHeader", { fg = lualine_hl.bg, bold = true })
dashboard.section.header.opts.hl = "AlphaHeader"

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button("n", "  > New File", "<cmd>ene<CR>"),
    dashboard.button("e", "  > File Tree", "<cmd>NvimTreeToggle<CR>"),
    dashboard.button("f", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
    dashboard.button("r", "  > Recent Files", "<cmd>Telescope oldfiles<CR>"),
    dashboard.button("w", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
    dashboard.button("d", "󰒡  > Todo List", "<cmd>TodoTelescope<CR>"),
    dashboard.button("g", "  > LazyGit", "<cmd>LazyGit<CR>"),
    dashboard.button("m", "󰒲  > Mason", "<cmd>Mason<CR>"),
    dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
}

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    callback = function()
        vim.opt_local.foldenable = false
    end,
})

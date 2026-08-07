vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/nvimdev/lspsaga.nvim",
})

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
        border = "rounded",
    };
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "clangd",
        "bashls",
        "html",
        "marksman",
    },
    automatic_installation = true,
})

local severity = vim.diagnostic.severity

vim.diagnostic.config({
    virtual_text = true,
    signs = {
        text = {
            [severity.ERROR] = "",
            [severity.WARN] = "",
            [severity.HINT] = "󰠠",
            [severity.INFO] = "",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.enable({
    "lua_ls",
    "pyright",
    "clangd",
    "bashls",
    "html",
    "marksman",
})

---- LspSaga ----
local lspsaga = require("lspsaga")
lspsaga.setup({
    symbol_in_winbar = {
        enable = false,
    },
    code_action = {
        show_server_name = true,
    },
    hover = {
        open_link = "gx",
        border = "rounded",
    },
    implement = {
        enable = false,
    },
    lightbulb = {
        enable = false,
    },
    ui = {
        theme = "serif",
    },
})

---- Keymaps - Attached only when an LSP connects to buffer
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local keymap = vim.keymap
        local opts = { buffer = ev.buf }

        keymap.set("n", "gd",          vim.lsp.buf.definition,              vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        keymap.set("n", "<leader>gd",  "<cmd>Lspsaga peek_definition<CR>",  vim.tbl_extend("force", opts, { desc = "Lspsaga definition" }))
        keymap.set("n", "<leader>gs",  "<cmd>Lspsaga outline<CR>",          vim.tbl_extend("force", opts, { desc = "Lspsaga outline" }))
        keymap.set("n", "gD",          vim.lsp.buf.declaration,             vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
        keymap.set("n", "gr",          vim.lsp.buf.references,              vim.tbl_extend("force", opts, { desc = "Show references" }))
        keymap.set("n", "gi",          vim.lsp.buf.implementation,          vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
        keymap.set("n", "K",           "<cmd>Lspsaga hover_doc<CR>",        vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
        keymap.set("n", "<leader>rn",  vim.lsp.buf.rename,                  vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
        keymap.set("n", "<leader>ca",  "<cmd>Lspsaga code_action<CR>",      vim.tbl_extend("force", opts, { desc = "Code actions" }))
        keymap.set("n", "<leader>f",   vim.lsp.buf.format,                  vim.tbl_extend("force", opts, { desc = "Format buffer" }))
        keymap.set("n", "<leader>df",  vim.diagnostic.open_float,           vim.tbl_extend("force", opts, { desc = "Show line diagnostic" }))
        keymap.set("n", "]d",          vim.diagnostic.goto_next,            vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
        keymap.set("n", "[d",          vim.diagnostic.goto_prev,            vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
    end,
})

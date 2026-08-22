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

local capabilities = require("mini.completion").get_lsp_capabilities()
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
    implement = {
        enable = false,
    },
    lightbulb = {
        enable = false,
    },
    ui = {
        theme = "serif",
        border = "rounded",
    },
})

---- Keymaps - Attached only when an LSP connects to buffer
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local map = function(mode, lfs, rhs, desc)
            vim.keymap.set(mode, lfs, rhs, { buffer = ev.buf, desc = desc})
        end

        map("n", "gd",          vim.lsp.buf.definition,               "Go to definition")
        map("n", "<leader>gd",  "<cmd>Lspsaga peek_definition<CR>",   "Lspsaga definition")
        map("n", "<leader>gs",  "<cmd>Lspsaga outline<CR>",           "Lspsaga outline")
        map("n", "gD",          vim.lsp.buf.declaration,              "Go to declaration")
        map("n", "gr",          vim.lsp.buf.references,               "Show references")
        map("n", "gi",          vim.lsp.buf.implementation,           "Go to implementation")
        map("n", "<leader>rn",  vim.lsp.buf.rename,                   "Rename symbol")
        map("n", "<leader>ca",  "<cmd>Lspsaga code_action<CR>",       "Code actions")
        map("n", "<leader>f",   vim.lsp.buf.format,                   "Format buffer")
        map("n", "<leader>df",  vim.diagnostic.open_float,            "Show line diagnostic")
        map("n", "]d",          vim.diagnostic.goto_next,             "Next diagnostic")
        map("n", "[d",          vim.diagnostic.goto_prev,             "Previous diagnostic")

        map("n", "K", function()
            vim.lsp.buf.hover({
                border = "rounded",
            })
        end, "LSP hover")

        map({"n", "i"}, "<C-s>", function()
            vim.lsp.buf.signature_help({
                border = "rounded",
            })
        end, "Signature help")

    end,
})

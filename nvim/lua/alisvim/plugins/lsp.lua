vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/saghen/blink.lib",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/xzbdmw/colorful-menu.nvim",
    "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
    "https://github.com/nvimdev/lspsaga.nvim",
    "https://github.com/stevearc/conform.nvim",
})

---- Mason ----
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
        "basedpyright",
        "ruff",
        "clangd",
        "bashls",
        "marksman",
    },
    automatic_installation = true,
    automatic_enable = false,
})

require("mason-tool-installer").setup({
    ensure_installed = {
        "stylua",
        "clang-format",
    },
    auto_update = false,
    run_on_start = true,
})

---- Nvim-lspconfig ----
vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
    root_markers = { ".git" },
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = { "lua/?.lua", "lua/?/init.lua" },
            },
            diagnostic = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/luv/library",
                },
            },
            hint = { enable = true },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "standard",
            },
        },
    },
})

vim.lsp.config("ruff", {
    on_attach = function(client)
        client.server_capabilities.hoverProvider = false
    end,
})

vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
        "--query-driver=/usr/bin/gcc,/usr/bin/g++",
    },
    root_markers = {
        "compile_commands.json",
        "compile_flags.txt",
        ".clangd",
        ".git",
    },
})

vim.lsp.enable({
    "lua_ls",
    "basedpyright",
    "ruff",
    "clangd",
    "bashls",
    "marksman",
})

---- Blink Completion ----
local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
    completion = {
        trigger = {
            show_on_blocked_trigger_characters = { " ", "\n", "\t", "<", ">" },
        },
        list = {
            selection = { preselect = true, auto_insert = false },
        },
        menu = {
            border = "rounded",
            draw = {
                columns = { { "label", gap = 1 }, { "kind_icon", "kind", gap = 1 }, },
                components = {
                    label = {
                        text = function (ctx)
                            return require("colorful-menu").blink_components_text(ctx)
                        end,
                        highlight = function(ctx)
                            return require("colorful-menu").blink_components_highlight(ctx)
                        end,
                    },
                    kind_icon = {
                        text = function(ctx)
                            local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                            return kind_icon
                        end,
                        highlight = function(ctx)
                            local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                            return hl
                        end,
                    },
                    kind = {
                        highlight = function(ctx)
                            local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                            return hl
                        end,
                    },
                },
            },
            auto_show = function()
                local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                local ok, node = pcall(vim.treesitter.get_node, { pos = { row - 1, math.max(col - 1, 0) } })
                if not ok or not node then return true end
                local t = node:type()
                return not (t:find("comment") or t:find("string"))
            end,
        },
        documentation = {
            auto_show = true,
            window = { border = "rounded" },
        },
        ghost_text = {
            enabled = true,
            show_without_menu = false,
        },
    },
    keymap = {
        preset = "enter",
        ["<CR>"] = { "select_and_accept", "fallback" },
    },
    signature = {
        enabled = true,
        window = { border = "rounded" },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    snippets = { preset = "mini_snippets" },
})

---- LspSaga ----
require("lspsaga").setup({
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

---- Diagnostics ----
local severity = vim.diagnostic.severity

vim.diagnostic.config({
    virtual_text = false,
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

---- Tiny-Inline-Diagnostic ----
require("tiny-inline-diagnostic").setup({
    signs = {
        left = "",
        right = "",
        arrow = "  ",
        up_arrow = "  ",
        vertical = " │",
        vertical_end = " └",
    },
    options = {
        use_icons_from_diagnostic = true,
        multilines = {
            enabled = true,
            always_show = false,
        },
    },
})

---- Conform ----
local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    notify_on_error = true,
    notify_no_formatters = true,
})

---- Keymaps - Attached only when an LSP connects to buffer
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local map = function(mode, lfs, rhs, desc)
            vim.keymap.set(mode, lfs, rhs, { buffer = ev.buf, desc = desc })
        end

        map("n", "gd",          vim.lsp.buf.definition,             "Go to definition")
        map("n", "<leader>gd",  "<cmd>Lspsaga peek_definition<CR>", "Lspsaga definition")
        map("n", "<leader>gs",  "<cmd>Lspsaga outline<CR>",         "Lspsaga outline")
        map("n", "gD",          vim.lsp.buf.declaration,            "Go to declaration")
        map("n", "gr",          vim.lsp.buf.references,             "Show references")
        map("n", "gi",          vim.lsp.buf.implementation,         "Go to implementation")
        map("n", "<leader>rn",  vim.lsp.buf.rename,                 "Rename symbol")
        map("n", "<leader>ca",  "<cmd>Lspsaga code_action<CR>",     "Code actions")

        map("n", "K", function()
            vim.lsp.buf.hover({
                border = "rounded",
            })
        end, "LSP hover")

        map("n", "<leader>ci", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, "Toggle inlay hints")

        map({"n", "x"}, "<leader>cf", function()
            conform.format({
                async = true,
                lsp_format = "fallback",
            })
        end, "Format buffer")

    end,
})

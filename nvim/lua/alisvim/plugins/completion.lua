vim.pack.add({
    "https://github.com/saghen/blink.lib",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/xzbdmw/colorful-menu.nvim",
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
        ["<C-b>"] = { "scroll_documentation_up", "scroll_signature_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "scroll_signature_down", "fallback" },
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

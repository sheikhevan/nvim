vim.pack.add({
    { src = "https://github.com/Saghen/blink.cmp", version = "v1.8.0" }
})

require('blink-cmp').setup({
    keymap = {
        preset = 'default',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },
    },

    appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono'
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    completion = {
        menu = {
            enabled = true,
            min_width = 15,
            max_height = 10,
            winblend = 0,
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
            border = 'none',
            draw = {
                columns = {
                    { "kind_icon", "label", "label_description", gap = 1 },
                },
                components = {
                    kind_icon = {
                        text = function(ctx)
                            local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                            return kind_icon
                        end,
                        -- (optional) use highlights from mini.icons
                        highlight = function(ctx)
                            local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                            return hl
                        end,
                    },
                    kind = {
                        -- (optional) use highlights from mini.icons
                        highlight = function(ctx)
                            local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                            return hl
                        end,
                    }
                }
            }
        },
        documentation = { window = { border = 'single', winblend = 0, winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu', } },
        -- ghost_text = { enabled = true },
    },
    signature = { window = { border = 'none' } },
})

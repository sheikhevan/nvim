vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" }
})

require("mini.comment").setup()

require("mini.surround").setup({
    mappings = {
        add = 'sa',        -- Add surrounding in Normal and Visual modes
        delete = 'sd',     -- Delete surrounding
        find = 'sf',       -- Find surrounding (to the right)
        find_left = 'sF',  -- Find surrounding (to the left)
        highlight = 'sh',  -- Highlight surrounding
        replace = 'sr',    -- Replace surrounding

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
    },
})

require("mini.diff").setup({
    mappings = {
        -- Apply hunks inside a visual/operator region
        apply = 'gh',

        -- Reset hunks inside a visual/operator region
        reset = 'gH',

        -- Hunk range textobject to be used inside operator
        -- Works also in Visual mode if mapping differs from apply and reset
        textobject = 'gh',

        -- Go to hunk range in corresponding direction
        goto_first = '[H',
        goto_prev = '[h',
        goto_next = ']h',
        goto_last = ']H',
    },
})

require("mini.git").setup()

require("mini.hipatterns").setup({
    highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
    },
})

require("mini.icons").setup()
require("mini.icons").tweak_lsp_kind()

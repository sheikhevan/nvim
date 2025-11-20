vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
    { src = "https://github.com/RRethy/nvim-treesitter-endwise" },
})

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    ensure_installed = {
        "lua",
        "c",
        "cpp",
        "markdown",
        "markdown_inline",
        "vim",
        "bash",
        "gitignore",
        "rust",
        "typst",
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
        },
    },
    textobjects = {
        select = {
            enable = true,

            lookahead = true,

            keymaps = {
                ["a="] = { query = "@assignment.outer", desc = "select outer part of an assignment" },
                ["i="] = { query = "@assignment.inner", desc = "select inner part of an assignment" },

                ["aa"] = { query = "@parameter.outer", desc = "select outer part of a parameter/argument" },
                ["ia"] = { query = "@parameter.inner", desc = "select inner part of a parameter/argument" },

                ["ai"] = { query = "@conditional.outer", desc = "select outer part of a conditional" },
                ["ii"] = { query = "@conditional.inner", desc = "select inner part of a conditional" },

                ["al"] = { query = "@loop.outer", desc = "select outer part of a loop" },
                ["il"] = { query = "@loop.inner", desc = "select inner part of a loop" },

                ["af"] = { query = "@call.outer", desc = "select outer part of a function call" },
                ["if"] = { query = "@call.inner", desc = "select inner part of a function call" },

                ["am"] = { query = "@function.outer", desc = "select outer part of a method/function definition" },
                ["im"] = { query = "@function.inner", desc = "select inner part of a method/function definition" },

                ["ac"] = { query = "@class.outer", desc = "select outer part of a class" },
                ["ic"] = { query = "@class.inner", desc = "select inner part of a class" },
            },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = { query = "@call.outer", desc = "Next function call start" },
            ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]F"] = { query = "@call.outer", desc = "Next function call end" },
            ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
          },
          goto_previous_start = {
            ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
            ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
            ["[c"] = { query = "@class.outer", desc = "Prev class start" },
            ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
            ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
            ["[C"] = { query = "@class.outer", desc = "Prev class end" },
            ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
            ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
          },
        },
    },
})

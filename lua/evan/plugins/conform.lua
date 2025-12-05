vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
    formatters_by_ft = {
        python = { "ruff_format" },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 250,
        lsp_format = "fallback",
    },
})

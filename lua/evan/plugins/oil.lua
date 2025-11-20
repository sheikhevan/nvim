vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" }
})

require("oil").setup({
    default_file_explorer = true,
    columns = {
        "icon",
        "permissions",
        -- "size",
        -- "mtime",
    },
})

vim.keymap.set('n', '<leader>e', ':Oil<CR>')

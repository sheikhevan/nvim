vim.pack.add({
    { src = "https://github.com/mrcjkb/rustaceanvim" }
})

vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
    },
    -- LSP configuration
    server = {
        on_attach = function(client, bufnr)
            vim.keymap.set(
                "n",
                "ca",
                function()
                    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
                    -- or vim.lsp.buf.codeAction() if you don't want grouping.
                end,
                { silent = true, buffer = bufnr }
            )
            vim.keymap.set(
                "n",
                "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
                function()
                    vim.cmd.RustLsp({ 'hover', 'actions' })
                end,
                { silent = true, buffer = bufnr }
            )
        end,
        default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
            },
        },
    },
}

vim.cmd.packadd('rustaceanvim')

vim.lsp.enable({
    "lua_ls",
    "bashls",
    "tinymist",
    "ts_ls",
    "astro",
    "tailwindcss",
})

vim.diagnostic.config({
    -- virtual_lines = true,
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        true,
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})

-- keymaps
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { silent = true, noremap = true, desc = "lsp hover" })
vim.keymap.set("n", "gd", "<cmd>tab split | lua vim.lsp.buf.definition()<cr>",
    { silent = true, noremap = true, desc = "lsp go to definition" })
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>",
    { silent = true, noremap = true, desc = "lsp view references" })
vim.keymap.set("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<cr>",
    { silent = true, noremap = true, desc = "lsp go to implementation" })
vim.keymap.set("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<cr>",
    { silent = true, noremap = true, desc = "lsp go to type definiton" })
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>",
    { silent = true, noremap = true, desc = "lsp go to declaration" })
vim.keymap.set("n", "cr", "<cmd>lua vim.lsp.buf.rename()<cr>",
    { silent = true, noremap = true, desc = "lsp rename symbol" })
vim.keymap.set("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<cr>",
    { silent = true, noremap = true, desc = "lsp code actions" })

vim.keymap.set("n", "<leader>xx", "<cmd>lua vim.diagnostic.open_float()<cr>",
    { silent = true, noremap = true, desc = "show line diagnostics" })
vim.keymap.set("n", "<leader>xX", "<cmd>lua vim.diagnostic.setloclist()<cr>",
    { silent = true, noremap = true, desc = "show all diagnostics in location list" })
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>",
    { silent = true, noremap = true, desc = "go to previous diagnostic" })
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>",
    { silent = true, noremap = true, desc = "go to next diagnostic" })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ async = false, bufnr = args.buf })
                end,
            })
        end
    end,
})

-- completion
-- vim.opt.shortmess:append("c")

-- local function setup_completion_mappings(bufnr)
--     vim.keymap.set('i', '<Tab>', function()
--         return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
--     end, { expr = true, buffer = bufnr })
--
--     vim.keymap.set('i', '<S-Tab>', function()
--         return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
--     end, { expr = true, buffer = bufnr })
--
--     vim.keymap.set('i', '<CR>', function()
--         return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
--     end, { expr = true, buffer = bufnr })
--
--     -- trigger completion menu on backspace
--     vim.keymap.set('i', '<BS>', '<BS><C-r>=pumvisible() ? "" : "<C-x><C-o>"<CR>',
--         { expr = false, buffer = bufnr, silent = true })
-- end
--
-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(args)
--         local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--         if client:supports_method('textDocument/completion') then
--             -- Optional: trigger autocompletion on EVERY keypress. May be slow!
--             local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
--             client.server_capabilities.completionProvider.triggerCharacters = chars
--             vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--
--             setup_completion_mappings(args.buf)
--
--             -- format on save if server supports it
--             if client:supports_method('textDocument/formatting') then
--                 vim.api.nvim_create_autocmd('BufWritePre', {
--                     buffer = args.buf,
--                     callback = function()
--                         -- range = nil → entire buffer
--                         vim.lsp.buf.format({ async = false, bufnr = args.buf })
--                     end,
--                 })
--             end
--         end
--     end,
-- })

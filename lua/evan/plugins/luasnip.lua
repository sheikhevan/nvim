vim.pack.add({
    { src = "https://github.com/L3MON4D3/LuaSnip" }
})

local ls = require("luasnip")


ls.setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

vim.keymap.set("i", "<C-e>", function()
        if ls.expand_or_jumpable() then
            ls.expand_or_jump()
        end
    end,
    { silent = true })
vim.keymap.set({ "i", "s" }, "<C-j>", function()
        ls.jump(1)
    end,
    { silent = true })
vim.keymap.set({ "i", "s" }, "<C-k>", function()
        ls.jump(-1)
    end,
    { silent = true })

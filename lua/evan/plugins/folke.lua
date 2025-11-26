vim.pack.add({
    { src = "https://github.com/folke/flash.nvim" },
})

require("flash").setup()

vim.keymap.set({ "n", "x", "o" }, "s", function()
    require("flash").jump()
end, { desc = "jump with flash" })

vim.keymap.set({ "n", "x", "o" }, "S", function()
    require("flash").treesitter()
end, { desc = "jump to treesitter nodes with flash" })

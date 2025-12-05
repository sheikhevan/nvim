vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" }
})

require("snacks").setup({
    zen = {
        enabled = true,
    },
    image = {
        enabled = true,
        doc = {
            inline = false,
            float = true,
        },
        resolve = function(path, src)
            if require("obsidian.api").path_is_note(path) then
                return require("obsidian.api").resolve_image_path(src)
            end
        end,
    },
})

vim.keymap.set("n", "<leader>zz", "<cmd>lua Snacks.zen.zen()<cr>",
    { silent = true, noremap = true, desc = "snacks zen mode" })

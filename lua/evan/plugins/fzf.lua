vim.pack.add({
    { src = "https://github.com/ibhagwan/fzf-lua" }
})

vim.keymap.set("n", "<leader>ff", ":lua require('fzf-lua').files()<CR>", { desc = "fzf-lua files" })
vim.keymap.set("n", "<leader>fb", ":lua require('fzf-lua').buffers()<CR>", { desc = "fzf-lua buffers" })
vim.keymap.set("n", "<leader>ft", ":lua require('fzf-lua').tabs()<CR>", { desc = "fzf-lua tabs" })
vim.keymap.set("n", "<leader>fg", ":lua require('fzf-lua').live_grep_native()<CR>", { desc = "fzf-lua live grep" })
vim.keymap.set("n", "<leader>gc", ":lua require('fzf-lua').git_commits()<CR>", { desc = "fzf-lua git commits" })
vim.keymap.set("n", "<leader>gb", ":lua require('fzf-lua').git_branches()<CR>", { desc = "fzf-lua git branches" })
vim.keymap.set("n", "<leader>fl", ":lua require('fzf-lua').lsp_finder()<CR>", { desc = "fzf-lua lsp finder" })
vim.keymap.set("n", "<leader>fd", ":lua require('fzf-lua').diagnostics_document()<CR>",
    { desc = "fzf-lua document diagnostics" })

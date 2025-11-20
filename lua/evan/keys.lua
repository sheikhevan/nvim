vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- cancel highlighted search
vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", {
    silent = true,
    noremap = true,
    desc = "Clear search highlights"
})

-- select all
vim.keymap.set("n", "<C-a>", "ggVG", {
    silent = true,
    noremap = true,
    desc = "Select all"
})

-- tab management
vim.keymap.set("n", "te", ":tabedit<Return>", {
    silent = true,
    noremap = true,
    desc = "Open a new tab"
})
vim.keymap.set("n", "<tab>", ":tabnext<Return>", {
    silent = true,
    noremap = true,
    desc = "Go to next tab"
})
vim.keymap.set("n", "<s-tab>", ":tabprevious<Return>", {
    silent = true,
    noremap = true,
    desc = "Go to previous tab"
})

-- window management
vim.keymap.set("n", "<leader>sh", ":split<Return>", {
    silent = true,
    noremap = true,
    desc = "Split window horizontally"
})
vim.keymap.set("n", "<leader>sv", ":vsplit<Return>", {
    silent = true,
    noremap = true,
    desc = "Split window vertically"
})
vim.keymap.set("n", "<C-h>", "<C-w>h", {
    silent = true,
    noremap = true,
    desc = "Go to left window"
})
vim.keymap.set("n", "<C-j>", "<C-w>j", {
    silent = true,
    noremap = true,
    desc = "Go to below window"
})
vim.keymap.set("n", "<C-k>", "<C-w>k", {
    silent = true,
    noremap = true,
    desc = "Go to above window"
})
vim.keymap.set("n", "<C-l>", "<C-w>l", {
    silent = true,
    noremap = true,
    desc = "Go to right window"
})
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- terminal management
vim.keymap.set("n", "<M-t>", ":bot term<Return>", {
    silent = true,
    noremap = true,
    desc = "Open new terminal in the bottom"
})
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {
    silent = true,
    noremap = true,
    desc = "Exit terminal mode"
})
vim.keymap.set("t", "<C-h>", ":wincmd h<Return>", {
    silent = true,
    noremap = true,
    desc = "Go to left terminal"
})
vim.keymap.set("t", "<C-j>", ":wincmd j<Return>", {
    silent = true,
    noremap = true,
    desc = "Go to below terminal"
})
vim.keymap.set("t", "<C-k>", ":wincmd k<Return>", {
    silent = true,
    noremap = true,
    desc = "Go to above terminal"
})
vim.keymap.set("t", "<C-l>", ":wincmd l<Return>", {
    silent = true,
    noremap = true,
    desc = "Go to right terminal"
})

-- switch colon and semicolon
vim.keymap.set({ "n", "v", "x" }, ";", ":", {
    silent = true,
    desc = "Switch ; to :"
})
vim.keymap.set({ "n", "v", "x" }, ":", ";", {
    silent = true,
    desc = "Switch : to ;"
})

-- disable arrow keys (trying to get rid of bad habits)
vim.keymap.set({ "n", "i", "v" }, "<Up>", "<Nop>", {
    silent = true,
    noremap = true,
    desc = "Disable up arrow key"
})
vim.keymap.set({ "n", "i", "v" }, "<Down>", "<Nop>", {
    silent = true,
    noremap = true,
    desc = "Disable down arrow key"
})
vim.keymap.set({ "n", "i", "v" }, "<Left>", "<Nop>", {
    silent = true,
    noremap = true,
    desc = "Disable left arrow key"
})
vim.keymap.set({ "n", "i", "v" }, "<Right>", "<Nop>", {
    silent = true,
    noremap = true,
    desc = "Disable right arrow key"
})

-- move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

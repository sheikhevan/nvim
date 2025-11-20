local opt = vim.opt

-- general
opt.confirm = true
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.mouse = ""
opt.timeoutlen = 300
opt.updatetime = 100
opt.redrawtime = 10000
opt.maxmempattern = 20000
opt.virtualedit = "block"
opt.iskeyword:append("-")

-- file handling
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.path:append("**")
opt.encoding = "UTF-8"

-- netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- undo & history
opt.undofile = true
opt.undolevels = 10000

-- spell
opt.spelllang = { "en" }

-- indent
opt.expandtab = true
opt.shiftwidth = 4
opt.shiftround = true
opt.smartindent = true
opt.tabstop = 4
opt.linebreak = true
opt.wrap = false

-- search
opt.ignorecase = true
opt.inccommand = "nosplit"

-- navigation
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.jumpoptions = "view"

-- completion
opt.completeopt = "menu,menuone,fuzzy,noselect"
opt.wildmode = "longest:full,full"

-- window & buffer management
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.winminwidth = 5
opt.modifiable = true

-- folding
opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}
opt.foldlevel = 99

if vim.fn.has("nvim-0.10") == 1 then
    opt.smoothscroll = true
    opt.foldmethod = "expr"
    opt.foldtext = ""
else
    opt.foldmethod = "indent"
end

-- formatting
opt.formatoptions = "jcroqlnt"

-- appearance
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.conceallevel = 2
opt.laststatus = 3
opt.list = true
opt.ruler = false
opt.showmode = true
opt.signcolumn = "yes"
opt.pumheight = 8

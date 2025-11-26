require("evan.opts")
require("evan.keys")
require("evan.lsp")

vim.cmd.packadd 'rustaceanvim'

-- load plugin files
for _, path in ipairs(vim.api.nvim_get_runtime_file("lua/evan/plugins/*.lua", true)) do
    dofile(path)
end

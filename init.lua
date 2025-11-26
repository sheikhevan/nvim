require("evan.opts")
require("evan.keys")
require("evan.lsp")

vim.cmd.packadd 'rustaceanvim'

-- load plugin files (stolen from miroshQa/dotfiles)

local function load_file(path)
    local co = coroutine.running()
    vim.defer_fn(function()
        -- local start = vim.uv.hrtime()
        loadfile(path)()
        -- print(path, " loading time: ", (vim.uv.hrtime() - start) / 1000000, "ms")
        coroutine.resume(co)
    end, 2)
    coroutine.yield()
end

coroutine.wrap(function()
    local groups = {
        vim.api.nvim_get_runtime_file("lua/evan/plugins/*.lua", true),
    }
    for _, files in ipairs(groups) do
        for _, path in ipairs(files) do
            load_file(path)
        end
    end

    local cur_ft = vim.bo.filetype
    for ft, callback in pairs(vim.ftplugin) do
        if ft == cur_ft then
            callback()
        end
        vim.api.nvim_create_autocmd("FileType", {
            pattern = ft,
            callback = callback
        })
    end
end)()

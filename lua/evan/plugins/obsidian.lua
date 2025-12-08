vim.pack.add({
    { src = "https://github.com/obsidian-nvim/obsidian.nvim" },
    { src = "https://github.com/OXY2DEV/markview.nvim" },
})

require("obsidian").setup({
    legacy_commands = false,
    workspaces = {
        {
            name = "Polymath",
            path = "~/ObsidianMD/Polymath",
        },
    },

    notes_subdir = "200 Zettelkasten",

    completion = {
        blink = true,
        min_chars = 2,
    },

    note_id_func = function(title)
        return title or tostring(os.time())
    end,

    frontmatter = {
        func = function(note)
            local out = {
                created = os.date("%Y-%m-%d"),
            }

            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end

            return out
        end,
    },

    daily_notes = {
        folder = "500 Daily",
        date_format = "%Y-%m-%d",
        workdays_only = false,
        template = "Daily.md",
    },

    templates = {
        folder = "000 Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
    },

    attachments = {
        img_folder = "001 Attachments",
    },

    follow_url_func = function(url)
        vim.fn.jobstart({ "xdg-open", url })
    end,
})

vim.keymap.set("n", "<leader>on", "<cmd>Obsidian new<cr>", { desc = "obsidian new Obsidian note" })
vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian new_from_template<cr>",
    { desc = "obsidian new Obsidian note from template" })
vim.keymap.set("n", "<leader>oo", "<cmd>Obsidian open<cr>", { desc = "obsidian open in Obsidian app" })
vim.keymap.set("n", "<leader>ob", "<cmd>Obsidian backlinks<cr>", { desc = "obsidian show backlinks" })
vim.keymap.set("n", "<leader>od", "<cmd>Obsidian today<cr>", { desc = "obsidian open today's note" })
vim.keymap.set("n", "<leader>of", "<cmd>Obsidian search<cr>", { desc = "obsidian search notes" })
vim.keymap.set("n", "gf", function()
    if require("obsidian").util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<cr>"
    else
        return "gf"
    end
end, { noremap = false, expr = true, desc = "follow link" })

-- Paste URL into selection
-- vim.keymap.set("v", "<leader>p", function()
--     vim.cmd('normal! "xy')
--     local selected_text = vim.fn.getreg('x')
--
--     local url = vim.fn.getreg('+')
--
--     local markdown_link = string.format("[%s](%s)", selected_text, url)
--
--     vim.cmd('normal! gv"_c' .. markdown_link)
--     vim.cmd('normal! l')
-- end, { desc = "Paste URL as markdown link" })

-- Paste URL into selection (smart)
vim.keymap.set("v", "p", function()
    local clipboard = vim.fn.getreg('+')

    if clipboard:match("^https?://") then
        vim.cmd('normal! "xy')
        local selected_text = vim.fn.getreg('x')
        local markdown_link = string.format("[%s](%s)", selected_text, clipboard)
        vim.cmd('normal! gv"_c' .. markdown_link)
        vim.cmd('normal! l')
    else
        vim.cmd('normal! gv"' .. vim.v.register .. 'p')
    end
end, { desc = "Paste URL as markdown link" })

require("markview").setup({
    experimental = {
        prefer_nvim = true,
        file_open_command = "tabnew",
    },
    preview = {
        icon_provider = "mini",
    },
    latex = {
        enable = false,
    },
})

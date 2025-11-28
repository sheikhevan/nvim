vim.pack.add({
    { src = "https://github.com/nvim-orgmode/orgmode" },
    { src = "https://github.com/nvim-orgmode/org-bullets.nvim" },
    { src = "https://github.com/0xzhzh/fzf-org.nvim" },
})

local function search_and_insert_contact()
    local contacts_file = vim.fn.expand('~/Org/contacts.org')

    if vim.fn.filereadable(contacts_file) == 0 then
        print("Contacts file not found: " .. contacts_file)
        return
    end

    local lines = vim.fn.readfile(contacts_file)
    local contacts = {}
    local current_contact = nil

    for _, line in ipairs(lines) do
        local name = line:match("^%* (.+) :contact:")
        if name then
            current_contact = { name = name, email = "", phone = "", role = "" }
            table.insert(contacts, current_contact)
        elseif current_contact then
            local email = line:match(":EMAIL:%s*(.+)")
            local phone = line:match(":PHONE:%s*(.+)")
            local role = line:match(":ROLE:%s*(.+)")
            if email then current_contact.email = email end
            if phone then current_contact.phone = phone end
            if role then current_contact.role = role end
        end
    end

    local contact_list = {}
    for i, c in ipairs(contacts) do
        local display = c.name
        if c.role ~= "" then
            display = display .. " (" .. c.role .. ")"
        end
        table.insert(contact_list, display)
    end

    if #contact_list == 0 then
        print("No contacts found")
        return
    end

    vim.ui.select(contact_list, {
        prompt = 'Select contact:',
    }, function(choice, idx)
        if choice and idx then
            local contact = contacts[idx]
            local text = "- " .. contact.name
            if contact.email ~= "" then
                text = text .. " <" .. contact.email .. ">"
            end

            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            vim.api.nvim_buf_set_lines(0, row, row, false, { text })
            vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
        end
    end)
end

require('orgmode').setup({
    -- global
    org_agenda_files = '~/Org/**/*',
    org_default_notes_file = '~/Org/refile.org',
    org_archive_location = 'archive/%s::',
    org_log_into_drawer = "LOGBOOK",
    org_highlight_latex_and_related = "entities",
    org_hide_emphasis_markers = true,

    org_capture_templates = {
        t = {
            description = 'Todo',
            template = '* TODO %?\n  %U',
            target = '~/Org/todo.org'
        },

        s = {
            description = 'Scheduled Todo',
            template = '* TODO %?\n  SCHEDULED: %t\n  %U',
            target = '~/Org/todo.org'
        },

        e = {
            description = 'Event',
            template = '* EVENT %? :event:\n  SCHEDULED: %t\n  %U\n** Attendees\n- \n** Agenda\n- \n',
            target = '~/Org/calendar.org'
        },

        p = {
            description = 'Project',
            template = '* TODO %? :project:\n  %U\n** Goal\n\n** Tasks\n- [ ] \n',
            target = '~/Org/projects.org'
        },

        h = {
            description = 'Homework',
            template =
            '* TODO %^{Assignment name}\n DEADLINE: %^{Due date}t\n  :PROPERTIES:\n  :END:\n  %?',
            target = '~/Org/school/f2025.org',
            headline = '%^{Course name}'
        },

        c = {
            description = 'Contact',
            template = [[
                * %? :contact:
                :PROPERTIES:
                :EMAIL: %(return vim.fn.input("Email: "))
                :PHONE: %(return vim.fn.input("Phone: "))
                :ROLE: %(return vim.fn.input("Role/Title: "))
                :END:
                ** Notes

                ]],
            target = '~/Org/contacts.org'
        },
    },

    mappings = {
        org = {
            org_open_at_point = 'gx',
        }
    }
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "org",
    callback = function()
        vim.keymap.set('n', 'gx', function()
            local line = vim.api.nvim_get_current_line()
            local link = line:match("%[%[file:([^%]]+%.org)")

            if link then
                link = vim.fn.expand(link)
                vim.cmd('tabnew' .. link)
            else
                -- Fallback to default gx behavior for non-org links
                require('orgmode').action('org_mappings.open_at_point')
            end
        end, { buffer = true, desc = "Open org link" })
    end
})

require('org-bullets').setup()

local actions = require("fzf-org.actions")
require("fzf-org").setup({
    orgmode = {
        whence       = false, -- where we should have started from; false means don't care
        where        = "*", -- where to search (options: "*" (all org files), "%" (current file), "." (current headline))
        what         = "headline", -- what to search for

        color_icons  = true, -- whether to colorize entries
        bullet_icons = { "◉", "○", "✸", "✿" }, -- how to display bullets
        todo_icons   = { -- how to display TODO
            default = "   ",
            TODO = "[ ]",
            NEXT = "[➔]",
            WAITING = "[…]",
            PROGRESS = "[~]",
            INPROGRESS = "[~]",
            DONE = "[✓]",
            ABANDONED = "[⨯]",
        },
        show_tags    = true, -- whether to display tags

        -- Other fzf-lua options (see its documentation)
        prompt       = "Org > ",
        headers      = { "actions" },
        actions      = {
            -- Also inherits from fzf.actions.files, e.g., file_edit, file_split, etc.
            ["ctrl-y"] = { actions.yank_link, actions.resume },
        },
    },

    all_headlines = {
    },

    files = {
        where  = "*",
        what   = "file",
        prompt = "Org files > ",
    },

    headlines = {
        whence = "file",
        where  = "%",
        what   = "headline",
        prompt = "Org headlines > ",
    },

    subheadlines = {
        whence = "file",
        where  = ".",
        what   = "headline",
        prompt = "Org headlines > ",
    },

    refile = {
        whence  = "headline",
        where   = "*",
        what    = "headline",
        prompt  = "Org refile > ",
        actions = {
            ["default"] = actions.refile_headline,
        },
    },

    refile_to_file = {
        whence  = "headline",
        where   = "*",
        what    = "file",
        prompt  = "Org refile > ",
        actions = {
            ["default"] = actions.refile_headline,
        },
    },

    refile_to_headline = {
        whence  = "headline",
        where   = "*",
        what    = "headline",
        prompt  = "Org refile > ",
        actions = {
            ["default"] = actions.refile_headline,
        },
    },
})

vim.keymap.set("n", "<leader>og", ":lua require('fzf-org').orgmode()<CR>", { desc = "fzf-org browse" })
vim.keymap.set("n", "<leader>of", ":lua require('fzf-org').files()<CR>", { desc = "fzf-org files" })
vim.keymap.set("n", "<leader>oh", ":lua require('fzf-org').headlines()<CR>",
    { desc = "fzf-org browse headlines in current file" })
vim.keymap.set("n", "<leader>oH", ":lua require('fzf-org').all_headlines()<CR>",
    { desc = "fzf-org browse headlines in all files" })

vim.keymap.set('n', '<leader>oC', search_and_insert_contact,
    { desc = 'insert contact' })

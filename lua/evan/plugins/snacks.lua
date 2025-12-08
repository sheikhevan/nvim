vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" }
})

require("snacks").setup({
    zen = {
        enabled = true,
    },
    image = {
        enabled = true,
        integrations = {
            markdown = true, -- Enable markdown integration
        },
        backend = "ghostty",
        processor = "magick",
        doc = {
            inline = false,
            float = true,
        },
        -- resolve = function(path, src)
        --     if require("obsidian.api").path_is_note(path) then
        --         return require("obsidian.api").resolve_image_path(src)
        --     end
        -- end,
        math = {
            enabled = true, -- enable math expression rendering
            -- in the templates below, `${header}` comes from any section in your document,
            -- between a start/end header comment. Comment syntax is language-specific.
            -- * start comment: `// snacks: header start`
            -- * end comment:   `// snacks: header end`
            typst = {
                tpl = [[
        #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
        #set text(size: 12pt, fill: rgb("${color}"))
        ${header}
        ${content}]],
            },
            latex = {
                font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
                -- for latex documents, the doc packages are included automatically,
                -- but you can add more packages here. Useful for markdown documents.
                packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
                tpl = [[
        \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
        \usepackage{${packages}}
        \begin{document}
        ${header}
        { \${font_size} \selectfont
          \color[HTML]{${color}}
        ${content}}
        \end{document}]],
            },
        },
    },
})

vim.keymap.set("n", "<leader>zz", "<cmd>lua Snacks.zen.zen()<cr>",
    { silent = true, noremap = true, desc = "snacks zen mode" })

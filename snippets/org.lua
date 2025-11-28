local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
    s("new", fmt([[
        #+title: {}
        #+author: Evan Alvarez

        {}
    ]], {
        i(1, "title"),
        i(0),
    })),

    s("todo", fmt([[
        * TODO {}
        {}
    ]], {
        i(1, "task"),
        i(0)
    })),

    s("done", fmt([[
        * DONE {}
        {}
    ]], {
        i(1, "task"),
        i(0)
    })),
}

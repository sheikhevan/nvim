local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

local function in_mathzone()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]

    local before = line:sub(1, col)
    local after = line:sub(col + 1)

    local dollar_before = 0
    for _ in before:gmatch("%$") do
        dollar_before = dollar_before + 1
    end

    if dollar_before % 2 == 1 then
        return true
    end

    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local current_line_num = vim.api.nvim_win_get_cursor(0)[1]

    local in_display = false
    for i = current_line_num, 1, -1 do
        if lines[i]:match("^%$%$$") then
            in_display = true
            break
        elseif i < current_line_num and lines[i]:match("^%$%$$") then
            break
        end
    end

    if in_display then
        for i = current_line_num, #lines do
            if i > current_line_num and lines[i]:match("^%$%$$") then
                return true
            end
        end
    end

    return false
end

local math_mode = {
    condition = in_mathzone,
    show_condition = in_mathzone,
}

return {
    s({ trig = "mt", dscr = "Inline math", snippetType = "autosnippet" },
        fmta("$<>$", { i(1) })
    ),

    s({ trig = "mmt", dscr = "Display math", snippetType = "autosnippet" },
        fmta([[
$$
<>
$$
        ]], { i(1) })
    ),

    s({ trig = "([%w%)%]%}]+)/", regTrig = true, wordTrig = false, dscr = "Auto fraction", snippetType = "autosnippet" },
        fmta("\\frac{<>}{<>}", {
            f(function(_, snip) return snip.captures[1] end),
            i(1)
        }),
        math_mode
    ),

    s({ trig = "//", dscr = "Fraction", snippetType = "autosnippet" },
        fmta("\\frac{<>}{<>}", { i(1), i(2) }),
        math_mode
    ),

    s({ trig = "^", dscr = "Superscript", snippetType = "autosnippet" },
        fmta("^{<>}", { i(1) }),
        math_mode
    ),

    s({ trig = "_", dscr = "Subscript", snippetType = "autosnippet" },
        fmta("_{<>}", { i(1) }),
        math_mode
    ),

    s({ trig = "sqrt", dscr = "Square root", snippetType = "autosnippet" },
        fmta("\\sqrt{<>}", { i(1) }),
        math_mode
    ),

    s({ trig = "nrt", dscr = "nth root" },
        fmta("\\sqrt[<>]{<>}", { i(1), i(2) }),
        math_mode
    ),

    s({ trig = "sum", dscr = "Sum", snippetType = "autosnippet" },
        fmta("\\sum_{<>}^{<>}", { i(1, "i=1"), i(2, "n") }),
        math_mode
    ),

    s({ trig = "lim", dscr = "Limit", snippetType = "autosnippet" },
        fmta("\\lim_{<> \\to <>}", { i(1, "x"), i(2, "\\infty") }),
        math_mode
    ),

    s({ trig = "vec", dscr = "Vector", snippetType = "autosnippet" },
        fmta("\\vec{<>}", { i(1) }),
        math_mode
    ),

    s({ trig = "text", dscr = "Text in math mode", snippetType = "autosnippet" },
        fmta("\\text{<>}", { i(1) }),
        math_mode
    ),

    s({ trig = "mat", dscr = "Matrix", snippetType = "autosnippet" },
        fmta([[
\begin{<>matrix}
<>
\end{<>matrix}
        ]], {
            c(1, { t("p"), t("b"), t("v"), t("V"), t("B"), t("") }),
            i(2),
            f(function(args) return args[1][1] end, { 1 }),
        }),
        math_mode
    ),

    s({ trig = ";a", dscr = "alpha", snippetType = "autosnippet" },
        t("\\alpha"), math_mode
    ),
    s({ trig = ";b", dscr = "beta", snippetType = "autosnippet" },
        t("\\beta"), math_mode
    ),
    s({ trig = ";g", dscr = "gamma", snippetType = "autosnippet" },
        t("\\gamma"), math_mode
    ),
    s({ trig = ";G", dscr = "Gamma", snippetType = "autosnippet" },
        t("\\Gamma"), math_mode
    ),
    s({ trig = ";d", dscr = "delta", snippetType = "autosnippet" },
        t("\\delta"), math_mode
    ),
    s({ trig = ";D", dscr = "Delta", snippetType = "autosnippet" },
        t("\\Delta"), math_mode
    ),
    s({ trig = ";e", dscr = "epsilon", snippetType = "autosnippet" },
        t("\\epsilon"), math_mode
    ),
    s({ trig = ";z", dscr = "zeta", snippetType = "autosnippet" },
        t("\\zeta"), math_mode
    ),
    s({ trig = ";t", dscr = "theta", snippetType = "autosnippet" },
        t("\\theta"), math_mode
    ),
    s({ trig = ";T", dscr = "Theta", snippetType = "autosnippet" },
        t("\\Theta"), math_mode
    ),
    s({ trig = ";l", dscr = "lambda", snippetType = "autosnippet" },
        t("\\lambda"), math_mode
    ),
    s({ trig = ";L", dscr = "Lambda", snippetType = "autosnippet" },
        t("\\Lambda"), math_mode
    ),
    s({ trig = ";m", dscr = "mu", snippetType = "autosnippet" },
        t("\\mu"), math_mode
    ),
    s({ trig = ";p", dscr = "pi", snippetType = "autosnippet" },
        t("\\pi"), math_mode
    ),
    s({ trig = ";P", dscr = "Pi", snippetType = "autosnippet" },
        t("\\Pi"), math_mode
    ),
    s({ trig = ";s", dscr = "sigma", snippetType = "autosnippet" },
        t("\\sigma"), math_mode
    ),
    s({ trig = ";S", dscr = "Sigma", snippetType = "autosnippet" },
        t("\\Sigma"), math_mode
    ),
    s({ trig = ";o", dscr = "omega", snippetType = "autosnippet" },
        t("\\omega"), math_mode
    ),
    s({ trig = ";O", dscr = "Omega", snippetType = "autosnippet" },
        t("\\Omega"), math_mode
    ),

    s({ trig = "<=", dscr = "less than or equal", snippetType = "autosnippet" },
        t("\\leq"), math_mode
    ),
    s({ trig = ">=", dscr = "greater than or equal", snippetType = "autosnippet" },
        t("\\geq"), math_mode
    ),
    s({ trig = "!=", dscr = "not equal", snippetType = "autosnippet" },
        t("\\neq"), math_mode
    ),
    s({ trig = "~=", dscr = "approximately equal", snippetType = "autosnippet" },
        t("\\approx"), math_mode
    ),
    s({ trig = "...", dscr = "ldots", snippetType = "autosnippet" },
        t("\\ldots"), math_mode
    ),
    s({ trig = "infty", dscr = "infinity", snippetType = "autosnippet" },
        t("\\infty"), math_mode
    ),
    s({ trig = "->", dscr = "rightarrow", snippetType = "autosnippet" },
        t("\\rightarrow"), math_mode
    ),
    s({ trig = "=>", dscr = "Rightarrow", snippetType = "autosnippet" },
        t("\\Rightarrow"), math_mode
    ),
    s({ trig = "<->", dscr = "leftrightarrow", snippetType = "autosnippet" },
        t("\\leftrightarrow"), math_mode
    ),

    s({ trig = "sin", dscr = "sine" },
        t("\\sin"), math_mode
    ),
    s({ trig = "cos", dscr = "cosine" },
        t("\\cos"), math_mode
    ),
    s({ trig = "tan", dscr = "tangent" },
        t("\\tan"), math_mode
    ),
    s({ trig = "log", dscr = "logarithm" },
        t("\\log"), math_mode
    ),
    s({ trig = "ln", dscr = "natural log" },
        t("\\ln"), math_mode
    ),
    s({ trig = "exp", dscr = "exponential" },
        t("\\exp"), math_mode
    ),

}

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local postfix = require("luasnip.extras.postfix").postfix

local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

local function bkhelp(args, parent, user_args)
    ret = ""
    test = string.sub(args[1][1], 1)
    if args[1][1]:sub(1,1) == 'g' then
        ret = ret .. 'g'
        test = string.sub(args[1][1], 2)
    end
    if test == '(' then
        ret = ret .. ')'
    elseif test == '[' then
        ret = ret .. ']'
    elseif test == '|' then
        ret = ret .. '|'
    elseif test == '\\{' then
        ret = ret .. '\\}'
    else
        ret = ret .. test
    end

    return ret
end


local generate_matrix = function(args, snip)
	local rows = tonumber(snip.captures[2])
	local cols = tonumber(snip.captures[3])
	local nodes = {}
	local ins_indx = 1
	for j = 1, rows do
		table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
		ins_indx = ins_indx + 1
		for k = 2, cols do
			table.insert(nodes, t(" & "))
			table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
			ins_indx = ins_indx + 1
		end
		table.insert(nodes, t({ "\\\\", "" }))
	end
	-- fix last node.
	nodes[#nodes] = t("\\\\")
	return sn(nil, nodes)
end

ls.add_snippets("tex", {
    s({trig="n;", snippetType="autosnippet"},
        {t("\\newline"),}
    ),
    --essentials
    s({trig="beg", snippetType="autosnippet"},
        fmta(
            [[
                \begin{<>}
                    <>
                \end{<>}
            ]],
            {i(1), i(2), rep(1),}
        )
    ),
    s({trig="mk", snippetType="autosnippet", wordTrig=false},
        fmta("$<>$", {i(1)})
    ),
    s({trig="mj", snippetType="autosnippet", wordTrig=false},
        fmta("\\{<>\\}", {d(1, get_visual)})
    ),
    s({trig="mss", snippetType="autosnippet", wordTrig=false},
        fmta("$\\{<>\\}$", {i(1)})
    ),

    --auto char modification and char modification
    s({trig = '(%a)ht', regTrig=true, snippetType="autosnippet", wordTrig=false}, 
        fmta([[\hat{<>}]],
            { f(function(_, snip) return snip.captures[1] end)}),
        {condition = in_mathzone}
    ),
    s({trig = '(%a)dt', regTrig=true, snippetType="autosnippet", wordTrig=false}, 
        fmta([[\dot{<>}]],
            { f(function(_, snip) return snip.captures[1] end)}),
        {condition = in_mathzone}
    ),
    s({trig = '(%a)ovl', regTrig=true, snippetType="autosnippet", wordTrig=false}, 
        fmta([[\overline{<>}]],
            { f(function(_, snip) return snip.captures[1] end)}),
        {condition = in_mathzone}
    ),
    s({trig = '(%a)twd', regTrig=true, snippetType="autosnippet", wordTrig=false}, 
        fmta([[\tilde{<>}]],
            { f(function(_, snip) return snip.captures[1] end)}),
        {condition = in_mathzone}
    ),
    s({trig="ht", snippetType="autosnippet", wordTrig=false},
        fmta("\\hat{<>}",
            {
                d(1, get_visual)
            }
        ),
        {condition = in_mathzone}
    ),
    s({trig="dt", snippetType="autosnippet", wordTrig=false},
        fmta("\\dot{<>}",
            {
                d(1, get_visual)
            }
        ),
        {condition = in_mathzone}
    ),
    s({trig="ovl", snippetType="autosnippet", wordTrig=false},
        fmta("\\overline{<>}",
            {
                d(1, get_visual)
            }
        ),
        {condition = in_mathzone}
    ),
    --auto subscript
    s({ trig='(%a)(%d)', regTrig=true, dscr='auto subscript', snippetType="autosnippet", priority=100},
        fmta("<>_<>", 
            {f(function(_, snip) return snip.captures[1] end),
            f(function(_, snip) return snip.captures[2] end) }
        ),
        {condition = in_mathzone}
    ),
    s({ trig='(%a)_(%d%d)', regTrig=true, dscr='auto subscript 2', snippetType="autosnippet"},
        fmta("<>_{<>}", 
            {f(function(_, snip) return snip.captures[1] end),
            f(function(_, snip) return snip.captures[2] end) }
        ),
        {condition = in_mathzone}
    ),
    --typefaces
    s({trig="itc", snippetType="autosnippet", wordTrig=false},
        fmta("\\textit{<>}",
            {
                d(1, get_visual)
            }
        )
    ),
    s({trig="bld", snippetType="autosnippet", wordTrig=false},
        fmta("\\textbf{<>}",
            {
                d(1, get_visual)
            }
        )
    ),
    s({trig="nml", snippetType="autosnippet", wordTrig=false},
        fmta("\\textnormal{<>}",
            {
                d(1, get_visual)
            }
        ),
        {condition = in_mathzone}
    ),
    s({trig="mca", snippetType="autosnippet", wordTrig=false},
        fmta("\\mathcal{<>}",
            {
                d(1, get_visual)
            }
        ),
        {condition = in_mathzone}
    ),
    s({trig="mbb", snippetType="autosnippet", wordTrig=false},
        fmta("\\mathbb{<>}",
            {
                d(1, get_visual)
            }
        ),
        {condition = in_mathzone}
    ),
    s({trig="msc", snippetType="autosnippet", wordTrig=false},
        fmta("\\mathscr{<>}",
            {
                d(1, get_visual)
            }
        ),
        {condition = in_mathzone}
    ),
    -- big math stuff
    s({trig="f;", snippetType="autosnippet", wordTrig=false},
        fmta("\\frac{<>}{<>}",
            {
                d(1, get_visual), i(2)
            }
        )
    ),
    s({trig="ff;", snippetType="autosnippet", wordTrig=false},
        fmta("\\frac{<>}{<>}",
            {
                i(1), d(2, get_visual)
            }
        )
    ),
    s({trig="ii", snippetType="autosnippet", wordTrig=false},
        fmta("\\int_{<>}",
            { i(1) }
        ),
        {condition = in_mathzone}
    ),
    s({trig="ll", snippetType="autosnippet", wordTrig=false},
        fmta("\\lim_{<>}",
            { i(1) }
        ),
        {condition = in_mathzone}
    ),
    s({trig="ss", snippetType="autosnippet", wordTrig=false},
        fmta("\\sum_{<>}",
            { i(1) }
        ),
        {condition = in_mathzone}
    ),
    s({trig="pp", snippetType="autosnippet", wordTrig=false},
        fmta("\\prod_{<>}",
            { i(1) }
        ),
        {condition = in_mathzone}
    ),
    s({trig="nrm", snippetType="autosnippet", wordTrig=false},
        fmta("\\|<>\\|",
            { d(1, get_visual) }
        ),
        {condition = in_mathzone}
    ),
    s({trig="abs", snippetType="autosnippet", wordTrig=false},
        fmta("|<>|",
            { d(1, get_visual) }
        ),
        {condition = in_mathzone}
    ),
    s({trig="<>", snippetType="autosnippet", wordTrig=false},
        fmta("\\langle<>,<>\\rangle",
            { d(1, get_visual), i(2) }
        ),
        {condition = in_mathzone}
    ),
    s({trig="prt", snippetType="autosnippet", wordTrig=false},
        fmta("\\frac{\\partial <>}{\\partial <>}",
            {
                d(1, get_visual), i(2)
            }
        ),
        {condition = in_mathzone}
    ),
    s({trig="bk", snippetType="autosnippet", wordTrig=false},
        fmta("\\big<> <>\\big<>",
            {
                i(1), d(2, get_visual), f(bkhelp, {1}, {}),
            }
        ),
        {condition = in_mathzone}
    ),
    s({trig="sr'", snippetType="autosnippet", wordTrig=false},
        fmta("\\sqrt{<>}",
            {
                d(1, get_visual)
            }
        ),
        {condition = in_mathzone}
    ),
    --sub and super
    s({trig="s'", snippetType="autosnippet", wordTrig=false},
        fmta("^{<>}",
            {
                d(1, get_visual)
            }
        ),
        {condition = in_mathzone}
    ),
    s({trig="s;", snippetType="autosnippet", wordTrig=false},
        fmta("_{<>}",
            {
                d(1, get_visual)
            }
        ),
        {condition = in_mathzone}
    ),
    --matrices
    s({trig = "([bBpvV])mx(%d+)x(%d+)", name = "[bBpvV]matrix", dscr = "matrices", regTrig = true, hidden = true, snippetType="autosnippet", wordTrig=false},
        fmta([[
        \begin{<>}
        <>
        \end{<>}]],
        {
            f(function(_, snip)
                return snip.captures[1] .. "matrix"
            end),
            d(1, generate_matrix),
            f(function(_, snip)
                return snip.captures[1] .. "matrix"
            end)
        }),
        {condition = in_mathzone}
    ),
    s({trig = "([bBpvV])mx", name = "[bBpvV]matrix", dscr = "matrices", regTrig = true, hidden = true, wordTrig=false},
        fmta([[
        \begin{<>}
            <>
        \end{<>}]],
        {
            f(function(_, snip)
                return snip.captures[1] .. "matrix"
            end),
            i(1),
            f(function(_, snip)
                return snip.captures[1] .. "matrix"
            end)
        }),
        {condition = in_mathzone}
    ),

    --auto backslash
    s({trig="sin", snippetType="autosnippet", wordTrig=false},
        {t("\\sin")},
        {condition = in_mathzone}
    ),
    s({trig="cos", snippetType="autosnippet", wordTrig=false},
        {t("\\cos")},
        {condition = in_mathzone}
    ),
    s({trig="tan", snippetType="autosnippet", wordTrig=false},
        {t("\\tan")},
        {condition = in_mathzone}
    ),
    s({trig="log", snippetType="autosnippet", wordTrig=false},
        {t("\\log")},
        {condition = in_mathzone}
    ),
    s({trig="ln", snippetType="autosnippet", wordTrig=false},
        {t("\\ln")},
        {condition = in_mathzone}
    ),
    s({trig="exp", snippetType="autosnippet", wordTrig=false},
        {t("\\exp")},
        {condition = in_mathzone}
    ),
    s({trig="ast", snippetType="autosnippet", wordTrig=false},
        {t("\\ast")},
        {condition = in_mathzone}
    ),
    s({trig="dag", snippetType="autosnippet", wordTrig=false},
        {t("\\dag")},
        {condition = in_mathzone}
    ),
    s({trig="sup", snippetType="autosnippet", wordTrig=false},
        {t("\\sup")},
        {condition = in_mathzone}
    ),
    s({trig="inf", snippetType="autosnippet", wordTrig=false},
        {t("\\inf")},
        {condition = in_mathzone}
    ),
    s({trig="neq", snippetType="autosnippet", wordTrig=false},
        {t("\\neq")},
        {condition = in_mathzone}
    ),
    s({trig="leq", snippetType="autosnippet", wordTrig=false},
        {t("\\leq")},
        {condition = in_mathzone}
    ),
    s({trig="geq", snippetType="autosnippet", wordTrig=false},
        {t("\\geq")},
        {condition = in_mathzone}
    ),
    s({trig="max", snippetType="autosnippet", wordTrig=false},
        {t("\\max")},
        {condition = in_mathzone}
    ),
    s({trig="min", snippetType="autosnippet"},
        {t("\\min")},
        {condition = in_mathzone}
    ),
    s({trig="img", snippetType="autosnippet",}, --things like simeq will trig
        {t("\\im")},
        {condition = in_mathzone}
    ),
    s({trig="ker", snippetType="autosnippet", wordTrig=false},
        {t("\\ker")},
        {condition = in_mathzone}
    ),
    s({trig="sta", snippetType="autosnippet", wordTrig=false},
        {t("\\St")},
        {condition = in_mathzone}
    ),
    s({trig="Orb", snippetType="autosnippet", wordTrig=false},
        {t("\\Orb")},
        {condition = in_mathzone}
    ),
    s({trig="Inn", snippetType="autosnippet", wordTrig=false},
        {t("\\Inn")},
        {condition = in_mathzone}
    ),
    s({trig="Aut", snippetType="autosnippet", wordTrig=false},
        {t("\\Aut")},
        {condition = in_mathzone}
    ),
    s({trig="Out", snippetType="autosnippet", wordTrig=false},
        {t("\\Out")},
        {condition = in_mathzone}
    ),
})

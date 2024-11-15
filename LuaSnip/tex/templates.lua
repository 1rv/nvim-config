local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local in_mathzone = function()
    return vim.fin['vimtex#syntax#in_mathzone']() == 1
end

ls.add_snippets("tex", {
    s({trig = "eq", dscr="equation environment"}, 
        fmta(
            [[
                \begin{equation*}
                    <>
                \end{equation*}
            ]],
            {i(1)}
        )
    ),

    s({trig = "eqn", dscr="equation environment w/ number"}, 
        fmta(
            [[
                \begin{equation}
                    <>
                \end{equation}
            ]],
            {i(1)}
        )
    ),

    s({trig = "al", dscr="align environment"}, 
        fmta(
            [[
                \begin{align*}
                    <>
                \end{align*}
            ]],
            {i(1)}
        )
    ),

    s({trig = "aln", dscr="align environment w/ number"}, 
        fmta(
            [[
                \begin{align}
                    <>
                \end{align}
            ]],
            {i(1)}
        )
    ),
    s({trig = "dcmop", dscr="declare math operator", snippetType="autosnippet"}, 
        fmta(
            [[
                \DeclareMathOperator{\<>}{<>}
            ]],
            {i(1), i(2)}
        )
    ),
    s({trig = "pppp", dscr="problem proof", snippetType = "autosnippet"}, 
        fmta(
            [[
                \begin{problem}
                    <>
                \end{problem}
                \begin{proof}
                    <>
                \end{proof}
            ]],
            {i(1), i(2)}
        ),
        {condition = line_begin}
    ),

    -- Math operator kits
    s({trig = "LAtempl", dscr="linear algebra math operators", snippetType = "autosnippet"}, 
        fmta(
            [[
                \DeclareMathOperator{\rank}{rank}
                \DeclareMathOperator{\im}{im}
                \DeclareMathOperator{\tr}{tr}
                \DeclareMathOperator{\nul}{null}
                \DeclareMathOperator{\Span}{span}
                <>
            ]],
            {i(0)}
        ),
        {condition = line_begin}
    ),
    s({trig = "Algtempl", dscr="algebra math operators", snippetType = "autosnippet"}, 
        fmta(
            [[
                \DeclareMathOperator{\Inn}{Inn}
                \DeclareMathOperator{\Aut}{Aut}
                \DeclareMathOperator{\Out}{Out}
                \DeclareMathOperator{\im}{im}
                <>
            ]],
            {i(0)}
        ),
        {condition = line_begin}
    ),
    s({trig = "complextempl", dscr="algebra math operators", snippetType = "autosnippet"}, 
        fmta(
            [[
                \DeclareMathOperator{\res}{res}
                \DeclareMathOperator{\re}{Re}
                \DeclareMathOperator{\im}{Im}
                <>
            ]],
            {i(0)}
        ),
        {condition = line_begin}
    ),


    s({trig = "templ", dscr="homework template", snippetType="autosnippet"}, 
        fmta(
            [[
                \documentclass[a4paper,12pt,reqno]{amsart}
                \usepackage{geometry}

                \geometry{letterpaper, margin=1in}

                \newcommand{\classtitle}{<>}
                \newcommand{\doctitle}{<>}
                \newcommand{\username}{Daniel Chen}

                \usepackage{fancyhdr}
                \usepackage{amsmath}
                \usepackage{mathrsfs}


                \pagestyle{fancy}
                \fancyhead{}
                \lhead{\doctitle}
                \rhead{\username}

                \setlength{\headheight}{14.0pt}
                \setlength{\footskip}{14.0pt}


                \theoremstyle{definition}
                \newtheorem{theorem}{Theorem}[section]
                \newtheorem{problem}{Problem}
                \newtheorem{lemma}{Lemma}
                \newtheorem{definition}{Definition}

                \title{\classtitle\;\doctitle}
                \author{\username}

                %User Defined Commands

                \begin{document}
                    \maketitle
                    \begin{problem}
                        <>
                    \end{problem}
                \end{document}
            ]],
            {i(1), i(2), i(3)}
        ),
        {condition = line_begin}
    ),
})


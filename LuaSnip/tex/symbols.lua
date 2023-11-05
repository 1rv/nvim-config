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
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

ls.add_snippets("tex", {
    s({trig=";a", snippetType="autosnippet", wordTrig=false},
        {t("\\alpha"),}
    ),
    s({trig=";b", snippetType="autosnippet", wordTrig=false},
        {t("\\beta"),}
    ),
    s({trig=";g", snippetType="autosnippet", wordTrig=false},
        {t("\\gamma"),}
    ),
    s({trig=";G", snippetType="autosnippet", wordTrig=false},
        {t("\\Gamma"),}
    ),
    s({trig=";d", snippetType="autosnippet", wordTrig=false},
        {t("\\Delta"),}
    ),
    s({trig=";D", snippetType="autosnippet", wordTrig=false},
        {t("\\Delta"),}
    ),
    s({trig=";e", snippetType="autosnippet", wordTrig=false},
        {t("\\epsilon"),}
    ),
    s({trig=";z", snippetType="autosnippet", wordTrig=false},
        {t("\\zeta"),}
    ),
    s({trig=";t", snippetType="autosnippet", wordTrig=false},
        {t("\\theta"),}
    ),
    s({trig=";T", snippetType="autosnippet", wordTrig=false},
        {t("\\tau"),}
    ),
    s({trig=";h", snippetType="autosnippet", wordTrig=false},
        {t("\\eta"),}
    ),
    s({trig=";i", snippetType="autosnippet", wordTrig=false},
        {t("\\iota"),}
    ),
    s({trig=";k", snippetType="autosnippet", wordTrig=false},
        {t("\\kappa"),}
    ),
    s({trig=";l", snippetType="autosnippet", wordTrig=false},
        {t("\\lambda"),}
    ),
    s({trig=";L", snippetType="autosnippet", wordTrig=false},
        {t("\\Lambda"),}
    ),
    s({trig=";m", snippetType="autosnippet", wordTrig=false},
        {t("\\mu"),}
    ),
    s({trig=";n", snippetType="autosnippet", wordTrig=false},
        {t("\\nu"),}
    ),
    s({trig=";x", snippetType="autosnippet", wordTrig=false},
        {t("\\xi"),}
    ),
    s({trig=";p", snippetType="autosnippet", wordTrig=false},
        {t("\\pi"),}
    ),
    s({trig=";r", snippetType="autosnippet", wordTrig=false},
        {t("\\rho"),}
    ),
    s({trig=";s", snippetType="autosnippet", wordTrig=false},
        {t("\\sigma"),}
    ),
    s({trig=";S", snippetType="autosnippet", wordTrig=false},
        {t("\\Sigma"),}
    ),
    s({trig=";f", snippetType="autosnippet", wordTrig=false},
        {t("\\phi"),}
    ),
    s({trig=";F", snippetType="autosnippet", wordTrig=false},
        {t("\\Phi"),}
    ),
    s({trig=";c", snippetType="autosnippet", wordTrig=false},
        {t("\\chi"),}
    ),
    s({trig=";o", snippetType="autosnippet", wordTrig=false},
        {t("\\omega"),}
    ),
    s({trig=";O", snippetType="autosnippet", wordTrig=false},
        {t("\\Omega"),}
    ),
    s({trig=";y", snippetType="autosnippet", wordTrig=false},
        {t("\\psi"),}
    ),
    s({trig=";Y", snippetType="autosnippet", wordTrig=false},
        {t("\\Psi"),}
    ),
    -- set symbols
    s({trig="NN", snippetType="autosnippet", wordTrig=false},
        {t("\\mathbb{N})"),}
    ),
    s({trig="RR", snippetType="autosnippet", wordTrig=false},
        {t("\\mathbb{R})"),}
    ),
    s({trig="QQ", snippetType="autosnippet", wordTrig=false},
        {t("\\mathbb{Q})"),}
    ),
    s({trig="ZZ", snippetType="autosnippet", wordTrig=false},
        {t("\\mathbb{Z})"),}
    ),
    s({trig="CC", snippetType="autosnippet", wordTrig=false},
        {t("\\mathbb{C})"),}
    ),
    s({trig="sbs", snippetType="autosnippet", wordTrig=false},
        {t("\\subset"),}
    ),
    s({trig="sps", snippetType="autosnippet", wordTrig=false},
        {t("\\supset"),}
    ),
    -- other symbols
    s({trig="OO", snippetType="autosnippet", wordTrig=false},
        {t("\\infty"),}
    ),
    s({trig="sr;", snippetType="autosnippet", wordTrig=false},
        {t("^2"),}
    ),
    s({trig="invs", snippetType="autosnippet", wordTrig=false},
        {t("^{-1}"),}
    ),
    s({trig="cb", snippetType="autosnippet", wordTrig=false},
        {t("^3"),}
    ),
    s({trig="**", snippetType="autosnippet", wordTrig=false},
        {t("^*"),}
    ),
    s({trig="-=", snippetType="autosnippet", wordTrig=false},
        {t("\\implies"),}
    ),
    s({trig="=-", snippetType="autosnippet", wordTrig=false},
        {t("\\impliedby"),}
    ),
    s({trig="===", snippetType="autosnippet", wordTrig=false},
        {t("\\iff"),}
    ),
    s({trig="---", snippetType="autosnippet", wordTrig=false},
        {t("\\equiv"),}
    ),
    --dots
    s({trig="cds", snippetType="autosnippet", wordTrig=false},
        {t("\\cdots"),},
        {condition = in_mathzone}
    ),
    s({trig="cd.", snippetType="autosnippet", wordTrig=false},
        {t("\\cdot"),},
        {condition = in_mathzone}
    ),
    s({trig="lds", snippetType="autosnippet", wordTrig=false},
        {t("\\ldots"),},
        {condition = in_mathzone}
    ),
    s({trig="ld.", snippetType="autosnippet", wordTrig=false},
        {t("\\ldot"),},
        {condition = in_mathzone}
    ),
    --wordTrig true 
    s({trig="inn", snippetType="autosnippet"},
        {t("\\in"),},
        {condition = in_mathzone}
    ),
    s({trig="mty", snippetType="autosnippet"},
        {t("\\emptyset"),},
        {condition = in_mathzone}
    ),
})

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

ls.add_snippets("cpp", {
    s({trig = "hdrs", dscr="classic headers", snippetType="autosnippet", wordTrig=false},
        fmta(
            [[
                #include <<iostream>>
                #include <<string>>
                #include <<vector>>
                #include <<algorithm>>
                using namespace std;

                #define ll long long
                #define vi vector<<int>>
                #define vvi vector<<vector<<int>>
                #define pii pair<<int,int>>
                #define F first
                #define S second
                #define pb push_back
                #define REP(i,n) for(int i=0;i<<n;i++)

                const ll MOD=998244353;

                int main() {
                    ios_base::sync_with_stdio(false);
                    cin.tie(nullptr);
                    <>
                }
            ]],
            {i(1)}
        )
    ),
})


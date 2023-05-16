
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")

local tex_utils = require('snippets.tex.tex_utils')

return {

  s(
    {
        trig = ";a",
        dscr = "Insert the alpha letter",
        name = "Alpha",
        snippetType = "autosnippet"
    },
    {t("\\alpha")},
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
        trig = ";b",
        dscr = "Insert the beta letter",
        name = "Beta",
        snippetType = "autosnippet"
    },
    {t("\\beta")},
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
        trig = ";g",
        dscr = "Insert the gamma letter",
        name = "Gamma",
        snippetType = "autosnippet"
    },
    {t("\\gamma")},
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {trig = "bar", wordTrig = false, auto = true, regTrig = true},
    {
      t("\\overline{"),
      i(1),
      t("}"),
    }
  )



}


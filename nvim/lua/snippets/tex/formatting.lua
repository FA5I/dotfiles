
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
      trig = "tt",
      dscr = "Insert '\\texttt{}'",
      name = "Monospace",
      snippetType = "autosnippet",
    },
    fmta("\\texttt{<>}", { i(1) } )
  ),

   s(
    {
      trig = "bf",
      dscr = "Insert '\\textbf{}'",
      name = "Monospace",
      snippetType = "autosnippet",
    },
    fmta("\\textbf{<>}", { i(1) } )
  ),

  s(
    {
      trig = "itemize",
      dscr = "Insert itemized list",
      name = "Monospace",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{itemize}
          \item <>
        \end{itemize}
      ]],
      { i(1) } )
  ),




}


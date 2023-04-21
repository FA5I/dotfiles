local ls = require('luasnip')

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("lorem", {
    t("Lorem ipsum dolor sit amet, consectetur adipiscing elit. "),
    i(1, "Your text here"),
    t({ "", " Donec vehicula scelerisque urna." }),
  }),
}

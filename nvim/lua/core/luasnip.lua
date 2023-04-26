local ls = require('luasnip')

ls.config.set_config({ -- Setting LuaSnip config
    history=true,
    enable_autosnippets = true,
    store_selection_keys = "<Tab>"
})

vim.cmd [[
    imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
    smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
    imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
    smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
]]

local luasnip_loaders = require('luasnip.loaders.from_lua')

local config_path = vim.fn.stdpath('config')

luasnip_loaders.load({ paths = { config_path .. "/lua/snippets" } })


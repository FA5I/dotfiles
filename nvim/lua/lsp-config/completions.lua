local cmp_status_ok, cmp = pcall(require, "cmp")

if not cmp_status_ok then
    print('cmp not loaded!')
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")

if not snip_status_ok then
    print('luasnip not loaded!')
    return
end

luasnip.filetype_extend("lua", {"c"})

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end
    },

    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),

        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),

        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        })
    },

    -- Installed sources:
    sources = {
        {name = 'nvim_lsp', keyword_length = 3}, -- from language server
        {name = 'nvim_lsp_signature_help'}, -- display function signatures with current parameter emphasized
        {name = 'path'}, -- file paths
        {name = 'buffer', keyword_length = 2}, -- source current buffer
        {name = 'luasnip', option = {show_autosnippets = true}}
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },

    formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'λ',
                vsnip = '⋗',
                buffer = 'Ω',
                path = '🖫'
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end
    }
})



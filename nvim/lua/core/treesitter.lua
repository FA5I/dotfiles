local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then return end

configs.setup({
    ensure_installed = {
        "javascript", "json", "lua", "python", "typescript", "tsx", "yaml",
        "rust", "toml"
    }, 

    auto_install = false,

    highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = false,
    },

    autopairs = {enable = true},

    indent = {enable = true, disable = {"python", "css"}},

    disable = {"latex"},

    -- enable nvim-ts-context-commentstring
    context_commentstring = {enable = true}

})

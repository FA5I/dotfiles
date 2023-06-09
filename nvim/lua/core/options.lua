local options = {
    backup = false, -- creates a backup file
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    cmdheight = 2, -- more space in the neovim command line for displaying messages
    completeopt = {"menuone", "noselect"}, -- mostly just for cmp
    conceallevel = 1, -- so that `` is visible in markdown files
    fileencoding = "utf-8", -- the encoding written to a file
    hlsearch = true, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    mouse = "a", -- allow the mouse to be used in neovim
    pumheight = 10, -- pop up menu height
    --[[ showmode = false,                        -- we don't need to see things like -- INSERT -- anymore ]]
    showtabline = 2, -- always show tabs
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true, -- enable persistent undo
    updatetime = 300, -- faster completion (4000ms default)
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true, -- convert tabs to spaces
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    tabstop = 2, -- insert 2 spaces for a tab
    cursorline = true, -- highlight the current line
    number = true, -- set numbered lines
    relativenumber = false, -- set relative numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}

    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    wrap = false, -- display lines as one long line
    linebreak = true, -- companion to wrap, don't split words
    scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor
    sidescrolloff = 8, -- minimal number of screen columns either side of cursor if wrap is `false`
    guifont = "monospace:h17", -- the font used in graphical neovim applications
    whichwrap = "bs<>[]hl", -- which "horizontal" keys are allowed to travel to prev/next line

    -- textwidth = 80,
    -- colorcolumn='+1',

    ttyfast = true, -- speed up scrolling
    -- wildmode='longest,list',                 -- get bash-like tab completions

    showcmd = true,
    background = "light"

}

for k, v in pairs(options) do vim.opt[k] = v end

-- vim.opt.shortmess = "ilmnrx"                        -- flags to shorten vim messages, see :help 'shortmess'
vim.opt.shortmess:append "c" -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append "-" -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({"c", "r", "o"}) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use

vim.cmd "filetype plugin on"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Latex related
vim.g.tex_flavor = "latex"
vim.g.tex_conceal = "abdmgs"
vim.g.vimtex_view_method = "skim"
vim.g.vimtex_view_skim_sync = 1
vim.g.vimtex_view_skim_activate = 1

vim.cmd('command! -nargs=0 Q Bdelete!')

-- vim.g.gruvbox_material_background = 'medium'
-- vim.g.gruvbox_material_better_performance = 1
-- vim.g.gruvbox_material_visual = 'blue background'
-- vim.g.gruvbox_material_cursor = 'blue'
-- vim.cmd "colorscheme gruvbox-material"

require("catppuccin").setup({
  custom_highlights = function(colors)
        return {
            Comment = { fg = colors.flamingo },
            ["@constant.builtin"] = { fg = colors.peach, style = {} },
            ["@comment"] = { fg = colors.surface2, style = { "italic" } },
        }
    end,
    integrations = {
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = {"italic"},
                hints = {"italic"},
                warnings = {"italic"},
                information = {"italic"}
            },
            underlines = {
                errors = {"undercurl"},
                hints = {"undercurl"},
                warnings = {"undercurl"},
                information = {"undercurl"}
            }
        },
        hop = true,
        markdown = true
    }
})


vim.cmd.colorscheme "catppuccin"

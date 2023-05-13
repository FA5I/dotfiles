local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({border = "rounded"})
        end
    }
})

return packer.startup(function(use)

    -- package manager
    use 'wbthomason/packer.nvim'

    -- lua functions used by other packages
    use "nvim-lua/plenary.nvim"

    -- theme
    use {"catppuccin/nvim", as = "catppuccin"}
    use "rebelot/kanagawa.nvim"
    use "sainnhe/everforest"
    use 'arzg/vim-colors-xcode'
    use 'sainnhe/gruvbox-material'

    use {"nvim-tree/nvim-web-devicons"}

    -- leader menu
    use {"folke/which-key.nvim"}

    -- file explorer
    use {"nvim-tree/nvim-tree.lua"}

    -- fuzzy finder
    use {"nvim-telescope/telescope.nvim"}
    use {'nvim-telescope/telescope-ui-select.nvim'}
    use {'nvim-telescope/telescope-dap.nvim'}

    -- project management
    use {"ahmedkhalf/project.nvim"}

    -- comment utilities
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }
    
    use {"JoosepAlviste/nvim-ts-context-commentstring"}

    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                show_current_context = true,
                show_current_context_start = true
            }
        end
    }

    -- tabs / buffers
    use {'akinsho/bufferline.nvim', tag = "v3.*"}
    use {"moll/vim-bbye"} -- used via the leader menu

    -- status line
    use {"nvim-lualine/lualine.nvim"}
    use({
        "folke/noice.nvim",
        requires = {
            "MunifTanjim/nui.nvim"
        }
    })

    -- tree-sitter
    use {"nvim-treesitter/nvim-treesitter"}

    -- lsp
    use {"williamboman/mason.nvim"}
    use {"williamboman/mason-lspconfig.nvim"}
    use {"neovim/nvim-lspconfig"} -- collection of common configurations for the Nvim LSP client
    use {"hrsh7th/nvim-cmp"} -- completion plugin; sources are installed from external repos and then sourced
    use {"jose-elias-alvarez/null-ls.nvim"}

    -- completions
    use {"hrsh7th/cmp-nvim-lsp"} -- completion engine source for built in neovim lsp server
    use {"hrsh7th/cmp-buffer"}
    use {"hrsh7th/cmp-path"}
    use {"hrsh7th/cmp-cmdline"}
    use {"hrsh7th/cmp-nvim-lsp-signature-help"}
    use { 'saadparwaiz1/cmp_luasnip' }

    -- language setups
    use {'simrat39/rust-tools.nvim'}
    use {"folke/neodev.nvim"}

    use {"RRethy/vim-illuminate" } -- automatically highlighting other uses of the word under the cursor 

    -- git
    use {"tpope/vim-fugitive"}
    use {"lewis6991/gitsigns.nvim"}

    -- terminal
    use {"akinsho/toggleterm.nvim"}

    -- snippets
    use {"rafamadriz/friendly-snippets"}
    use({
        "L3MON4D3/LuaSnip",
    })

    -- debugger
    use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
    use {
        "microsoft/vscode-js-debug",
        opt = true,
        run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    }
    use {"mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"}}

    -- editing
    use {'reedes/vim-pencil', opt = true, cmd = {'Pencil'}}
    use 'MattesGroeger/vim-bookmarks'

    use {
        'vimwiki/vimwiki',
        config = function()
            vim.g.vimwiki_list = {
                {path = '~/.config/nvim/wiki', syntax = 'markdown', ext = '.md'}
            }
        end
    }

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use 'lervag/vimtex'
  
    use {
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then require("packer").sync() end

end)

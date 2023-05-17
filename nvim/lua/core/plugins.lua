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
  
    -- tree-sitter
    use {"nvim-treesitter/nvim-treesitter"}
    
    -- file explorer
    use {"nvim-tree/nvim-tree.lua"}
    
    -- fuzzy finder
    use {"nvim-telescope/telescope.nvim"}
    use {'nvim-telescope/telescope-ui-select.nvim'}
    use {'nvim-telescope/telescope-dap.nvim'}

    -- project management
    use {"ahmedkhalf/project.nvim"}
    
    -- tabs / buffers
    use {'akinsho/bufferline.nvim', tag = "v3.*"}
    use {"moll/vim-bbye"}

     -- status line
    use {"nvim-lualine/lualine.nvim"}

    -- comment utilities
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }
    
    use {"JoosepAlviste/nvim-ts-context-commentstring"}


    -- editing
    use {'reedes/vim-pencil', opt = true, cmd = {'Pencil'}}


    -- snippets
    use({ "L3MON4D3/LuaSnip" })


    -- latex
    use 'lervag/vimtex'

    use {"hrsh7th/nvim-cmp"} -- completion plugin; sources are installed from external repos and then sourced
    use {"hrsh7th/cmp-nvim-lsp"} -- completion engine source for built in neovim lsp server
    use {"hrsh7th/cmp-buffer"}
    use {"hrsh7th/cmp-path"}
    use {"hrsh7th/cmp-cmdline"}
    use {"hrsh7th/cmp-nvim-lsp-signature-help"}
    use { 'saadparwaiz1/cmp_luasnip' }


    use {
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
        require("trouble").setup {}
      end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then require("packer").sync() end

end)

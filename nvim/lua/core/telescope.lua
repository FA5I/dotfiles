local status_ok, telescope = pcall(require, "telescope")

if not status_ok then return end

local themes = require('telescope.themes')

telescope.setup({
    defaults = {
        layout_strategy = "vertical",
        layout_config = {height = 0.95},
        mappings = {
            n = {
                v = require('telescope.actions').file_vsplit,
                s = require('telescope.actions').file_split,
                t = require('telescope.actions').file_tab,
                ["<C-c>"] = require('telescope.actions').close
            }
        }
    },
    extensions = {
        ["ui-select"] = {
            themes.get_dropdown {
                -- even more opts
            }
        }
    }
})

telescope.load_extension("ui-select")

telescope.load_extension('projects')

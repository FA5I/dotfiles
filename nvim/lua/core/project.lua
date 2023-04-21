local status_ok, project = pcall(require, "project_nvim")
if not status_ok then return end

project.setup({
    --- This is on by default since it's currently the expected behavior.
    active = true,

    on_config_done = nil,

    manual_mode = false,

    detection_methods = {"pattern"},

    patterns = {
        ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json"
    },

    ---@ Show hidden files in telescope when searching for files in a project
    show_hidden = false,

    -- When set to false, you will get a message when project.nvim changes your directory.
    silent_chdir = true,

    ---@usage list of lsp client names to ignore when using **lsp** detection. eg: { "efm", ... }
    ignore_lsp = {},

    ---@usage path to store the project history for use in telescope
    datapath = vim.fn.stdpath("data")
})

require('config.dap.debug-ui')
require('config.dap.adapters').setup()


require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true }
})

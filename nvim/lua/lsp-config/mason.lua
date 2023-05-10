local servers = {"lua_ls", "pyright", "jsonls", "rust_analyzer", "tsserver", "yamlls"}

local settings = {
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍"
        }
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4
}

local mason_ok, mason = pcall(require, "mason")

if not mason_ok then return end

mason.setup(settings)

require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then return end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("lsp-config.handlers").on_attach,
        capabilities = require("lsp-config.handlers").capabilities
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require,
                                        "lsp-config.settings." .. server)

    if require_ok then opts = vim.tbl_deep_extend("force", conf_opts, opts) end

    if server == 'rust_analyzer' then
        local rt_ok, rt = pcall(require, 'lsp-config.rust-tools')

        if not rt_ok then
            print('rt not loaded!')
            return
        end

        rt.set_up()
    else
        lspconfig[server].setup(opts)
    end
end

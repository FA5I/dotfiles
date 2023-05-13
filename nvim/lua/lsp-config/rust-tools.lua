local M = {}

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

M.set_up = function()

    local rt_ok, rt = pcall(require, "rust-tools")

    if not rt_ok then print('rust-tools not loaded!') end

    local mason_ok, mason_registry = pcall(require, "mason-registry")

    if not mason_ok then
        print("mason registry not found!")
        return
    end

    local function rust_on_attach(_, bufnr)
        -- Hover actions
        keymap("n", "<C-space>", rt.hover_actions.hover_actions,
               {buffer = bufnr})
        -- Code action groups
        keymap("n", "<Leader>a", rt.code_action_group.code_action_group,
               {buffer = bufnr})
    end

    local codelldb_root =
        mason_registry.get_package("codelldb"):get_install_path() ..
            "/extension/"
    local codelldb_path = codelldb_root .. "adapter/codelldb"
    local liblldb_path = codelldb_root .. "lldb/lib/liblldb.dylib"

    require("rust-tools").setup({
        tools = {
            inlay_hints = {
                auto = false,
                show_parameter_hints = false,
                parameter_hints_prefix = "",
                other_hints_prefix = ""
            },
            hover_actions = {
                border = {
                    {"╭", "FloatBorder"}, {"─", "FloatBorder"},
                    {"╮", "FloatBorder"}, {"│", "FloatBorder"},
                    {"╯", "FloatBorder"}, {"─", "FloatBorder"},
                    {"╰", "FloatBorder"}, {"│", "FloatBorder"}
                },

                auto_focus = true
            },
            runnables = {use_telescope = true}
        },
        server = {
            standalone = true,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            on_attach = rust_on_attach,

            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {enable = true, command = "clippy"}
                }
            }
        },
        dap = {
            adapter = require("rust-tools.dap").get_codelldb_adapter(
                codelldb_path, liblldb_path)
        }

    })

end

return M

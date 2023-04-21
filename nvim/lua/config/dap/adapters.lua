local M = {}

M.setup = function()
    local dap_status, dap = pcall(require, "dap")

    if not dap_status then
        print("dap not found")
        return
    end

    local mason_ok, mason_registry = pcall(require, "mason-registry")

    if not mason_ok then
        print("mason registry not found!")
        return
    end

    local codelldb_root =
        mason_registry.get_package("codelldb"):get_install_path() ..
            "/extension/"
    local codelldb_path = codelldb_root .. "adapter/codelldb"

    -- C, C++ and Rust adapter
    -- Export it so it can be used with rust-tools
    dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {command = codelldb_path, args = {"--port", "${port}"}}
    }

    M.codelldb = dap.adapters.codelldb

    dap.configurations.rust = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ',
                                    vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false
        }
    }

    -- Tpescript, Javascript  
    require("dap-vscode-js").setup({
        node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        debugger_path = os.getenv('HOME') ..
            '/.local/share/nvim/site/pack/packer/opt/vscode-js-debug', -- Path to vscode-js-debug installation.
        -- debugger_cmd = { "${port}" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = {'pwa-node', 'node-terminal'} -- which adapters to register in nvim-dap
        -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
        -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
        -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    })

    for _, language in ipairs({"typescript", "javascript"}) do
        dap.configurations[language] = {
            {
                type = 'pwa-node',
                request = 'launch',
                name = 'Launch Current File (pwa-node)',
                cwd = vim.fn.getcwd(),
                args = {'${file}'},
                sourceMaps = true,
                protocol = 'inspector'
            }, {
                type = 'pwa-node',
                request = 'launch',
                name = 'Launch Current File (pwa-node with ts-node)',
                cwd = vim.fn.getcwd(),
                runtimeArgs = {'--loader', 'ts-node/esm'},
                runtimeExecutable = 'node',
                args = {'${file}'},
                sourceMaps = true,
                protocol = 'inspector',
                skipFiles = {'<node_internals>/**', 'node_modules/**'},
                resolveSourceMapLocations = {
                    "${workspaceFolder}/**", "!**/node_modules/**"
                }
            }, {
                type = 'pwa-node',
                request = 'launch',
                name = 'Launch Current File (pwa-node with deno)',
                cwd = vim.fn.getcwd(),
                runtimeArgs = {'run', '--inspect-brk', '--allow-all', '${file}'},
                runtimeExecutable = 'deno',
                attachSimplePort = 9229
            }, {
                type = 'pwa-node',
                request = 'launch',
                name = 'Launch Test Current File (pwa-node with jest)',
                cwd = vim.fn.getcwd(),
                runtimeArgs = {'${workspaceFolder}/node_modules/.bin/jest'},
                runtimeExecutable = 'node',
                args = {'${file}', '--coverage', 'false'},
                rootPath = '${workspaceFolder}',
                sourceMaps = true,
                console = 'integratedTerminal',
                internalConsoleOptions = 'neverOpen',
                skipFiles = {'<node_internals>/**', 'node_modules/**'}
            }, {
                type = 'pwa-node',
                request = 'launch',
                name = 'Launch Test Current File (pwa-node with vitest)',
                cwd = vim.fn.getcwd(),
                program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
                args = {'--inspect-brk', '--threads', 'false', 'run', '${file}'},
                autoAttachChildProcesses = true,
                smartStep = true,
                console = 'integratedTerminal',
                skipFiles = {'<node_internals>/**', 'node_modules/**'}
            }, {
                type = 'pwa-node',
                request = 'launch',
                name = 'Launch Test Current File (pwa-node with deno)',
                cwd = vim.fn.getcwd(),
                runtimeArgs = {
                    'test', '--inspect-brk', '--allow-all', '${file}'
                },
                runtimeExecutable = 'deno',
                attachSimplePort = 9229
            }, {
                type = 'pwa-chrome',
                request = 'attach',
                name = 'Attach Program (pwa-chrome = { port: 9222 })',
                program = '${file}',
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                port = 9222,
                webRoot = '${workspaceFolder}'
            }
        }
    end

end

return M

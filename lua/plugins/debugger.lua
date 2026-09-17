return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
        },
        config = function()
            local dap = require("dap")
            local ui = require("dapui")

            require("dapui").setup()

            vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

            -- Eval var under cursor
            vim.keymap.set("n", "<space>?", function()
                require("dapui").eval(nil, { enter = true })
            end)

            vim.keymap.set("n", "<F1>", dap.continue)
            vim.keymap.set("n", "<F2>", dap.step_into)
            vim.keymap.set("n", "<F3>", dap.step_over)
            vim.keymap.set("n", "<F4>", dap.step_out)
            vim.keymap.set("n", "<F5>", dap.step_back)
            vim.keymap.set("n", "<F12>", dap.restart)

            vim.fn.sign_define("DapBreakpoint", {
                text = "●",
                texthl = "DapBreakpoint",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapStopped", {
                text = "▶",
                texthl = "DapStopped",
                linehl = "",
                numhl = "",
            })

            vim.api.nvim_set_hl(0, "DapBreakpoint", {
                fg = "#f7768e",
            })

            vim.api.nvim_set_hl(0, "DapStopped", {
                fg = "#e6b450",
            })

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end

            local function find_csproj()
                local matches = vim.fn.globpath(vim.fn.getcwd(), '**/*.csproj', false, true)
                if #matches == 0 then
                    error('No .csproj found under ' .. vim.fn.getcwd())
                elseif #matches == 1 then
                    return matches[1]
                else
                    local lines = { 'Select project:' }
                    for i, p in ipairs(matches) do
                        lines[#lines + 1] = i .. ': ' .. p
                    end
                    local choice = vim.fn.inputlist(lines)
                    if choice < 1 or choice > #matches then
                        error('No project selected')
                    end
                    return matches[choice]
                end
            end

            local function resolve_dll()
                local csproj = find_csproj()
                local dir = vim.fn.fnamemodify(csproj, ':h')
                local content = table.concat(vim.fn.readfile(csproj), '\n')

                local tfm = content:match('<TargetFramework>([^<]+)</TargetFramework>')
                    or content:match('<TargetFrameworks>([^<;]+)')
                local assembly = content:match('<AssemblyName>([^<]+)</AssemblyName>')
                    or vim.fn.fnamemodify(csproj, ':t:r')

                if not tfm then
                    error('Could not determine TargetFramework from ' .. csproj)
                end

                local dll = string.format('%s/bin/Debug/%s/%s.dll', dir, tfm, assembly)

                if vim.fn.filereadable(dll) == 0 then
                    error('DLL not found at ' .. dll .. ' — did you build the project?')
                end

                return dll
            end

            dap.adapters.coreclr = {
                type = 'executable',
                command = 'netcoredbg',
                args = { '--interpreter=vscode' }
            }
            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = resolve_dll,
                    stopAtEntry = true
                },
            }
        end,
    },
}

return {
    "nickjvandyke/opencode.nvim",
    enabled = false,
    version = "*", -- Latest stable release
    dependencies = { "folke/snacks.nvim" },
    init = function()
        local opencode_cmd = "opencode --port"

        ---@type snacks.terminal.Opts
        local snacks_terminal_opts = {
            win = {
                position = "right",
                enter = false,
            },
        }

        ---@type opencode.Opts
        vim.g.opencode_opts = {
            server = {
                start = function()
                    require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
                end,
            },
        }

        -- If you use <leader> here, remove 't' — otherwise Neovim will add input
        -- delay to your <leader> when typing in the terminal to watch for the mapping.
        vim.keymap.set("n", "<leader>wc", function()
            require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
        end, { desc = "Toggle OpenCode" })
    end,
    config = function()
        vim.keymap.set({ "n", "x" }, "<leader>cc", function() require("opencode").ask("@this: ") end,
            { desc = "Ask OpenCode…" })
        vim.keymap.set({ "n", "x" }, "<leader>ca", function() require("opencode").select() end,
            { desc = "Select OpenCode…" })
        vim.keymap.set({ "n", "x" }, "<leader>cg", function() return require("opencode").operator("@this ") end,
            { desc = "Append range to OpenCode", expr = true })
    end,
}

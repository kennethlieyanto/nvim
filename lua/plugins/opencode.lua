return {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    config = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {
            -- Your configuration, if any; goto definition on the type for details
        }

        -- Recommended/example keymaps
        vim.keymap.set({ "n", "x" }, "<leader>cc", function() require("opencode").ask("@this: ") end,
            { desc = "Ask OpenCode…" })
        vim.keymap.set({ "n", "x" }, "<leader>ca", function() require("opencode").select() end,
            { desc = "Select OpenCode…" })
        vim.keymap.set({ "n", "x" }, "<leader>cg", function() return require("opencode").operator("@this ") end,
            { desc = "Append range to OpenCode", expr = true })
    end,
}

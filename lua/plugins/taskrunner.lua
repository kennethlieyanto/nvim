return {
    "stevearc/overseer.nvim",
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {},
    keys = {
        { "<leader>wr", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer" },
        { "<leader>r", "<cmd>OverseerRun<cr>", desc = "Run task" },
    },
}

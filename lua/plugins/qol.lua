return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
        input = {
            enabled = true, -- Enhances Ask
        },
        picker = {
            enabled = true, -- Enhances Select
        },
    },
}

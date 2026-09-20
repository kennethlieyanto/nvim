return {
    "folke/sidekick.nvim",
    event = "VeryLazy",
    opts = {
        cli = {
            mux = {
                enabled = true,
                backend = "tmux",
            },
        },
    },
    keys = {
        {
            "<c-.>",
            function() require("sidekick.cli").focus() end,
            desc = "Sidekick Focus",
            mode = { "n", "t", "i", "x" },
        },
        {
            "<leader>wc",
            function() require("sidekick.cli").toggle() end,
            desc = "Sidekick Toggle CLI",
        },
        {
            "<leader>as",
            function() require("sidekick.cli").select() end,
            desc = "Select CLI",
        },
        {
            "<leader>ad",
            function() require("sidekick.cli").close() end,
            desc = "Detach a CLI Session",
        },
        {
            "<leader>at",
            function() require("sidekick.cli").send({ msg = "{this}" }) end,
            mode = { "n", "x" },
            desc = "Send This",
        },
        {
            "<leader>af",
            function() require("sidekick.cli").send({ msg = "{file}" }) end,
            desc = "Send File",
        },
        {
            "<leader>ap",
            function() require("sidekick.cli").prompt() end,
            mode = { "n", "x" },
            desc = "Sidekick Select Prompt",
        },
    },
}

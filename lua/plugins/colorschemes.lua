return {
    {
        "Shatur/neovim-ayu",
        priority = 1000,
        opts = {
            overrides = {
                Normal = { bg = "None" },
                NormalFloat = { bg = "none" },
                ColorColumn = { bg = "None" },
                SignColumn = { bg = "None" },
                Folded = { bg = "None" },
                FoldColumn = { bg = "None" },
                CursorLine = { bg = "None" },
                CursorColumn = { bg = "None" },
                VertSplit = { bg = "None" },
                LineNr = { fg = "#7A8593" },
                LineNrAbove = { fg = "#7A8593" },
                LineNrBelow = { fg = "#7A8593" },
                CursorLineNr = { fg = "#E6B450", bg = "None" },
            }
        },
        config = function(_, opts)
            require("ayu").setup(opts)
            vim.cmd.colorscheme("ayu")
        end,
    },
}

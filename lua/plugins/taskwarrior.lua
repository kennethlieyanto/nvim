return {
    "matthandzel/taskwarrior.nvim",
    config = function()
        require("taskwarrior").setup({
            on_delete = "delete"
        })
    end,
}

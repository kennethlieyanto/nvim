return {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", 'mfussenegger/nvim-dap', 'folke/snacks.nvim', },
    config = function()
        local dotnet = require("easy-dotnet")
        dotnet.setup({})
    end
}

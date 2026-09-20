return {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", 'mfussenegger/nvim-dap', 'folke/snacks.nvim', },
    config = function()
        local dotnet = require("easy-dotnet")
        dotnet.setup({
            projx_lsp = {
                enabled = false, -- use standard roslyn lsp
            },
            lsp = {
                enabled = false, -- use standard roslyn lsp
            },
            auto_bootstrap_namespace = {
                type = "file_scoped",
                enabled = true,
            },
        })
    end
}

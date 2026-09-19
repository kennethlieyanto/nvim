return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    init = function()
        local ts = require("nvim-treesitter")
        local ensure_installed = { "bash", "c_sharp", "lua" }
        ts.install(ensure_installed)
    end,
    config = function()
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { '*' },
            callback = function()
                -- Enable treesitter highlighting
                pcall(vim.treesitter.start)

                -- Enable treesitter based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}

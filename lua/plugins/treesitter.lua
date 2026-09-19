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
        local function try_attach(buf, lang)
            -- Load the parser; bail if the language has none / is not installed.
            if not vim.treesitter.language.add(lang) then
                return
            end
            if not vim.api.nvim_buf_is_valid(buf) then
                return
            end

            vim.treesitter.start(buf, lang)

            -- Only use treesitter indentation if the language has an indents query;
            -- otherwise leave Neovim's filetype indentexpr in place.
            if vim.treesitter.query.get(lang, "indents") then
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "*" },
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match)
                if lang then
                    try_attach(args.buf, lang)
                end
            end,
        })
    end,
}

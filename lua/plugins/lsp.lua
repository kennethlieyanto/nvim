return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
        },
        config = function()
            vim.lsp.config("*", {
                capabilities = {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                },
            })

            vim.lsp.enable("biome")
            vim.lsp.enable("roslyn_ls")
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("nixd")

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "Buffer-local LSP keymaps",
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, fn, desc)
                        vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    map("gd", vim.lsp.buf.definition, "Go to definition")
                    map("gv", function()
                        vim.cmd("vsplit")
                        vim.lsp.buf.definition()
                    end, "Go to definition in vsplit")
                    map("<leader>gt", function()
                        vim.cmd("tab split")
                        vim.lsp.buf.definition()
                    end, "Go to definition in new tab")
                end,
            })
        end,
    },
    -- {
    --     "mason-org/mason-lspconfig.nvim",
    --     opts = {
    --         ensure_installed = { "lua_ls", "rust_analyzer", "tailwindcss", "ts_ls", "yamlls", "biome" },
    --     },
    --     dependencies = {
    --         {
    --             "mason-org/mason.nvim",
    --             opts = {
    --                 registries = {
    --                     "github:mason-org/mason-registry",
    --                     "github:Crashdummyy/mason-registry",
    --                 },
    --             },
    --         },
    --         "neovim/nvim-lspconfig",
    --     },
    -- },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>wd",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>wD",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>wq",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neo-tree/neo-tree.nvim",
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        opts = {
            keymap = { preset = "enter" },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
            signature = { enabled = true },
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}

return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                signs_staged = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                signs_staged_enable = true,
                signcolumn = true,
                numhl = false,
                linehl = false,
                word_diff = false,
                watch_gitdir = {
                    follow_files = true,
                },
                auto_attach = true,
                attach_to_untracked = false,
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol",
                    delay = 1000,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                    use_focus = true,
                },
                current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
                sign_priority = 15,
                update_debounce = 100,
                status_formatter = nil,
                max_file_length = 40000,
                preview_config = {
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
                on_attach = function(bufnr)
                    local gitsigns = require("gitsigns")

                    local function map(mode, l, r, desc)
                        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = "Git: " .. desc })
                    end

                    map("n", "]h", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]c", bang = true })
                        else
                            gitsigns.nav_hunk("next")
                        end
                    end, "Next hunk")

                    map("n", "[h", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[c", bang = true })
                        else
                            gitsigns.nav_hunk("prev")
                        end
                    end, "Previous hunk")

                    map("n", "<leader>ghs", gitsigns.stage_hunk, "Stage hunk")
                    map("n", "<leader>ghr", gitsigns.reset_hunk, "Reset hunk")

                    map("v", "<leader>ghs", function()
                        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, "Stage hunk")

                    map("v", "<leader>ghr", function()
                        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, "Reset hunk")

                    map("n", "<leader>ghS", gitsigns.stage_buffer, "Stage buffer")
                    map("n", "<leader>ghR", gitsigns.reset_buffer, "Reset buffer")
                    map("n", "<leader>ghp", gitsigns.preview_hunk, "Preview hunk")
                    map("n", "<leader>ghi", gitsigns.preview_hunk_inline, "Preview hunk inline")

                    map("n", "<leader>hb", function()
                        gitsigns.blame_line({ full = true })
                    end, "Blame line")

                    map("n", "<leader>ghd", gitsigns.diffthis, "Diff this")

                    map("n", "<leader>ghD", function()
                        gitsigns.diffthis("~")
                    end, "Diff this ~")

                    map("n", "<leader>ghQ", function()
                        gitsigns.setqflist("all")
                    end, "Set quickfix all")
                    map("n", "<leader>ghq", gitsigns.setqflist, "Set quickfix")

                    map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, "Toggle blame line")
                    map("n", "<leader>gtw", gitsigns.toggle_word_diff, "Toggle word diff")

                    map({ "o", "x" }, "gih", gitsigns.select_hunk, "Select hunk")
                end,
            })
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
    },
    {
        "esmuellert/codediff.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        cmd = "CodeDiff",
        opts = {
            explorer = {
                view_mode = "tree",
            },
        },
        keys = {
            { "<leader>wg", "<cmd>CodeDiff<cr>", desc = "Open CodeDiff" },
        },
    },
}

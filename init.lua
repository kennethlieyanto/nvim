require("config.lazy")
require("config.keymaps")
require("config.autocmds")
require("config.telescope-config")

if vim.g.vscode then
    require("config.vscode-keymaps")
end

vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.colorcolumn = "80"
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.winborder = "rounded"

local severity = vim.diagnostic.severity

vim.diagnostic.config({
    signs = {
        text = {
            [severity.ERROR] = " ",
            [severity.WARN] = " ",
            [severity.HINT] = "󰠠 ",
            [severity.INFO] = " ",
        },
    },
})

vim.lsp.config('*', {
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
})

local opencode_cmd = 'opencode --port'
---@type snacks.terminal.Opts
local snacks_terminal_opts = {
    win = {
        position = 'right',
        enter = false,
    },
}

---@type opencode.Opts
vim.g.opencode_opts = {
    server = {
        start = function()
            require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
        end,
    },
}

-- Can also leverage toggle functionality.
-- If you use <leader> here, remove 't' — otherwise Neovim will add input delay to your <leader> when typing in the terminal to watch for the mapping.
vim.keymap.set({ 'n' }, '<leader>wc', function()
    require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts)
end, { desc = 'Toggle OpenCode' })

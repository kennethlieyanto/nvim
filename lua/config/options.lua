-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "auto:2"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Editing
vim.opt.undofile = true
vim.opt.confirm = true
vim.opt.breakindent = true
vim.opt.inccommand = "split"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Appearance
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.wrap = false
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.winborder = "rounded"
vim.opt.showmode = false

-- Splits and windows
vim.opt.splitright = true
vim.opt.mouse = "a"

-- Files
vim.opt.exrc = true

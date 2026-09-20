vim.opt.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "VimResume", "TermClose", "TermEnter" }, {
    desc = "Check for external file changes",
    group = vim.api.nvim_create_augroup("checktime-on-focus", { clear = true }),
    callback = function()
        vim.cmd("checktime")
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Open help in a full-window tab",
    group = vim.api.nvim_create_augroup("help-fullscreen", { clear = true }),
    pattern = "help",
    callback = function()
        vim.cmd("wincmd T")
    end,
})

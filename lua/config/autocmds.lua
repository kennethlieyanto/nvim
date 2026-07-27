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
		vim.highlight.on_yank()
	end,
})

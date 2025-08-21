-- Force a subtle Comment fg regardless of colorscheme reloads
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("CommentFade", { clear = true }),
	callback = function()
		vim.api.nvim_set_hl(0, "Comment", { fg = "#5c6370", italic = true })
	end,
})

-- apply now (in case colorscheme already set)
vim.api.nvim_set_hl(0, "Comment", { fg = "#5c6370", italic = true })

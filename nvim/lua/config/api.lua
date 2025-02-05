-- Add commenting support for terraform files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "terraform",
	callback = function()
		vim.bo.commentstring = "# %s"
	end,
})

-- Format the current buffer when saving
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local mode = vim.api.nvim_get_mode().mode
		if vim.bo.modified == true and mode == "n" then
			vim.cmd("lua vim.lsp.buf.format()")
		end
	end,
})

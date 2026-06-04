return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato",
			auto_integrations = true,
		})

		-- give inlay hints a more muted colour scheme
		local function style_inlay()
			-- local comment = vim.api.nvim_get_hl(0, { name = "Comment" })
			vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#494d64", italic = true })
		end

		vim.api.nvim_create_autocmd("ColorScheme", { callback = style_inlay })
		style_inlay()

		vim.cmd.colorscheme("catppuccin")
	end,
}

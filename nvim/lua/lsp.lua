vim.lsp.config("*", {
	flags = {
		debounce_text_changes = 150,
	},
})

require("lspconfig")

local servers = {
	"lua_ls",
	"gopls",
}

vim.lsp.enable(servers)

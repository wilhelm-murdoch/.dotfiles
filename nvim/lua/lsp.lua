vim.lsp.config("*", {
	flags = {
		debounce_text_changes = 150,
	},
})

require("lspconfig")

local servers = {
	"lua_ls",
	"gopls",
	"terraformls",
	"bashls",
}

vim.lsp.enable(servers)

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
	-- The two grammar layers. harper_ls is the fast one and runs on each
	-- keystroke. ltex_plus is the deep one and runs on save, against the
	-- LanguageTool server in the homelab. They do not duplicate each other:
	-- lsp/ltex_plus.lua turns off every rule that both engines report.
	"harper_ls",
	"ltex_plus",
}

vim.lsp.enable(servers)

-- ltex_plus needs the network. Stop it when the homelab is unreachable, for
-- example on a train. harper_ls keeps working, because it is local.
vim.api.nvim_create_user_command("Ltex", function()
	local clients = vim.lsp.get_clients({ name = "ltex_plus" })

	if #clients > 0 then
		vim.lsp.enable("ltex_plus", false)
		for _, client in ipairs(clients) do
			client:stop()
		end
		vim.notify("ltex-ls-plus off")
	else
		vim.lsp.enable("ltex_plus", true)
		vim.cmd("doautocmd FileType")
		vim.notify("ltex-ls-plus on")
	end
end, { desc = "Toggle the deep LanguageTool check" })

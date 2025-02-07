return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		"isak102/telescope-git-file-history.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	lazy = false,
	opts = {
		pickers = {
			find_files = {
				hidden = true,
			},
			git_files = {
				hidden = true,
			},
		},
		defaults = {
			file_ignore_patterns = {
				"node_modules/*",
				".git/*",
			},
		},
		extensions = {
			fzf = {},
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("undo")
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("git_file_history")
	end,
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find all files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find in files" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find in open buffers" },
	},
}

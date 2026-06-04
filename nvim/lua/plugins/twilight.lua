return {
	"folke/twilight.nvim",
	event = "VeryLazy",
	opts = {
		context = 10,
		dimming = {
			alpha = 0.25,
		},
		expand = {
			"function",
			"method",
		},
	},
	config = function(_, opts)
		require("twilight").setup(opts)
		require("twilight").enable()
	end,
}

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})

			local actions = require("telescope.actions")
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"-C=0",
					},
					mappings = {
						i = {
							["<esc>"] = "close",
							["<C-j>"] = "move_selection_next",
							["<C-k>"] = "move_selection_previous",
							["<C-q>"] = "send_selected_to_qflist",
						},
						n = {
							["j"] = "move_selection_next",
							["k"] = "move_selection_previous",
						},
					},
				},
			})
			-- telescope.load_extension("fzf")
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
		config = true,
	},
	-- {
	-- 	"nvim-telescope/telescope-ui-select.nvim",
	-- 	-- This is your opts table
	-- 	config = function()
	-- 		require("telescope").setup({
	-- 			extensions = {
	-- 				["ui-select"] = {
	-- 					require("telescope.themes").get_dropdown({
	-- 						-- even more opts
	-- 					}),
	-- 					-- pseudo code / specification for writing custom displays, like the one
	-- 					-- for "codeactions"
	-- 					-- specific_opts = {
	-- 					--   [kind] = {
	-- 					--     make_indexed = function(items) -> indexed_items, width,
	-- 					--     make_displayer = function(widths) -> displayer
	-- 					--     make_display = function(displayer) -> function(e)
	-- 					--     make_ordinal = function(e) -> string
	-- 					--   },
	-- 					--   -- for example to disable the custom builtin "codeactions" display
	-- 					--      do the following
	-- 					--   codeactions = false,
	-- 					-- }
	-- 				},
	-- 			},
	-- 		})
	-- 		-- To get ui-select loaded and working with telescope, you need to call
	-- 		-- load_extension, somewhere after setup function:
	-- 		require("telescope").load_extension("ui-select")
	-- 	end,
	-- },
}

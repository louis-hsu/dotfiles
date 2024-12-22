return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
				build = "make",
			},
			-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files in CWD" })
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find recent files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find string in CWD" })
			vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Find string under cursor in CWD" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffer" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find LSP diagnostics result" })

			local actions = require("telescope.actions")
			local telescope = require("telescope")

			local function set_telescope_layout()
				local columns = vim.o.columns
				local layout

				if columns > 120 then
					layout = "horizontal"
				elseif columns > 100 then
					layout = "flex"
				else
					layout = "vertical"
				end

				telescope.setup({
					defaults = {
						layout_config = {
							-- For default layout
							horizontal = {
								width = 0.7, -- 80% of total width
								height = 0.9, -- 90% of total height
								preview_width = 0.6, -- 60% of width for preview pane
								results_width = 0.4, -- 40% of width for results pane
								prompt_position = "top",
							},
							-- For vertical layout
							vertical = {
								width = 0.7,
								height = 0.9,
								preview_height = 0.5, -- 50% of height for preview pane
								prompt_position = "top",
								-- results_height = 0.5, -- Comment out since it causes error
							},
							-- -- For dropdown layout (when window is small)
							-- cursor = {
							-- 	width = 0.5,
							-- 	height = 0.7,
							-- 	preview_cutoff = 40, -- Preview will be hidden if results less than this
							-- },
							flex = {
								flip_columns = 100,
								prompt_position = "top",
							},
						},
						sorting_strategy = "ascending",
						layout_strategy = layout,
					},
				})
			end

			-- Create an autocommand to reset layout when window is resized
			vim.api.nvim_create_autocmd({ "VimResized" }, {
				callback = set_telescope_layout,
			})
			-- Initial setup
			set_telescope_layout()

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
							["<esc>"] = actions.close,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							-- Remove default mappings first (optional)
							["<C-u>"] = false,
							["<C-d>"] = false,
							-- For page scrolling
							-- ["<C-b>"] = actions.preview_scrolling_page_up,
							-- ["<C-f>"] = actions.preview_scrolling_page_down,
							["<C-h>"] = actions.preview_scrolling_up,
							["<C-l>"] = actions.preview_scrolling_down,
						},
						-- n = {
						-- 	["j"] = "move_selection_next",
						-- 	["k"] = "move_selection_previous",
						-- },
					},
				},
			})
			telescope.load_extension("fzf")
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

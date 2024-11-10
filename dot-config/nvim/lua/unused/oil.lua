return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	config = function()
		local oil = require("oil")
		-- Define a function to calculate the width and height dynamically
		local function get_float_dimensions()
			-- local width = vim.api.nvim_win_get_width(0) -- Get the current window width
			-- local height = vim.api.nvim_win_get_height(0) -- Get the current window height
			local width = vim.o.columns
			local height = vim.o.lines

			-- Calculate 60% of the width and 60% of the height
			local max_width = math.floor(width * 0.6)
			local max_height = math.floor(height * 0.6)

			return max_width, max_height
		end

		-- Get calculated dimensions
		local max_width, max_height = get_float_dimensions()

		oil.setup({
			keymaps = {
				["<C-v>"] = {
					"actions.select",
					opts = { vertical = true },
					desc = "Open the entry in a vertical split",
				},
				["<Esc>"] = "actions.close",
			},
			win_options = {
				signcolumn = "auto",
			},
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, bufnr)
					-- List of filenames to hide
					local hide_files = {
						["thumbs.db"] = true,
						["undo"] = true,
						["Icon\r"] = true,
						[".DS_Store"] = true,
					}
					-- Check if the current file's name is in the hide_files list
					return hide_files[name] or false
				end,
			},
			float = {
				-- Padding around the floating window
				padding = 2,
				max_width = max_width,
				max_height = max_height,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
				-- optionally override the oil buffers window title with custom function: fun(winid: integer): string
				get_win_title = nil,
				-- preview_split: Split direction: "auto", "left", "right", "above", "below".
				preview_split = "auto",
				-- This is the config that will be passed to nvim_open_win.
				-- Change values here to customize the layout
				override = function(conf)
					return conf
				end,
			},
		})
	end,
	keys = {
		{
			"-",
			"<Cmd>Oil --float<CR>",
			mode = "n",
			noremap = true,
			silent = true,
			desc = "Open parent directory",
		},
	},
}

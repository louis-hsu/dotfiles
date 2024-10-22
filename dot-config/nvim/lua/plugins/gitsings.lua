return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local config = require("gitsigns")
		config.setup({
			signs = {
				add = { text = "+" },
				change = { text = "!" },
				delete = { text = "_", show_count = true },
				topdelete = { text = "‾", show_count = true },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "+" },
				change = { text = "!" },
				delete = { text = "_", show_count = true },
				topdelete = { text = "‾", show_count = true },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			numhl = true,
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end)

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end)

				-- Actions
				--map('n', '<leader>hs', gitsigns.stage_hunk)
				--map('n', '<leader>hr', gitsigns.reset_hunk)
				--map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
				--map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
				--map('n', '<leader>hS', gitsigns.stage_buffer)
				--map('n', '<leader>hu', gitsigns.undo_stage_hunk)
				--map('n', '<leader>hR', gitsigns.reset_buffer)
				--map('n', '<leader>hp', gitsigns.preview_hunk)
				--map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
				map("n", "<leader>gb", gitsigns.toggle_current_line_blame)
				--map("n", "<leader>gd", gitsigns.diffthis)
				map("n", "<leader>gD", function()
					gitsigns.diffthis("~")
				end)
				map("n", "<leader>Gd", gitsigns.toggle_deleted)

				-- Define the toggle function for git diff
				local function toggle_git_diff()
					if vim.wo.diff then
						-- If in diff mode, turn off diff and close the diff window on the left
						vim.cmd("diffoff") 		-- Turn off the diff mode in all windows
						vim.cmd("wincmd h") 	-- Move to the left window (diff window)
						vim.cmd("bd") 				-- Close the diff window
					else
						-- Otherwise, show the git diff with gitsigns
						require("gitsigns").diffthis()
					end
				end

				-- Key mapping for toggling git diff with <leader>gd
				vim.keymap.set("n", "<leader>gd", toggle_git_diff, { noremap = true, silent = true })
			end,
		})
	end,
}

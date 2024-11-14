return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local function close_diff_and_restore(original_winnr)
			-- Store current position
			local cur_pos = vim.fn.getcurpos()

			-- Find and close the diff window
			local windows = vim.api.nvim_list_wins()
			for _, winid in ipairs(windows) do
				if vim.api.nvim_win_get_option(winid, "diff") then
					vim.api.nvim_win_close(winid, true)
					break
				end
			end

			-- Restore focus to original window
			vim.api.nvim_set_current_win(original_winnr)
			-- Restore cursor position
			vim.fn.setpos(".", cur_pos)
		end

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

				local function diffthis()
					local original_winnr = vim.api.nvim_get_current_win()

					-- Check if diff window already exists
					local diff_exists = false
					local windows = vim.api.nvim_list_wins()
					for _, winid in ipairs(windows) do
						if vim.api.nvim_win_get_option(winid, "diff") then
							diff_exists = true
							break
						end
					end

					if diff_exists then
						-- Close diff and restore focus
						close_diff_and_restore(original_winnr)
					else
						-- Call original diffthis function
						gitsigns.diffthis()

						-- Return focus to original window
						vim.api.nvim_set_current_win(original_winnr)
					end
				end

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]g", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end)

				map("n", "[g", function()
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
				-- local function toggle_git_diff()
				-- 	local last_win = vim.fn.win_getid(vim.fn.winnr("#"))
				--
				-- 	if vim.wo.diff then
				-- 		-- If in diff mode, turn off diff and close the diff window on the left
				-- 		vim.cmd("diffoff") -- Turn off the diff mode in all windows
				-- 		vim.cmd("wincmd h") -- Move to the left window (diff window)
				-- 		vim.cmd("bd") -- Close the diff window
				--
				-- 		-- Return focus to the last active window if it's still valid
				-- 		if last_win and vim.api.nvim_win_is_valid(last_win) then
				-- 			vim.api.nvim_set_current_win(last_win)
				-- 		end
				-- 	else
				-- 		-- Otherwise, show the git diff with gitsigns
				-- 		require("gitsigns").diffthis()
				-- 	end
				-- end

				-- Key mapping for toggling git diff with <leader>gd
				vim.keymap.set("n", "<leader>gd", diffthis, { buffer = bufnr, noremap = true, silent = true })
			end,
		})
	end,
}

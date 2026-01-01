-- Check if the file is new or empty, and add the shebang if necessary
local first_line = vim.fn.getline(1)
if first_line == "" then
	vim.fn.setline(1, {
		"#!/usr/bin/env bash ",
		"set -euo pipefail		# Exit on error, undefined vars, pipe fails",
		"IFS=$'\\n\\t'					# Set IFS splits on newline/tab only",
		"",
		"# Script description",
		"# Usage: script_name.sh [options] <arguments>",
		"# Author: Louis Hsu",
		"# Date:",
	})
	-- vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0) + 1, 0 })
	-- vim.cmd("normal! o") -- Move the cursor to a new line after '#'
	require("utilis.cursor").move_cursor_below_last_line()
end

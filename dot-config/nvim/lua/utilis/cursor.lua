local M = {}

function M.move_cursor_below_last_line()
	vim.schedule(function()
		local bufnr = vim.api.nvim_get_current_buf()
		local line_count = vim.api.nvim_buf_line_count(bufnr)

		-- 如果最後一行不是空的，就新增一行
		local last_line = vim.api.nvim_buf_get_lines(bufnr, line_count - 1, line_count, false)[1]
		if last_line ~= "" then
			vim.api.nvim_buf_set_lines(bufnr, line_count, line_count, false, { "" })
			line_count = line_count + 1
		end

		-- 移動游標到 buffer 的最後一行（現在是空的）
		vim.api.nvim_win_set_cursor(0, { line_count, 0 })
	end)
end

return M

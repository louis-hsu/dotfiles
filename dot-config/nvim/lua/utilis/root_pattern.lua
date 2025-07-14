local M = {}

function M.closest_root_pattern(patterns)
	return function(fname)
		local path = vim.fs.dirname(fname)
		while path do
			for _, pattern in ipairs(patterns) do
				if vim.fn.glob(path .. "/" .. pattern) ~= "" then
					return path -- Closest upward match
				end
			end
			local parent = vim.fs.dirname(path)
			if parent == path then
				break
			end
			path = parent
		end
		return nil
	end
end

return M

-- Softer diagnostics that blend with Catppuccin Mocha + your Comment color

local palette = {
	error = "#f38ba8",  -- soft red
	warn = "#e5c890",   -- softer yellow
	info = "#89b4fa",   -- blue
	hint = "#94e2d5",   -- teal
	ok = "#a6e3a1",     -- green
	comment = "#5c6370", -- your Comment color (virtual text uses this)
}

-- Muted variants for virtual text
local muted = {
	-- error = "#e6a2a2",
	-- warn = "#d9c19a",
	-- info = "#a2c3e8",
	-- hint = "#a8dcd2",
	-- ok = "#b9ddb3",
	error = "#ad5f74",
	warn = "#a18e63",
	info = "#5c7fb4",
	hint = "#669f96",
	ok = "#6a8c68",
}

local function apply()
	vim.o.termguicolors = true

	-- Core text
	vim.api.nvim_set_hl(0, "DiagnosticError", { fg = palette.error, italic = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = palette.warn, italic = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = palette.info, italic = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = palette.hint, italic = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "DiagnosticOk", { fg = palette.ok, italic = true, bg = "NONE" })

	-- Virtual text (less saturated, muted palette)
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = muted.error, bg = "NONE", italic = true })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = muted.warn, bg = "NONE", italic = true })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = muted.info, bg = "NONE", italic = true })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = muted.hint, bg = "NONE", italic = true })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk", { fg = muted.ok, bg = "NONE", italic = true })
	-- -- Virtual text: faint like comments, no bg
	-- for _, sev in ipairs({ "Error", "Warn", "Info", "Hint", "Ok" }) do
	-- 	vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. sev, { fg = palette.comment, bg = "NONE", italic = true })
	-- end

	-- Signs: colored, no bg
	vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = palette.error, bg = "NONE" })
	vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = palette.warn, bg = "NONE" })
	vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = palette.info, bg = "NONE" })
	vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = palette.hint, bg = "NONE" })
	vim.api.nvim_set_hl(0, "DiagnosticSignOk", { fg = palette.ok, bg = "NONE" })

	-- Underlines: squiggly undercurl
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = palette.error })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = palette.warn })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = palette.info })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = palette.hint })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { undercurl = true, sp = palette.ok })

	-- Float polish
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.comment, bg = "NONE" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
end

-- Gentle diagnostic behavior to pair with subtle look
local function config_diag()
	vim.diagnostic.config({
		virtual_text = { spacing = 6, severity = nil },
		underline = true,
		signs = true,
		update_in_insert = false,
		severity_sort = true,
		-- float = { border = "rounded", source = "if_many", header = "", prefix = "●" },
		float = { border = "rounded", source = "if_many", header = "", focusable = false, style = "minimal" },
	})
end

-- Re-apply on colorscheme changes (Catppuccin reloads a lot)
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("DiagnosticsSoft", { clear = true }),
	callback = function()
		-- ensure Comment stays your color, then diagnostics use it
		vim.api.nvim_set_hl(0, "Comment", { fg = "#5c6370", italic = true })
		apply()
	end,
})

-- Apply now
apply()
config_diag()

-- Optional: a convenience toggle if you decide to add a “reset” later
vim.api.nvim_create_user_command("DiagnosticsSoftRefresh", function()
	apply()
end, {})

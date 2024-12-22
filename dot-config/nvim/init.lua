-- luajit, which support lua 5.1 only, needs to specify library path
-- The library installation also needs to specify lua path:
-- luarocks --lua-version=5.1 --lua-dir=$(brew --prefix luajit) install <library>
-- Louis 2024/1222
package.path = package.path .. ";/Users/nshiu/.luarocks/share/lua/5.1/?.lua"
package.cpath = package.cpath .. ";/Users/nshiu/.luarocks/lib/lua/5.1/?.so"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("vim-keymappings")
require("lazy").setup("plugins")

-- Shows diagnostic float window automatically
-- note: this setting is global and should be set only once
vim.o.updatetime = 250 -- Reduce updatetime which affects CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
	--  buffer = bufnr,
	callback = function()
		local opts = {
			--      focusable = false,
			--      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			--      border = 'rounded',
			--      source = 'if_many',
			--      prefix = '■ ',
			--      scope = 'cursor',
			--			severity_sort = 'true',
		}
		vim.diagnostic.open_float(nil, opts)
	end,
})

-- Supress background transparency of pop-up windows
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1E1E1E" }) -- Replace with your desired background color
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1E1E1E" }) -- Set border background
vim.api.nvim_set_hl(0, "LspHover", { bg = "#1E1E1E" }) -- Set hover window background

-- Lua function to delete old undo files
local function cleanup_undo_files()
	local undo_dir = os.getenv("XDG_CONFIG_HOME") .. "/nvim/undo"
	local cmd = "find " .. undo_dir .. " -type f -mtime +30 -exec rm {} \\;"
	os.execute(cmd)
end

-- Run the cleanup function when exiting Neovim
vim.api.nvim_create_autocmd("VimLeave", {
	callback = cleanup_undo_files,
})

-- Enable 'no-neck-pain' automatically when window width >= 160
local been_wider = false
local been_narrower = false

local function check_window_width()
	local width = vim.api.nvim_win_get_width(0)

	if width >= 160 and not been_wider then
		vim.cmd("NoNeckPain")
		been_wider = true
		been_narrower = false
	elseif width < 160 and not been_narrower then
		vim.cmd("NoNeckPain")
		been_wider = false
		been_narrower = true
	end
end

vim.api.nvim_create_autocmd({ "VimEnter", "VimResized" }, {
	callback = function()
		check_window_width()
	end,
})

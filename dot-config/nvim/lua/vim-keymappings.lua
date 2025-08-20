vim.g.mapleader = " "
vim.g.maplocalleader = "`"

-- Navigate vim panes better
vim.keymap.set("n", "<C-k>", "<Cmd>wincmd k<CR>")
vim.keymap.set("n", "<C-j>", "<Cmd>wincmd j<CR>")
vim.keymap.set("n", "<C-h>", "<Cmd>wincmd h<CR>")
vim.keymap.set("n", "<C-l>", "<Cmd>wincmd l<CR>")

-- Remove the customized keymapping since original ones are also intuitive:
-- C-W v -> Vertical split
-- C-W s -> Horizontal split
-- Louis 2025/0613
-- vim.keymap.set("n", "<C-W>\\", "<Cmd>vsplit<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-W>-", "<Cmd>split<CR>", { noremap = true, silent = true })

-- Remove highlight of current searching targets
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Turn off search highlight" })

-- Move 'j','k' through virutal lines, and '5j'/'5k' jumps 5 lines
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, noremap = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, noremap = true })

-- Map <leader>q to close the quickfix list created
vim.keymap.set("n", "<leader>q", function()
	if vim.fn.getwininfo(vim.fn.getqflist({ winid = 0 }).winid) ~= nil then
		vim.cmd("cclose")
	elseif vim.fn.getwininfo(vim.fn.getloclist(0, { winid = 0 }).winid) ~= nil then
		vim.cmd("lclose")
	end
end, { desc = "Close quickfix list pane" })

-- Helper that writes the buffer only when appropriate, then runs a command
local function save_if_needed_then(cmd)
	local bo = vim.bo
	if bo.modifiable and not bo.readonly and bo.modified then
		-- Protect against errors like "No file name" or write failures
		pcall(vim.cmd.write)
	end
	vim.cmd(cmd) -- e.g. "bnext" or "bprevious"
end

-- Next buffer on <Tab>
vim.keymap.set("n", "<Tab>", function()
	save_if_needed_then("bnext")
end, { silent = true, desc = "Save-if-needed, then :bnext" })

-- Previous buffer on <S-Tab>
vim.keymap.set("n", "<S-Tab>", function()
	save_if_needed_then("bprevious")
end, { silent = true, desc = "Save-if-needed, then :bprevious" })
-- function SmartBufferDelete()
-- 	-- Get the number of listed (non-hidden) buffers
-- 	local listed_buffers = 0
-- 	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
-- 		if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
-- 			listed_buffers = listed_buffers + 1
-- 		end
-- 	end
--
-- 	-- Get the number of windows
-- 	local window_count = vim.api.nvim_tabpage_list_wins(0)
--
-- 	if listed_buffers <= 1 and window_count > 1 then
-- 		-- If only one buffer left and multiple windows, close all but one window
-- 		vim.cmd("only")
-- 	else
-- 		-- Normal buffer delete
-- 		vim.cmd("bd")
-- 	end
-- end
--
-- vim.api.nvim_set_keymap("n", "<leader>bd", ":lua SmartBufferDelete()<CR>", { noremap = true, silent = true })

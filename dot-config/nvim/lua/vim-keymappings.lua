vim.g.mapleader = " "
vim.g.maplocalleader = "`"

-- Navigate vim panes better
vim.keymap.set("n", "<C-k>", "<Cmd>wincmd k<CR>")
vim.keymap.set("n", "<C-j>", "<Cmd>wincmd j<CR>")
vim.keymap.set("n", "<C-h>", "<Cmd>wincmd h<CR>")
vim.keymap.set("n", "<C-l>", "<Cmd>wincmd l<CR>")

vim.keymap.set("n", "<C-W>\\", "<Cmd>vsplit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-W>-", "<Cmd>split<CR>", { noremap = true, silent = true })

-- Remove highlight of current searching targets
vim.keymap.set("n", "<leader>h", "<Cmd>nohlsearch<CR>")

-- Move 'j','k' through virutal lines, and '5j'/'5k' jumps 5 lines
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, noremap = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, noremap = true })

-- Toggle Neotree on/off with <C-n>
--vim.keymap.set("n", "<C-n>", "<Cmd>Neotree toggle filesystem reveal left<CR>", { noremap = true, silent = true })

-- Map <leader>q to close the quickfix list created
vim.keymap.set("n", "<leader>q", function()
	if vim.fn.getwininfo(vim.fn.getqflist({ winid = 0 }).winid) ~= nil then
		vim.cmd("cclose")
	elseif vim.fn.getwininfo(vim.fn.getloclist(0, { winid = 0 }).winid) ~= nil then
		vim.cmd("lclose")
	end
end, { desc = "Close quickfix list pane" })

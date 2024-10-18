-- Set indentation settings for Python files
vim.bo.shiftwidth = 4  -- Set the number of spaces to use for auto-indentation
vim.bo.tabstop = 4     -- Set the number of spaces that a tab character represents
vim.bo.expandtab = true -- Use spaces instead of tabs for indentation

-- Check if the file is new or empty, and add the Python shebang if necessary
local first_line = vim.fn.getline(1)
if first_line == "" then
  vim.fn.setline(1, "#!/usr/bin/env python3")
  vim.cmd("normal! o")  -- Move cursor to a new line after the shebang
end

-- Keybinding for running the current Python file
vim.keymap.set('n', '<leader>r', ':!python3 %<CR>', { noremap = true, silent = true })

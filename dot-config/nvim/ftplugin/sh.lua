-- Check if the file is new or empty, and add the shebang if necessary
local first_line = vim.fn.getline(1)
if first_line == "" then
  vim.fn.setline(1, "#!/bin/bash -e")
  vim.cmd("normal! o")  -- Move the cursor to a new line after '#'
end

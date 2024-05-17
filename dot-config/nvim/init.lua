-- You will need to install language servers `npm i -g vscode-langservers-extracted` and `npm install -g typescript typescript-language-server`

require("plugins")
require("options")
--require("setup.spelling")
require("mappings")

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

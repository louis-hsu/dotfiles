-- For tab setup
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.smarttab = true

vim.wo.number = true -- Show line number
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for copy/paste
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.scrolloff = 4 -- At least 4 lines visible at top or bottom
vim.opt.sidescrolloff = 8 -- At least 8 columns visible at right or left
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.termguicolors = true

-- For search setup
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Do not ignore case which capitals
vim.opt.incsearch = true -- Show the match while typing
vim.opt.inccommand = "split" -- Get a preview of replacements

-- For line auto-wrap
vim.opt.wrap = true -- Optionally enable visual wrapping
vim.opt.textwidth = 80 -- Set length to 80
--vim.opt.colorcolumn = "80"
vim.opt.formatoptions:append("t") -- Enable automatic text wrapping while typing
vim.opt.linebreak = true -- Stop words being broken on wrap

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.cursorcolumn = true
vim.opt.signcolumn = "yes:1" -- Always show signcolumns

vim.opt.undodir = vim.fn.stdpath("config") .. "/undo"
vim.opt.undofile = true

vim.g.lazygit_floating_window_scaling_factor = 0.8 -- Adjust this value to scale the windows

-- Add for Neovide -- Louis 12/02/2022
-- vim.opt.guifont = { "FiraCode Nerd Font Mono", ":h12" }
vim.opt.guifont = { "JetBrainsMono Nerd Font Mono", ":h12" }
vim.g.neovide_remember_window_size = { "v:true" }
vim.g.neovide_cursor_animation_length = 0.06
vim.g.neovide_cursor_vfx_mode = "ripple"

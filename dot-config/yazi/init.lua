require("git"):setup()
require("eza-preview"):setup({
	-- Determines the directory depth level to tree preview (default: 3)
	level = 3,
	-- Whether to follow symlinks when previewing directories (default: false)
	follow_symlinks = true,
	-- Whether to show target file info instead of symlink info (default: false)
	dereference = true,
})

-- Or use default settings with empty table
require("eza-preview"):setup({})

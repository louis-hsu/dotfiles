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
require("githead"):setup({})

-- git.yazi symbols
THEME.git = THEME.git or {}
THEME.git.modified = ui.Style():fg("blue")
THEME.git.modified_sign = "✱"

THEME.git.deleted = ui.Style():fg("red")
THEME.git.deleted_sign = "✖"

THEME.git.added = ui.Style():fg("green")
THEME.git.added_sign = "✚"

THEME.git.untracked = ui.Style():fg("yellow")
THEME.git.untracked_sign = ""

THEME.git.ignored = ui.Style():fg("#696969"):italic()
THEME.git.ignored_sign = "I"
-- THEME.git.updated_sign = "U"

require("git"):setup()

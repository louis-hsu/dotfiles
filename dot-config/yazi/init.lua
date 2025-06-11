require("eza-preview"):setup({
	-- Determines the directory depth level to tree preview (default: 3)
	level = 3,
	-- Whether to follow symlinks when previewing directories (default: false)
	follow_symlinks = true,
	-- Whether to show target file info instead of symlink info (default: false)
	dereference = true,
})

require("githead"):setup({})

-- git.yazi symbols
th.git = th.git or {}
th.git.modified = ui.Style():fg("blue")
th.git.modified_sign = "✱"

th.git.deleted = ui.Style():fg("red")
th.git.deleted_sign = "✖"

th.git.added = ui.Style():fg("green")
th.git.added_sign = "✚"

th.git.untracked = ui.Style():fg("yellow")
th.git.untracked_sign = ""

th.git.ignored = ui.Style():fg("#696969"):italic()
th.git.ignored_sign = "I"
-- th.git.updated_sign = "U"

require("git"):setup()

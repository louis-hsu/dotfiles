require("eza-preview"):setup({
	-- Determines the directory depth level to tree preview (default: 3)
	level = 3,
	-- Whether to follow symlinks when previewing directories (default: false)
	follow_symlinks = true,
	-- Whether to show target file info instead of symlink info (default: false)
	dereference = true,
	ignore_glob = { ".DS_Store", "Icon?", ".git", "cache" },
	git_ignore = false,
	-- git_status = true,
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

--
-- Status:children_add(function(self)
-- 	local h = self._current.hovered
-- 	if h and h.link_to then
-- 		return " -> " .. tostring(h.link_to)
-- 	else
-- 		return ""
-- 	end
-- end, 3300, Status.LEFT)

Status:children_add(function()
	local h = cx.active.current.hovered
	if not h or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		" ",
	})
end, 500, Status.RIGHT)

Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ""
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)

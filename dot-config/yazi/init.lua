function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%b %d %H:%M", time)
	else
		time = os.date("%b %d  %Y", time)
	end

	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end

-- Customize border type
require("full-border"):setup{
	set = "rounded",
}

-- Show user/group of files in status bar
Status:children_add(function()
	local h = cx.active.current.hovered
	if not h or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line {
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		" ",
	}
end, 500, Status.RIGHT)

-- Show username and hostname in header
Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ""
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)

require("git"):setup(
	{ order = 1500, }
)

require("githead"):setup({
  order = {
    "__spacer__",
    "stashes",
    "__spacer__",
    "state",
    "__spacer__",
    "staged",
    "__spacer__",
    "unstaged",
    "__spacer__",
    "untracked",
    "__spacer__",
    "branch",
    "remote_branch",
    "__spacer__",
    "tag",
    "__spacer__",
    "commit",
    "__spacer__",
    "behind_ahead_remote",
    "__spacer__",
  },

  branch_borders = "{}",
  branch_prefix = "|",
  branch_color = "#7aa2f7",
  remote_branch_color = "#9ece6a",
  always_show_remote_branch = true,
  always_show_remote_repo = true,

  tag_symbol = "󰓼",
  always_show_tag = true,
  tag_color = "#bb9af7",

  commit_symbol = "",
  always_show_commit = true,
  commit_color = "#e0af68",

  staged_color = "#73daca",
  staged_symbol = "●",

  unstaged_color = "#e0af68",
  unstaged_symbol = "✗",
	-- unstaged_symbol = "✱",

  untracked_color = "#f7768e",
  untracked_symbol = "?",

  state_color = "#f5c359",
  state_symbol = "󱐋",

  stashes_color = "#565f89",
  stashes_symbol = "⚑",
})

require("eza-preview"):setup({
  -- -- Set the tree preview to be default (default: true)
  -- default_tree = true,
  --
  -- -- Directory depth level for tree preview (default: 3)
  level = 2,
  --
  -- -- Show file icons
  -- icons = true,
  --
  -- -- Follow symlinks when previewing directories (default: true)
  -- follow_symlinks = true,
  --
  -- -- Show target file info instead of symlink info (default: false)
  -- dereference = false,
  --
  -- -- Show hidden files (default: true)
  -- all = true,
  --
  -- Ignore files matching patterns (default: {})
  -- ignore_glob = "*.log"
  -- ignore_glob = { "*.tmp", "node_modules", ".git", ".DS_Store" }
  -- SEE: https://www.linuxjournal.com/content/pattern-matching-bash to learn about glob patterns
  ignore_glob = { "*.tmp*", "node_modules", ".git", ".DS_Store", ".localized", "Icon\r" },

  -- -- Ignore files mentioned in '.gitignore'  (default: true)
  git_ignore = false,
  --
  -- -- Show git status (default: false)
  -- git_status = false
})

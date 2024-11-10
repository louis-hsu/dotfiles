return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				-- Open selected file in current buffer
				commands = {
					open = function(state)
						local current_node = state.tree:get_node()
						if current_node.type == "file" then
							vim.cmd("Neotree close")
							vim.cmd("edit " .. current_node.path)
						elseif current_node.type == "directory" then
							if current_node:is_expanded() then
								current_node:collapse()
							else
								current_node:expand()
								-- Traverse parent direcotry and collapse other expanded
								-- directories
								local parent_id = current_node:get_parent_id()
								if parent_id ~= nil then
									local parent = state.tree:get_node(parent_id)
									if parent then
										local child_ids = parent:get_child_ids()
										for _, id in ipairs(child_ids) do
											local child = state.tree:get_node(id)
											if
												child.type == "directory"
												and child ~= current_node
												and child:is_expanded()
											then
												child:collapse()
											end
										end
									end
								end
							end
							state.commands.refresh(state)
						end
					end,
				},
				filtered_items = {
					visible = true,
					show_hidden_count = true,
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_by_name = {
						".git",
					},
					never_show = {
						".DS_Store",
						"undo",
						"thumbs.db",
					},
					never_show_by_pattern = {
						"Icon?",
					},
				},
				window = {
					popup = {
						position = { col = "25%", row = "0" },
						size = function(state)
							local root_name = vim.fn.fnamemodify(state.path, ":~")
							local root_len = string.len(root_name) + 4
							return {
								width = math.max(root_len, 50),
								height = vim.o.lines - 6,
							}
						end,
					},
				},
			},
			default_component_configs = {
				git_status = {
					symbols = {
						-- Change type
						added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "✱", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "✖", -- this can only be used in the git_status source
						renamed = "󰁕", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "✔︎",
						conflict = "",
					},
				},
			},
		})
	end,
	keys = {
		{
			"<C-n>",
			"<Cmd>Neotree toggle float<CR>",
			mode = "n",
			noremap = true,
			silent = true,
			desc = "Toggle Neo-tree",
		},
		{
			"<C-m>",
			"<Cmd>Neotree toggle filesystem reveal left<CR>",
			mode = "n",
			noremap = true,
			silent = true,
			desc = "Toggle Neo-tree",
		},
	},
}

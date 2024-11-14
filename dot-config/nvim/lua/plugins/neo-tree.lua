return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		-- Go back to original buffer after <esc>
		local function custom_esc_commands()
			local commands = require("neo-tree.sources.filesystem.commands")
			-- local original_cancel = commands.cancel
			-- Create our custom cancel command
			commands.cancel = function(state)
				-- Store the current window ID before closing Neo-tree
				local current_win = vim.api.nvim_get_current_win()
				local last_win = vim.fn.win_getid(vim.fn.winnr("#"))

				vim.cmd("Neotree close")

				-- Return focus to the last active window if it's still valid
				if last_win and vim.api.nvim_win_is_valid(last_win) then
					vim.api.nvim_set_current_win(last_win)
				end
			end
		end

		-- Open selected file in current buffer
		local function custom_open_commands()
			local commands = require("neo-tree.sources.filesystem.commands")

			commands.open = function(state)
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

									if child.type == "directory" and child ~= current_node and child:is_expanded() then
										child:collapse()
									end
								end
							end
						end
					end
					state.commands.refresh(state)
				end
			end
		end

		-- Call setup_custom_commands before neo-tree setup
		custom_open_commands()
		custom_esc_commands()

		require("neo-tree").setup({
			sources = { "filesystem", "buffers", "git_status" },
			source_selector = {
				winbar = true,
				content_layout = "center",
				sources = {
					{ source = "filesystem" },
					{ source = "buffers" },
					{ source = "git_status" },
					-- { source = "document_symbols"},
				},
			},
			buffers = {
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--              -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
			},

			filesystem = {
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
					-- mappings = {
					-- 	["<esc>"] = "cancel",
					-- },
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
			mappings = {
				["<esc>"] = "cancel",
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
			"f<C-n>",
			"<Cmd>Neotree toggle filesystem reveal left<CR>",
			mode = "n",
			noremap = true,
			silent = true,
			desc = "Toggle Neo-tree",
		},
	},
}

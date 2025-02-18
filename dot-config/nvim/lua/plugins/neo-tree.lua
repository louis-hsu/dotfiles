return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		-- Create custom command to go back to original buffer after <esc>
		local function custom_esc_commands()
			local commands = require("neo-tree.sources.filesystem.commands")
			commands.cancel = function()
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
			event_handlers = {
				handler = function()
					vim.opt_local.signcolumn = "auto:3"
				end,
			},

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
					enabled = true,     -- This will find and focus the file in the active buffer every time
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
				components = {
					diagnostics = function(config, node, state)
						local diag = require("neo-tree.sources.common.components").diagnostics(config, node, state)
						if diag and diag.text then
							diag.text = diag.text .. " "
						end
						return diag
					end,
				},
			},

			default_component_configs = {
				indent = {
					padding = 0,
					indent_size = 2,
				},
				git_status = {
					padding = " ",
					symbols = {
						-- Change type
						added = "✚",
						modified = "✱",
						deleted = "✖",
						renamed = "󰁕",
						-- Status type
						untracked = "",
						ignored = "󱑓",
						unstaged = "󰄱",
						staged = "󰱒",
						-- staged = "✔︎",
						conflict = "󰞇",
						-- conflict = "",
					},
				},
			},

			mappings = {
				["<esc>"] = "cancel",
			},

			window = {
				position = "left",
				width = 50,
				auto_expand_width = false,

				popup = {
					-- Place window at the left side of main window,
					-- Or align to the left of terminal if NNP buffer is too small
					position = function()
						local nt_width = 50
						local nnp_width = 120            -- NNP
						local vim_window_width = vim.o.columns -- The width of window vim launched in

						if math.ceil((vim_window_width - nnp_width) / 2) >= nt_width then
							-- return { col = (vim_window_width - nt_width - nnp_width) }
							return {
								col = math.ceil((vim_window_width - nnp_width) / 2 - nt_width),
								row = 0,
							}
						else
							return {
								col = 0,
								row = 0,
							}
						end
					end,
					-- Change to fix width
					size = {
						width = 50,
						height = vim.o.lines - 2,
					},
				},
			},
		})
	end,
	keys = {
		{
			"<C-n>",
			function()
				if vim.g.no_neck_pain_active then
					vim.cmd("Neotree toggle float")
				else
					vim.cmd("Neotree toggle filesystem reveal left")
				end
			end,
			mode = "n",
			noremap = true,
			silent = true,
			desc = "Toggle Neo-tree",
		},
		-- {
		-- 	"f<C-n>",
		-- 	"<Cmd>Neotree toggle filesystem reveal left<CR>",
		-- 	mode = "n",
		-- 	noremap = true,
		-- 	silent = true,
		-- 	desc = "Toggle Neo-tree",
		-- },
	},
}

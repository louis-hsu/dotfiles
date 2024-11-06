return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	lazy = true,
	--event = "BufReadPre",
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("dapui").setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		dap.adapters.bashdb = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
			name = "bashdb",
		}
		dap.configurations.sh = {
			{
				type = "bashdb",
				request = "launch",
				name = "Launch file",
				showDebugOutput = true,
				pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
				pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
				trace = true,
				file = "${file}",
				program = "${file}",
				cwd = "${workspaceFolder}",
				pathCat = "cat",
				pathBash = "/opt/homebrew/bin/bash",
				pathMkfifo = "mkfifo",
				pathPkill = "pkill",
				args = {},
				env = {},
				terminalKind = "integrated",
			},
		}

		--vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
		--vim.keymap.set("n", "<leader>dc", dap.continue, {})
		--vim.keymap.set("n", "<leader>dq", dapui.close, {})
	end,
	keys = {
		{ "<leader>dc", "<Cmd>DapContinue<CR>", desc = "DAP Continue" },
		{ "<leader>db", "<Cmd>DapToggleBreakpoint<CR>", desc = "DAP Toggle Breakpoint" },
		{
			"<leader>dq",
			function()
				require("dap").terminate()
				require("dapui").close()
				require("dap").clear_breakpoints()
			end,
			desc = "Terminate DAP and close DAP UI",
		},
		--{ "<F10>", ":lua require'dap'.step_over()<CR>", desc = "DAP Step Over" },
		--{ "<F11>", ":lua require'dap'.step_into()<CR>", desc = "DAP Step Into" },
		--{ "<F12>", ":lua require'dap'.step_out()<CR>", desc = "DAP Step Out" },
	},
}

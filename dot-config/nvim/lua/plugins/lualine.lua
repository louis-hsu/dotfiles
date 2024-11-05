return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local l_dracula = require("lualine.themes.dracula")
		l_dracula.normal.a.bg = "#8ac6f2"
		l_dracula.insert.a.bg = "#95e454"
		l_dracula.replace.a.bg = "#e5786d"

		require("lualine").setup({
			options = {
				theme = l_dracula,
			},
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
			},
		})
	end,
}

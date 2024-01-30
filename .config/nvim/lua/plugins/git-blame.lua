return {
	"f-person/git-blame.nvim",
	config = function()
		require("gitblame").setup({
			-- TODO: maybe ignore "oil" filetypes
			enabled = true,
		})
	end,
}

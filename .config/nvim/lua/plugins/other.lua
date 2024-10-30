-- https://github.com/rgroli/other.nvim
return {
	"rgroli/other.nvim",
	event = "VeryLazy",
	config = function()
		require("other-nvim").setup({
			mappings = {
				{
					-- %. is to escape '.'
					pattern = "(.*)/__tests__/(.*)%.test%.(.*)$",
					target = {
						{
							target = "%1/%2.%3",
							context = "impl",
						},
					},
				},
				{
					-- NOTE: this is a bit of a hack since "pattern" is not a true regex. I
					-- wanted to use negative lookahead to exclude files under the
					-- __tests__ directory, but instead, I'm just excluding files that
					-- are under a directory that starts with an underscore.
					pattern = "(.*)/([^_][^/]+)/([^/]+)%.([t|j]sx?)$",
					target = {
						{
							target = "%1/%2/__tests__/%3.test.%4",
							context = "test",
						},
					},
				},
			},
		})
	end,
}

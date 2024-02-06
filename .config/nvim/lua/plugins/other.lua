-- https://github.com/rgroli/other.nvim
return {
	"rgroli/other.nvim",
	event = "VeryLazy",
	config = function()
		require("other-nvim").setup({
			mappings = {
				{
					-- %. is to escape '.'
					pattern = "(.*)/__tests__/(.*)%.test%.[t|j]sx?$",
					target = {
						{
							target = "%1/%2.tsx",
							context = "impl",
						},
						{
							target = "%1/%2.ts",
							context = "impl",
						},
						{
							target = "%1/%2.jsx",
							context = "impl",
						},
						{
							target = "%1/%2.js",
							context = "impl",
						},
					},
				},
				{
					pattern = "(.*)/(.*)%.[t|j]sx?$",
					target = {
						{
							target = "%1/__tests__/%2.test.tsx",
							context = "test",
						},
						{
							target = "%1/__tests__/%2.test.ts",
							context = "test",
						},
						{
							target = "%1/__tests__/%2.test.jsx",
							context = "test",
						},
						{
							target = "%1/__tests__/%2.test.js",
							context = "test",
						},
					},
				},
			},
		})
	end,
}

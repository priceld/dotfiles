return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				["lua"] = { "stylua" },
				-- Conform will run multiple formatters sequentially
				-- Use a sub-list to run only the first available formatter
				["javascript"] = { "prettier" },
				["javascriptreact"] = { "prettier" },
				["typescript"] = { "prettier" },
				["typescriptreact"] = { "prettier" },
				["css"] = { "prettier" },
				["scss"] = { "prettier" },
				["less"] = { "prettier" },
				["html"] = { "prettier" },
				["json"] = { "prettier" },
				["jsonc"] = { "prettier" },
				-- Disable formatting for YAML files since it messes up our locale file conventions
				--["yaml"] = { "prettier" },
				["markdown"] = { "prettier" },
				["markdown.mdx"] = { "prettier" },
			},
			-- I disabled this while working on Ally
			format_on_save = {
				timeout_ms = 5000,
				lsp_fallback = true,
			},
		})
	end,
}

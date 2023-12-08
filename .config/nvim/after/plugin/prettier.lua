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
		["yaml"] = { "prettier" },
		["markdown"] = { "prettier" },
		["markdown.mdx"] = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 5000,
		lsp_fallback = true,
	},
})


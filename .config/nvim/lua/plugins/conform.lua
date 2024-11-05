return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	-- lazy.nvim will actually define commands of these names that will load
	-- the plugin, then turn around an execute the command again with the
	-- same name. This only works though, because lazy.nvim will remove the
	-- command it created. So it is important that these event be defined
	-- (if desired) as part of the definition of the plugin.
	cmd = { "ConformInfo", "Format" },
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

		-- Define a command to trigger formatting of the current buffer/selection.
		-- NOTE: it is important that this happen as part of loading the plugin
		-- definition
		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end
			require("conform").format({ async = true, lsp_format = "fallback", range = range })
		end, { range = true })
	end,
}

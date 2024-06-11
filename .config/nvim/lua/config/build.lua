-- Functions for building and typechecking packages in an ultra worktree.
vim.api.nvim_create_user_command("Build", function()
	local buf_path = vim.api.nvim_buf_get_name(0)
	-- This should only run for packages in an ultra worktree
	local _, _, package = string.find(buf_path, "work/ultra/[^/]+/(packages/[^/]+)")
	if not package then
		return
	end
	vim.cmd("compiler ultratsc")
	-- Use vim's make command so that the quickfix list is populated.
	vim.cmd("make " .. package)
end, {})

vim.api.nvim_create_user_command("TestTypecheck", function()
	local buf_path = vim.api.nvim_buf_get_name(0)
	-- This should only run for packages in an ultra worktree
	local _, _, package = string.find(buf_path, "work/ultra/[^/]+/(packages/[^/]+)")
	if not package then
		return
	end
	vim.cmd("compiler ultratsc")
	vim.cmd("make " .. package .. " tsconfig.test.json --noEmit")
end, {})

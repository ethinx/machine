local M = {}

function M.config()
	vim.cmd([[
    autocmd FileType nix setlocal commentstring=#\ %s
  ]])
end

return M

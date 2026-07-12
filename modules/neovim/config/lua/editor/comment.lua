local M = {}

function M.config()
  require('Comment').setup()
  -- vim.cmd([[
  --   autocmd FileType nix setlocal commentstring=#\ %s
  -- ]])
end

return M

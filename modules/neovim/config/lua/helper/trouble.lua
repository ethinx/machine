local M = {}

function M.config()
  local opts = {
    auto_close = true,
    auto_jump = { 'lsp_definitions', 'lsp_type_definitions' },
    action_keys = {
      jump_close = { "<cr>" },
      jump = {},
    }
  }

  local trouble = require('trouble')
  trouble.setup(opts)

  local keymap_opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "n", "<leader>d", [[<cmd>TroubleToggle document_diagnostics<cr>]], keymap_opts)
end

return M

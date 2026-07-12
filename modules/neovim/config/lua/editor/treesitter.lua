local M = {}

local ensure_installed = {
  "bash",
  "fish",
  "beancount",
  "c",
  "cpp",
  "make",
  "dockerfile",
  "dot",
  "go",
  "gomod",
  "gowork",
  "hcl",
  "html",
  "css",
  "json",
  "yaml",
  "toml",
  "javascript",
  "typescript",
  "tsx",
  "vue",
  "python",
  "perl",
  "lua",
  "ruby",
  "rego",
  "regex",
  "vim",
  "nix",
}

function M.config()
  local treesitter = require("nvim-treesitter")
  treesitter.setup({})
  treesitter.install(ensure_installed)

  local group = vim.api.nvim_create_augroup("user_treesitter", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
      local language = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
      if language == nil or not vim.list_contains(treesitter.get_installed(), language) then
        return
      end

      vim.treesitter.start(args.buf, language)
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo.foldmethod = "expr"
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M

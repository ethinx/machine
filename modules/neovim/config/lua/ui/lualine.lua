local M = {}

function M.config()
  local navic = require('nvim-navic')
  navic.setup({
  })

  require('lualine').setup {
    options = {
      icons_enabled = true,
      -- theme = 'papercolor_dark',
      theme = 'auto',
      component_separators = { left = '|', right = '|' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = false,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = {
        { 'filename' },
        {
          function()
            return navic.get_location()
          end,
          cond = function()
            return navic.is_available()
          end,
          color = { fg = "#f3ca28" },
        },
      },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = {}
  }
end

return M

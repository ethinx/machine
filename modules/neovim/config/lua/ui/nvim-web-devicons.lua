local M = {}

function M.config()
  require('nvim-web-devicons').setup({
    override = {
      ["markdown"] = {
        icon = "",
        color = "#519aba",
        cterm_color = "67",
        name = "Markdown",
      },
      ["md"] = {
        icon = "",
        color = "#519aba",
        cterm_color = "67",
        name = "Md",
      },
      ["mdx"] = {
        icon = "",
        color = "#519aba",
        cterm_color = "67",
        name = "Mdx",
      },
    };
  })
end

return M

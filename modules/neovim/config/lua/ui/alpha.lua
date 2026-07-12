local M = {}

function M.dashboard()
  local header = {
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠵⢟⡒⢛⣭⣷⣶⣿⣿⣿⣿⣿⣿⣿⣶⡭⢊⣒⣛⣿⠿⣿⣿⣷⣬⠻⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢯⣩⠀⠤⣫⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⢿⣛⢿⣿⣾⣍⡲⢝⢻⣿⣷⡹⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⣡⠎⢼⣿⣿⣿⣿⣿⢖⣢⣴⣿⣿⣿⣿⣿⣿⡯⡻⣷⣝⢿⣿⣿⣦⡀⠙⢿⣷⢹⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣱⡁⠓⡋⣦⢸⣿⣿⣿⢟⣵⣿⣿⡿⠋⣴⡟⣿⣿⣏⣿⡡⠻⡟⡈⠻⣿⣿⣿⡄⣄⠻⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢠⢋⣼⠉⠇⠂⢻⣿⣏⣾⣿⣿⡟⣱⣿⣿⢟⣿⢿⡿⠸⡇⠁⠀⢠⠀⢎⢿⡟⣿⡸⣦⠹⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢾⢟⠀⠖⠠⣀⠽⢸⣿⣿⢣⢀⣾⢟⣵⢻⡟⢸⢧⠀⡇⢰⣃⠄⢳⠠⢣⠃⠼⠁⢿⣧⢿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣠⡞⣼⡟⠀⢁⠹⣷⣸⣿⣿⠀⢈⢣⣿⢣⠸⠁⠈⡏⠀⢃⠈⣧⠀⠊⢸⡟⣧⠀⠀⣄⠙⢾⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡹⠹⣿⠘⠡⢁⠱⣿⠇⣿⣿⠀⠈⡿⡱⡋⢁⡞⠐⡜⠰⡨⢰⣿⠀⠀⡆⡆⡿⠀⠀⠿⢷⣄⠙⢿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡖⡝⢀⡄⢁⡁⠺⠀⡹⣿⣇⢸⠱⡑⠈⢪⢂⣈⠡⡰⢢⣿⠇⣶⠀⡿⠇⡓⣠⣌⢄⢠⡨⣇⠈⢿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢛⡭⠶⠀⠘⠸⡜⣦⡉⢂⡌⣰⡹⣿⡎⢃⣀⠾⠁⠉⢠⣥⣷⣿⣿⣼⣿⡠⣵⣤⢶⣿⣿⣦⢂⣿⣎⢣⣸]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠀⠁⠀⠀⠀⢀⠈⠀⠘⠇⡇⣲⠀⣷⢝⢷⣎⠊⡄⠀⢀⡈⣿⣿⣿⣿⣿⣿⣷⢸⣿⢸⣿⣿⣿⡇⢸⣿⡎⡇]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⢀⣤⢢⡇⠀⠁⠀⠀⢜⢈⠧⠸⡄⡳⣝⢧⡁⡢⠴⣨⣼⣿⣿⣿⣿⣿⣿⣿⢇⣿⣿⣿⣿⢇⢸⣿⡇⡇]],
    [[⣿⢟⣻⣭⣭⣿⣍⠉⠉⠁⠀⠐⠛⢣⣿⡇⣠⡀⠀⠀⠈⣷⣍⠁⠹⣜⢮⡻⣮⡻⣿⣿⣿⣿⣿⣟⡫⢵⣿⢫⣾⣿⣷⣭⣵⣾⢸⣿⠃⣼]],
    [[⡿⣼⣿⣿⣿⣿⠿⢗⣀⣀⣠⣤⣴⣿⣿⢷⣿⡇⠀⠀⠀⢸⣶⢰⣷⣬⡪⣛⢶⣭⣪⠏⠙⠻⠿⣿⣷⣿⢣⣿⣿⣿⣿⣿⣿⢇⡾⣣⣾⣿]],
    [[⡇⣿⡿⣛⣥⣶⣿⣿⣿⣿⣿⣿⣿⣿⢏⡾⠟⢡⡆⠀⠀⣀⢣⢋⣿⣿⣿⣮⣑⠌⠝⣳⠦⣌⠦⣭⣭⣵⣿⣿⣿⣿⣿⣿⣷⣿⣾⣿⣿⣿]],
    [[⡿⣫⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀⢀⣾⣧⣰⡟⣡⣿⣿⣿⣿⣿⣿⣿⣿⢦⣶⣮⣥⣈⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⢀⣾⣿⠿⣫⣾⣿⣿⣿⣿⣿⣿⣿⣿⣽⣾⣷⣶⣶⣿⣭⣆⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀⠀⠀⢠⣿⡿⣣⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⢳⡜⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣯⣥⣤⣤⣤⣤⣤⣶⣶⡿⢫⣾⣿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢋⣴⣿⣟⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⢣⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢟⣼⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢣⣿⣿⣿⣿⣿⣿⣿⣿⣿⢧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣾⣿⣿⣿⣿⣿⣿⣿⣿⢯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣟⣾⢸⣿⣿⣿⣿⣇⣿⣿⣿⣿⣿⣿⣿⣿⡟⣼⣿⣿⣿⣿⣿⣿⣿⡿⣣⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
  }
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  local leader = " "

  --- @param sc string
  --- @param txt string
  --- @param keybind string optional
  --- @param keybind_opts table optional
  local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
      position = "center",
      shortcut = sc,
      cursor = 5,
      width = 50,
      align_shortcut = "right",
      hl_shortcut = "Keyword",
    }
    if keybind then
      keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
      opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
      -- local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
      local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
      vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
      type = "button",
      val = txt,
      on_press = on_press,
      opts = opts,
    }
  end

  dashboard.section.header.val = header

  dashboard.section.buttons.val = {
    -- button("e", "  New file", "<cmd>ene <CR>", {}),
    button("e", "  New file", ":ene <BAR> startinsert <CR>", {}),
    button("f", "  Find file", "<cmd>Telescope find_files<CR>", {}),
    button("g", "  Live grep", "<cmd>Telescope live_grep<CR>", {}),
    button("o", "  Recent files", "<cmd>Telescope oldfiles<CR>", {}),
    button("p", "  Find Project", "<cmd>Telescope projects<CR>", {}),
    button("z", "  Packer Sync", "<cmd>PackerSync<CR>", {}),
    button("c", "  NeoVim Configuration", ":e ~/.config/nvim/lua/plugins.lua<CR>", {}),
    button("q", "  Quit", "<cmd>qa!<cr>", {}),
    -- button("SPC f h", "  Recently opened files"),
    -- button("SPC f r", "  Frecency/MRU"),
    -- button("SPC f g", "  Find word"),
    -- button("SPC f m", "  Jump to bookmarks"),
    -- button("SPC s l", "  Open last session"),
  }

  local function footer()
    local total_plugins = require("lazy").stats().count
    return " v"
        .. vim.version().major
        .. "."
        .. vim.version().minor
        .. "."
        .. vim.version().patch
        .. "   "
        .. total_plugins
        .. " plugins"
  end

  dashboard.section.footer.val = footer()
  dashboard.section.footer.opts.hl = "Function"

  alpha.setup(dashboard.config)
end

return M

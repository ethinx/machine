local M = {}

function M.config()
  local whichkey = require("which-key")

  local conf = {
    delay = 500,
    triggers = {
      { "<leader>", mode = { "n" } },
    },
  }

  local mappings = {
    { "<leader>b",  group = "Buffer",                               nowait = false,                remap = false },
    { "<leader>bD", "<Cmd>%bd|e#|bd#<Cr>",                          desc = "Delete all buffers",   nowait = false, remap = false },
    { "<leader>bc", "<Cmd>bd!<Cr>",                                 desc = "Close current buffer", nowait = false, remap = false },
    { "<leader>bp", "<Cmd>BufferLinePick<Cr>",                      desc = "Pick Buffer",          nowait = false, remap = false },
    { "<leader>f",  group = "Telescope Find",                       nowait = false,                remap = false },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",                   desc = "Buffers",              nowait = false, remap = false },
    { "<leader>fc", "<cmd>Telescope commands<cr>",                  desc = "Commands",             nowait = false, remap = false },
    { "<leader>fe", "<cmd>NvimTreeToggle<cr>",                      desc = "Explorer",             nowait = false, remap = false },
    { "<leader>ff", "<cmd>Telescope find_files<cr>",                desc = "Files",                nowait = false, remap = false },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",                 desc = "Live Grep",            nowait = false, remap = false },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>",                  desc = "Old Files",            nowait = false, remap = false },
    { "<leader>fp", "<cmd>Telescope projects<cr>",                  desc = "Projects",             nowait = false, remap = false },
    { "<leader>fr", "<cmd>Telescope file_browser<cr>",              desc = "Browser",              nowait = false, remap = false },
    { "<leader>fw", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Current Buffer",       nowait = false, remap = false },
    { "<leader>h",  group = "hop motion",                           nowait = false,                remap = false },
    { "<leader>hc", "<cmd>HopChar1<cr>",                            desc = "1-char mode",          nowait = false, remap = false },
    { "<leader>hl", "<cmd>HopLine<cr>",                             desc = "line mode",            nowait = false, remap = false },
    { "<leader>hw", "<cmd>HopWord<cr>",                             desc = "word mode",            nowait = false, remap = false },
    { "<leader>q",  "<cmd>q!<CR>",                                  desc = "Quit",                 nowait = false, remap = false },
    { "<leader>w",  "<cmd>update!<CR>",                             desc = "Save",                 nowait = false, remap = false },
    { "<leader>x",  "<cmd>x<CR>",                                   desc = "Save & Quit",          nowait = false, remap = false },
    { "<leader>z",  group = "Packer",                               nowait = false,                remap = false },
    { "<leader>zC", "<cmd>PackerClean<cr>",                         desc = "Clean",                nowait = false, remap = false },
    { "<leader>zS", "<cmd>PackerStatus<cr>",                        desc = "Status",               nowait = false, remap = false },
    { "<leader>zc", "<cmd>PackerCompile<cr>",                       desc = "Compile",              nowait = false, remap = false },
    { "<leader>zi", "<cmd>PackerInstall<cr>",                       desc = "Install",              nowait = false, remap = false },
    { "<leader>zs", "<cmd>PackerSync<cr>",                          desc = "Sync",                 nowait = false, remap = false },
    { "<leader>zu", "<cmd>PackerUpdate<cr>",                        desc = "Update",               nowait = false, remap = false },
  }

  whichkey.add(mappings)
  whichkey.setup(conf)
end

return M

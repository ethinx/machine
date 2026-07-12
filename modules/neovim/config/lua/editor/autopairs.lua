-- Setup nvim-cmp.
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

local rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
local utils = require('nvim-autopairs.utils')

-- https://github.com/windwp/nvim-autopairs/issues/147#issuecomment-952639522
local function multiline_close_jump(open, close)
  return rule(close, '')
      :with_pair(function()
        local row, col = utils.get_cursor()
        -- https://github.com/RubixDev/.dotfiles/blob/main/.config/nvim/lua/rubixdev/plugin/autopairs.lua#L37
        local line = utils.text_get_current_line(0)

        if #line ~= col then --not at EOL
          return false
        end

        local unclosed_count = 0
        for c in line:gmatch("[\\" .. open .. "\\" .. close .. "]") do
          if c == open then unclosed_count = unclosed_count + 1 end
          if unclosed_count > 0 and c == close then unclosed_count = unclosed_count - 1 end
        end
        if unclosed_count > 0 then return false end

        local nextrow = row + 1
        if nextrow < vim.api.nvim_buf_line_count(0)
            and vim.regex("^\\s*" .. close):match_line(0, nextrow) then
          return true
        end
        return false
      end)
      :with_move(cond.none())
      :with_cr(cond.none())
      :with_del(cond.none())
      :set_end_pair_length(0)
      :replace_endpair(function()
        return '<esc>xEa'
      end)
end

npairs.setup {
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,%:%/] ]], "%s+", ""),
    offset = 0, -- Offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
}

npairs.add_rules {
  multiline_close_jump('(', ')'),
  multiline_close_jump('[', ']'),
  multiline_close_jump('{', '}'),

  -- https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#add-spaces-between-parentheses
  rule(' ', ' '):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({ '()', '[]', '{}' }, pair)
  end),
  rule('( ', ' )')
      :with_pair(cond.none())
      :with_move(function(opts) return opts.prev_char:match('.%)') ~= nil end)
      :use_key(')'),
  rule('{ ', ' }')
      :with_pair(cond.none())
      :with_move(function(opts) return opts.prev_char:match('.%}') ~= nil end)
      :use_key('}'),
  rule('[ ', ' ]')
      :with_pair(cond.none())
      :with_move(function(opts) return opts.prev_char:match('.%]') ~= nil end)
      :use_key(']'),
}

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

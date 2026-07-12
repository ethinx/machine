return {
  {
    "towolf/vim-helm",
    -- event = "BufRead",
  },
  {
    "joshdick/onedark.vim",
    lazy = true,
    config = function()
      vim.cmd("colorscheme onedark")
    end,
  },
  {
    "goolord/alpha-nvim", -- startup screen
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      {
        "joshdick/onedark.vim",
        config = function()
          vim.cmd("colorscheme onedark")
        end,
      },
    },
    config = require('ui.alpha').dashboard
  },
  {
    "SmiteshP/nvim-navic",
    event = {
      "BufRead",
      -- "CursorMoved",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "windwp/nvim-autopairs",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "BufRead",
    config = require("ui.lualine").config,
    dependencies = {
      {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "InsertEnter",
    config = function()
      require("ui.gitsigns")
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "BufRead",
    dependencies = {
      "moll/vim-bbye",
    },
    config = function()
      require("ui.bufferline")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    event = "VeryLazy",
    config = function()
      require("ui.indent-blankline")
    end,
  },

  {
    "editorconfig/editorconfig-vim",
    lazy = true,
  },
  {
    "tpope/vim-repeat",
    lazy = true,
  },
  {
    "folke/which-key.nvim",
    config = require("helper.whichkey").config,
    event = "VeryLazy",
    dependencies = {
      'echasnovski/mini.nvim',
    }
  },
  {
    -- "kyazdani42/nvim-tree.lua",
    "nvim-tree/nvim-tree.lua",
    -- event = "BufEnter",
    cmd = {
      "NvimTreeOpen",
      "NvimTreeToggle",
    },
    config = function()
      require("helper.nvim-tree")
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- editor
  {
    "simrat39/symbols-outline.nvim",
    event = "VeryLazy",
    config = require('editor.symbols-outline').config,
  },

  -- comment
  -- {
  --   "tpope/vim-commentary",
  --   event = {
  --     "CursorMoved",
  --     "BufRead",
  --   },
  --   config = require("editor.vim-commentary").config,
  -- },
  {
    "numToStr/Comment.nvim",
    event = {
      "CursorMoved",
      "BufRead",
    },
    config = require("editor.comment").config,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = require("editor.treesitter").config,
  },
  {
    "RRethy/vim-illuminate",
    event = "BufRead",
    config = function()
      require('illuminate').configure({
        providers = { 'lsp', 'regex' }
      })
      -- vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{reverse=true, wrap=true}<cr>'
      -- , { noremap = true })
      -- vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true, wrap=true}<cr>'
      -- , { noremap = true })
    end,
  }, -- select and move between words under cursor

  {
    "hrsh7th/nvim-cmp",
    event = {
      "InsertEnter",
      -- "CmdlineEnter"
    },
    config = function()
      require("completion.cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      {
        "L3MON4D3/LuaSnip",
        event = "BufRead",
      },
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp",
    },
  },

  {
    "junnplus/nvim-lsp-setup",
    event = {
      "BufRead",
      -- "CmdlineEnter"
    },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/nvim-lsp-installer",
      "folke/neodev.nvim",
      "neovim/nvim-lspconfig",
      "ray-x/lsp_signature.nvim",
      "RRethy/vim-illuminate",
      "p00f/clangd_extensions.nvim",
      'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    },
    -- config = require("completion.lsp-setup").config,
    config = function()
      require('lsp-setup').setup({})
      require("completion.lsp-setup").config()
    end,
  },
  -- {
  --   "lvimuser/lsp-inlayhints.nvim",
  --   event = "BufRead",
  --   branch = "anticonceal",
  --   config = function()
  --     require('helper/lsp-inlayhints')
  --   end,
  -- },

  {
    "nvim-telescope/telescope.nvim",
    -- event = "VeryLazy",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      {
        "ahmedkhalf/project.nvim",
        -- event = "VeryLazy",
        -- dependencies = {
        --   "nvim-telescope/telescope.nvim",
        -- },
        config = function()
          require("helper.project")
        end,
      },
    },
    config = function()
      require("helper.telescope")
    end,
  },

  -- Motions
  -- use({ "andymass/vim-matchup", event = "CursorMoved" }) -- 语法块 tag 跳转
  {
    "chaoren/vim-wordmotion",
    event = "BufRead",
  }, -- 单词移动
  {
    "wellle/targets.vim",
    event = "CursorMoved"
  },                          -- text object selection
  {
    "unblevable/quick-scope", -- inline moving
    event = "BufRead",
    config = function()
      vim.g.qs_filetype_blacklist = { 'alpha' }
    end,
  },

  {
    -- "phaazon/hop.nvim",
    "wsdjeg/hop.nvim",
    event = "BufRead",
    cmd = { "HopWord", "HopChar1", "HopLine" },
    config = function()
      require("hop").setup({})
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = {
      "nvim-cmp",
    },
    config = function()
      require("editor.autopairs")
    end,
  },

  -- use({
  -- 	"jose-elia-alvarez/null-ls.nvim",
  -- })

  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    config = function()
      require("helper.toggleterm")
    end,
  },

  -- https://xu3352.github.io/linux/2018/10/18/vim-table-format-in-html-or-markdown
  -- https://devhints.io/vim-easyalign
  {
    "junegunn/vim-easy-align",
    event = "CursorMoved",
  },

  -- https://github.com/mg979/vim-visual-multi/wiki/Quick-start
  -- https://yaocc.cc/2021/05/17/VIM%E5%A4%9A%E5%85%89%E6%A0%87%E6%8F%92%E4%BB%B6%E2%80%94%E2%80%94%E6%95%88%E7%8E%87MAX/
  {
    'mg979/vim-visual-multi',
    event = "CursorMoved",
  },

  {
    'folke/trouble.nvim',
    event = "VeryLazy",
    config = require('helper.trouble').config,
  },

  {
    -- 'linty-org/readline.nvim',
    'assistcontrol/readline.nvim',
    event = "InsertEnter",
    config = require('editor.readline').config
  },

  -- better substitution
  {
    'tpope/vim-abolish',
    event = "CursorMoved",
    cmd = 'S',
  },

  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = false,
        },
      })
    end,
    dependencies = {
      {
        "nvim-tree/nvim-web-devicons",
        name = "nvim-tree-nvim-web-devicons",
      },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" }
    }
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    }
  },
}

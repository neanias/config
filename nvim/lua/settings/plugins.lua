return {
  "nvim-lua/plenary.nvim",
  "folke/which-key.nvim",
  "folke/neodev.nvim",
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
  "williamboman/mason-lspconfig.nvim",
  "SmiteshP/nvim-navic",

  {
    "tpope/vim-projectionist",
    cmd = { "A", "AS", "AV" },
  },
  {
    "tpope/vim-unimpaired",
    event = "BufReadPost",
  },
  {
    "tpope/vim-repeat",
    keys = ".",
  },
  {
    "tpope/vim-fugitive",
    event = "BufReadPre",
  },
  {
    "tpope/vim-rhubarb",
    command = { "GBrowse" },
  },
  {
    -- TODO: write Lua replacement to handle case changes
    "tpope/vim-abolish",
    keys = { "crs", "crm", "crc", "cru", "cr-", "cr.", "cr<space>", "crt" },
  },

  {
    "gpanders/editorconfig.nvim",
    event = "BufReadPre",
  },
  {
    "AndrewRadev/splitjoin.vim",
    cmd = { "SplitjoinJoin", "SplitjoinSplit" },
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  },

  {
    "phaazon/hop.nvim",
    version = "~2.0.0",
    config = function()
      require("hop").setup({})
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup({})
    end,
  },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({ snippet_engine = "luasnip" })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeFindFile",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({})
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "AckslD/nvim-FeMaco.lua",
    config = function()
      require("femaco").setup()
    end,
    cmd = "FeMaco",
  },
  {
    "lucapette/vim-textobj-underscore",
    dependencies = { "kana/vim-textobj-user" },
  },
  {
    "JManch/sunset.nvim",
    lazy = false,
    config = function()
      require("sunset").setup({
        -- Edinburgh co-ords
        latitude = 55.943175,
        longitude = -3.208831,
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "BufReadPost",
    keys = { "S", "ys", "yS" },
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Ruby/Rails plugins
  {
    "tpope/vim-rails",
    cmd = { "A", "AS", "AT", "AV", "Eview", "Emodel", "Econtroller" },
    ft = { "ruby", "eruby" },
  },
  {
    "tpope/vim-rake",
    ft = "ruby",
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },

  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup()
    end,
  },

  {
    "nyngwang/NeoZoom.lua",
    keys = { "<leader>nz" },
    config = function()
      require("neo-zoom").setup()
    end,
  },
  {
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "yaml" },
  },
  {
    "junegunn/vim-easy-align",
    cmd = "EasyAlign",
  },
  {
    "tamton-aquib/duck.nvim",
    keys = { "<leader>dd", "<leader>dk" },
    config = function()
      vim.keymap.set("n", "<leader>dd", function()
        require("duck").hatch()
      end, { desc = "Hatch a duck" })
      vim.keymap.set("n", "<leader>dk", function()
        require("duck").cook()
      end, { desc = "Cook a duck" })
    end,
  },
}

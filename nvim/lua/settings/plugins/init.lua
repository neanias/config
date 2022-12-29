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
    config = true,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    config = true,
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    config = { snippet_engine = "luasnip" },
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeFindFile",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },

  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = true,
  },
  {
    "folke/trouble.nvim",
    config = true,
  },
  {
    "AckslD/nvim-FeMaco.lua",
    config = true,
    cmd = "FeMaco",
  },
  {
    "lucapette/vim-textobj-underscore",
    dependencies = { "kana/vim-textobj-user" },
  },
  {
    "JManch/sunset.nvim",
    lazy = false,
    config = {
      -- Edinburgh co-ords
      latitude = 55.943175,
      longitude = -3.208831,
    },
  },
  {
    "kylechui/nvim-surround",
    event = "BufReadPost",
    keys = { "S", "ys", "yS" },
    config = true,
  },

  -- Ruby/Rails plugins
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
    cmd = { "A", "AS", "AT", "AV", "Eview", "Emodel", "Econtroller" },
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
    config = true,
  },

  {
    "nyngwang/NeoZoom.lua",
    keys = { "<leader>nz" },
    config = true,
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
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>sr",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural replace",
      },
    },
  },
}

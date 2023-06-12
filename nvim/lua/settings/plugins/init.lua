return {
  "nvim-lua/plenary.nvim",
  "folke/neodev.nvim",
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
  "williamboman/mason-lspconfig.nvim",

  {
    "chrisgrieser/nvim-spider",
    event = "VeryLazy",
    -- lazy = false,
    keys = {
      {
        "w",
        [[<cmd>lua require("spider").motion("w")<CR>]],
        mode = { "n", "o", "x" },
        desc = "Spider-w",
      },
      {
        "e",
        [[<cmd>lua require("spider").motion("e")<CR>]],
        mode = { "n", "o", "x" },
        desc = "Spider-e",
      },
      {
        "b",
        [[<cmd>lua require("spider").motion("b")<CR>]],
        mode = { "n", "o", "x" },
        desc = "Spider-b",
      },
      {
        "ge",
        [[<cmd>lua require("spider").motion("ge")<CR>]],
        mode = { "n", "o", "x" },
        desc = "Spider-ge",
      },
    },
  },

  {
    "tpope/vim-projectionist",
    cmd = { "A", "AS", "AV" },
    version = false,
  },
  {
    "tpope/vim-repeat",
    keys = ".",
    version = false,
  },
  {
    "tpope/vim-fugitive",
    event = { "BufReadPre", "BufNewFile" },
    version = false,
  },
  {
    "tpope/vim-rhubarb",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    opts = {
      enhanced_diff_hl = true,
    },
  },

  {
    "Wansmer/treesj",
    keys = {
      {
        "sj",
        function()
          require("treesj").toggle()
        end,
        mode = { "n" },
        desc = "Toggle node",
      },
    },
    opts = {
      use_default_keymaps = false,
    },
  },
  {
    "ckolkey/ts-node-action",
    dependencies = "nvim-treesitter",
    keys = {
      {
        "sk",
        function()
          require("ts-node-action").node_action()
        end,
        mode = { "n" },
        desc = "Toggle node",
      },
    },
    opts = {},
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
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    opts = { snippet_engine = "luasnip" },
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
    "folke/which-key.nvim",
    opts = {
      show_help = false,
      plugins = {
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
      key_labels = {
        ["<leader>"] = "SPC",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
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
    "JManch/sunset.nvim",
    lazy = false,
    opts = {
      -- London :'( co-ords
      latitude = 51.507340,
      longitude = -0.127647,
    },
  },
  {
    "kylechui/nvim-surround",
    version = false,
    keys = { { "S", mode = "v" }, "ys", "yS", "cs", "ds" },
    config = true,
  },

  -- Ruby/Rails plugins
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
    cmd = { "A", "AS", "AT", "AV", "Eview", "Emodel", "Econtroller" },
    version = false,
  },
  {
    "tpope/vim-rake",
    ft = "ruby",
    version = false,
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
    keys = {
      {
        "<leader>nz",
        function()
          require("neo-zoom").neo_zoom()
        end,
        desc = "Toggle NeoZoom window",
        nowait = true,
      },
    },
    config = true,
    opts = {
      exclude_buftypes = { "terminal" },
    },
  },
  {
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "yaml" },
  },
  {
    "echasnovski/mini.align",
    event = "VeryLazy",
    config = function()
      require("mini.align").setup({})
    end,
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
  {
    "ecthelionvi/NeoComposer.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    opts = {
      colors = {
        fg = "#939f91",
        bg = "#f4f0d9",
        red = "#f85552",
        blue = "#3a94c5",
        green = "#8da101",
      },
      keymaps = {
        play_macro = "W",
      },
    },
  },
}

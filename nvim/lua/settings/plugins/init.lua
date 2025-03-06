return {
  "nvim-lua/plenary.nvim",
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = { "luvit-meta/library", words = { "vim%.uv" } },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",

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
      replace = {
        key = {
          function(key)
            return require("which-key.view").format(key)
          end,
          { "<leader>", "SPC" },
        },
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
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },

  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "MagicDuck/grug-far.nvim",
    config = true,
    cmd = "GrugFar",
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    keys = {
      {
        "<leader>qq",
        function()
          require("quicker").toggle()
        end,
        desc = "Toggle quickfix",
      },
      {
        "<leader>ql",
        function()
          require("quicker").toggle({ loclist = true })
        end,
        desc = "Toggle loclist",
      },
    },
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
      keys = {
        {
          ">",
          function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = "Expand quickfix context",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Collapse quickfix context",
        },
      },
    },
  },
}

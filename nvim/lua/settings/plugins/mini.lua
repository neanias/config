return {
  {
    "echasnovski/mini.basics",
    event = "VeryLazy",
    version = false,
    opts = {
      options = {
        basic = false,
      },
      mappings = {
        option_toggle_prefix = "yo",
      },
      autocommands = {
        basic = false,
      },
    },
    config = function(_, opts)
      require("mini.basics").setup(opts)
    end,
  },
  {
    "echasnovski/mini.bracketed",
    event = "VeryLazy",
    version = false,
    opts = {
      comment = { suffix = "k", options = {} },
      diagnostic = { suffix = "", options = {} }, -- Clashes with LSP
      treesitter = { suffix = "h", options = {} },
    },
    config = function(_, opts)
      require("mini.bracketed").setup(opts)
    end,
  },
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    version = false,
    opts = {
      mappings = {
        up = "[e",
        down = "]e",

        line_up = "[e",
        line_down = "]e",
      },
    },
    config = function(_, opts)
      require("mini.move").setup(opts)
    end,
  },
}

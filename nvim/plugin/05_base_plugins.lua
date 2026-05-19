vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/chrisgrieser/nvim-spider",

  -- folke
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/which-key.nvim",

  -- tpope
  "https://github.com/tpope/vim-projectionist",
  "https://github.com/tpope/vim-repeat",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/tpope/vim-rhubarb",
  "https://github.com/tpope/vim-rails",

  "https://github.com/Wansmer/treesj",

  -- nvim-tree
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/nvim-tree/nvim-web-devicons",

  { src = "https://github.com/kylechui/nvim-surround", vim.version.range("4.x") },
  "https://github.com/mbbill/undotree",

  "https://github.com/MagicDuck/grug-far.nvim",
})

require("lazydev").setup({ library = { "${3rd}/luv/library", words = { "vim%.uv" } } })
require("which-key").setup({
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
})

require("treesj").setup({ use_default_keymaps = false })

require("nvim-tree").setup()

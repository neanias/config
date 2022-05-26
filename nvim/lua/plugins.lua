local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd("packadd packer.nvim")
end

-- auto compile when there are changes in `plugins.lua`
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  command = "PackerCompile",
})

vim.cmd([[packadd packer.nvim]])

require("packer").startup({
  function(use)
    -- Let packer manage itself
    use("wbthomason/packer.nvim")
    -- Cache all the things
    use("lewis6991/impatient.nvim")

    use({
      "windwp/nvim-autopairs",
      config = function()
        local npairs = require("nvim-autopairs")

        npairs.setup({
          check_ts = true,
        })

        npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
        npairs.add_rules(require("nvim-autopairs.rules.endwise-ruby"))
      end,
    })

    -- Treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate", -- We recommend updating the parsers on update
    })
    use({
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-textobjects",
    })

    -- Allows for motions within/around underscores. e.g. `i_` or `a_`
    use({
      "lucapette/vim-textobj-underscore",
      requires = "kana/vim-textobj-user",
    })

    -- To keep track of bindings
    use({
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup({
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        })
      end,
    })

    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup({})
      end,
    })

    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup({})
      end,
    })

    -- Finders
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      },
    })

    use({
      "stevearc/dressing.nvim",
      config = function()
        require("dressing").setup({
          input = {
            -- No transparency for input window
            winblend = 0,
          },
          select = {
            telescope = require("telescope.themes").get_dropdown({}),
          },
        })
      end,
    })

    use({
      "neovim/nvim-lspconfig",
    })
    use({
      "jose-elias-alvarez/null-ls.nvim",
      requires = { "nvim-lua/plenary.nvim" },
    })
    use({
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup({})
      end,
    })

    use({
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    })

    use({
      "hoob3rt/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      as = "lualine",
      config = function()
        local background = vim.opt.background:get()
        require("lualine").setup({ options = { theme = "solarized_" .. background } })
      end,
    })

    -- TPope time
    use({
      "tpope/vim-abolish",
      "tpope/vim-eunuch",
      "tpope/vim-fugitive",
      "tpope/vim-obsession",
      "tpope/vim-projectionist",
      "tpope/vim-repeat",
      "tpope/vim-surround",
      "tpope/vim-unimpaired",
    })

    use({ "tpope/vim-rails", ft = { "ruby", "eruby", "haml", "slim", "coffee" } })
    use({ "tpope/vim-rake", ft = "ruby" })

    -- Better commenting
    use({
      "preservim/nerdcommenter",
      config = function()
        vim.g.NERDSpaceDelims = true
      end,
    })

    -- Nice file browsing
    use({
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-tree").setup({})
      end,
    })

    use({
      "mbbill/undotree",
      cmd = "UndotreeToggle",
    })

    use({
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("neoclip").setup()
      end,
    })

    -- Syntax & languages
    use({ "jmcantrell/vim-virtualenv", ft = "python" })
    use({ "slashmili/alchemist.vim", ft = "elixir" })

    -- EditorConfig
    use("editorconfig/editorconfig-vim")

    -- Pretty colours
    use("ishan9299/nvim-solarized-lua")
    use("p00f/nvim-ts-rainbow")

    -- Other stuff
    use({ "junegunn/vim-easy-align", cmd = "EasyAlign" })
    use({ "AndrewRadev/splitjoin.vim", branch = "main" })
    use({ "ck3g/vim-change-hash-syntax", ft = { "ruby", "eruby" } })
    use({
      "nathanaelkane/vim-indent-guides",
      config = function()
        vim.g.indent_guides_auto_colors = true
        vim.g.indent_guides_start_level = 2
        vim.g.indent_guides_guide_size = 1
      end,
    })

    -- Git times
    use({
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("gitsigns").setup()
      end,
    })

    -- Test runner
    use({
      "rcarriga/vim-ultest",
      requires = { "vim-test/vim-test" },
      run = ":UpdateRemotePlugins",
      cmd = { "Ultest", "UltestNearest" },
    })

    -- Better search
    use("henrik/vim-indexed-search")
    use("haya14busa/incsearch.vim")

    -- Vim motions on speed
    use({
      "phaazon/hop.nvim",
      branch = "v1",
      config = function()
        require("hop").setup({})
      end,
    })
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
})

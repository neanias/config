local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd("packadd packer.nvim")
end

-- auto compile when there are changes in `plugins.lua`
vim.cmd("autocmd BufWritePost plugins.lua PackerCompile")

vim.cmd([[packadd packer.nvim]])

require("packer").startup({
  function(use)
    -- Let packer manage itself
    use("wbthomason/packer.nvim")

    use({
      "windwp/nvim-autopairs",
      config = function()
        local remap = vim.api.nvim_set_keymap
        local npairs = require("nvim-autopairs")

        npairs.setup({
          check_ts = true,
        })

        npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
        npairs.add_rules(require("nvim-autopairs.rules.endwise-ruby"))
      end,
    })

    -- { Neovim 0.5.0 plugins
    -- Treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      branch = "0.5-compat",
      run = ":TSUpdate", -- We recommend updating the parsers on update
    })
    use("nvim-treesitter/nvim-treesitter-refactor")
    use({
      "romgrk/nvim-treesitter-context",
    })
    use({
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "0.5-compat",
    })

    -- To keep track of bindings
    use({
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup({})
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
        require("trouble").setup({
          auto_preview = false,
          auto_fold = true,
        })
      end,
    })

    -- Finders
    use({
      "nvim-telescope/telescope.nvim",
      requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    })

    use({
      "neovim/nvim-lspconfig",
    })

    use({
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    })
    use({
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
    })
    use({
      "saadparwaiz1/cmp_luasnip",
    })
    use({
      "rafamadriz/friendly-snippets",
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
    -- }

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

    -- Check that it actually has ctags before kick-off
    use({
      "preservim/tagbar",
      cond = function()
        return vim.call("executable", "ctags") == 1
      end,
      cmd = "TagbarToggle",
    })

    use({
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("neoclip").setup()
      end,
    })

    -- Syntax & languages
    use({
      "dense-analysis/ale",
      ft = { "typescript", "rust", "ruby", "lua" },
      cmd = { "ALEEnable", "ALEFix" },
      config = "vim.cmd[[ALEEnable]]",
    })
    use({
      "sheerun/vim-polyglot",
      config = function()
        vim.g.vim_markdown_folding_disabled = true
        vim.g.vim_markdown_frontmatter = true
      end,
    })
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
    use("AndrewRadev/switch.vim")
    use({ "ck3g/vim-change-hash-syntax", ft = { "ruby", "eruby" } })
    use({
      "nathanaelkane/vim-indent-guides",
      config = function()
        vim.g.indent_guides_auto_colors = true
        vim.g.indent_guides_start_level = 2
        vim.g.indent_guides_guide_size = 1
      end,
    })
    use({
      "nelstrom/vim-textobj-rubyblock",
      requires = {
        { "lucapette/vim-textobj-underscore" },
        { "kana/vim-textobj-user" },
      },
    })
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
      as = "hop",
      cmd = { "HopWord", "HopChar1" },
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

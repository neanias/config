local M = {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },

  dependencies = {
    "nvim-treesitter/nvim-treesitter-refactor",
    "nvim-treesitter/nvim-treesitter-textobjects",
    {
      "nvim-treesitter/playground",
      cmd = "TSPlaygroundToggle",
    },
    "RRethy/nvim-treesitter-endwise",
    "windwp/nvim-ts-autotag",
  },
}

function M.config()
  local ts_config = require("nvim-treesitter.configs")

  local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
  parser_configs.xml = {
    install_info = {
      url = "https://github.com/Trivernis/tree-sitter-xml",
      files = { "src/parser.c" },
      generate_requires_npm = true,
      branch = "main",
    },
    filetype = "xml",
  }

  ts_config.setup({
    ensure_installed = {
      "bash",
      "c",
      "c_sharp",
      "cpp",
      "css",
      "eex",
      "elixir",
      "embedded_template",
      "heex",
      "help",
      "html",
      "javascript",
      "json",
      "json5",
      "jsonc",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "ruby",
      "rust",
      "scss",
      "sql",
      "terraform",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "xml",
      "yaml",
    },
    ignore_install = {}, -- List of parsers to ignore installing
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    endwise = { enable = true },
    autotag = { enable = true },
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = {}, -- list of language that will be disabled
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        scope_incremental = "<CR>",
        node_incremental = "<Tab>",
        node_decremental = "<S-Tab>",
      },
    },
    playground = {
      enable = true,
    },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
    },
    refactor = {
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "grr",
        },
      },
    },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ar"] = "@block.outer",
          ["ir"] = "@block.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
  })
end

return M

local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false,
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
      "princejoogie/dir-telescope.nvim",
      opts = {
        hidden = true,
        respect_gitignore = true,
      },
    },
    "benfowler/telescope-luasnip.nvim",
    "neanias/telescope-lines.nvim",
    "molecule-man/telescope-menufacture",
  },
  keys = {
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find recent buffers" },
    {
      "<leader>fd",
      function()
        require("telescope").extensions.menufacture.find_files()
      end,
      desc = "find files in dir",
    },
    {
      "<leader>ff",
      function()
        require("telescope").extensions.menufacture.find_files()
      end,
      desc = "Find files in dir",
    },
    {
      "<leader>fg",
      function()
        require("telescope").extensions.menufacture.live_grep()
      end,
      desc = "Grep through the project dir",
    },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search for help tags" },
    { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Search through jumplist" },
    {
      "<leader>fl",
      "<cmd>Telescope current_buffer_fuzzy_find<cr>",
      desc = "Search through lines in the buffer",
    },
    { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Search through the man pages" },
    {
      "<leader>fo",
      "<cmd>Telescope oldfiles only_cwd=true<cr>",
      desc = "Search through recently opened files",
    },
    {
      "<leader>fp",
      "<cmd>Telescope neoclip<cr>",
      desc = "Search through the clipboard to reassign the current paste",
    },
    { "<leader>fs", "<cmd>Telescope search_history<cr>", desc = "Lists recent search history" },
    { "<leader>ft", "<cmd>Telescope treesitter<cr>", desc = "Search through treesitter tags" },
    {
      "<leader>fw",
      function()
        require("telescope").extensions.menufacture.grep_string()
      end,
      desc = "Searches for the word under the cursor",
    },
  },
}

function M.config()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local trouble = require("trouble.providers.telescope")

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<ESC>"] = actions.close,
          ["<C-U>"] = false,
        },
      },
    },
    pickers = {
      live_grep = {
        mappings = {
          i = {
            ["<C-T>"] = trouble.open_with_trouble,
          },
        },
      },
      buffers = {
        sort_lastused = true,
        mappings = {
          i = {
            ["<c-d>"] = actions.delete_buffer,
          },
        },
      },
    },
    extensions = {
      menufacture = {
        mappings = {
          main_menu = {
            [{ "i", "n" }] = "<C-f>",
          },
        },
      },
    },
  })

  telescope.load_extension("fzf")
  telescope.load_extension("dir")
  telescope.load_extension("luasnip")
  telescope.load_extension("menufacture")
  telescope.load_extension("neoclip")
  telescope.load_extension("noice")

  local telescope_augroup_id = vim.api.nvim_create_augroup("telescope", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = telescope_augroup_id,
    pattern = "TelescopePrompt",
    callback = function()
      vim.keymap.set("i", "<C-R>", "<C-R>", { silent = true, buffer = true })
    end,
  })
end

return M

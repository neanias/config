local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
      "princejoogie/dir-telescope.nvim",
      config = {
        hidden = true,
        respect_gitignore = true,
      },
    },
    {
      "LukasPietzschmann/telescope-tabs",
      config = true,
    },
    "benfowler/telescope-luasnip.nvim",
    "neanias/telescope-lines.nvim",
  },
}

function M.config()
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")
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
  })

  telescope.load_extension("fzf")
  telescope.load_extension("dir")
  telescope.load_extension("noice")
  telescope.load_extension("telescope-tabs")
  telescope.load_extension("luasnip")

  local telescope_augroup_id = vim.api.nvim_create_augroup("telescope", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = telescope_augroup_id,
    pattern = "TelescopePrompt",
    callback = function()
      vim.keymap.set("i", "<C-R>", "<C-R>", { silent = true, buffer = true })
    end,
  })

  local wk = require("which-key")

  wk.register({
    f = {
      name = "+Telescope",
      b = { "<cmd>Telescope buffers<cr>", "Find recent buffers" },
      d = { "<cmd>Telescope dir find_files<cr>", "Find files in dir" },
      f = { "<cmd>Telescope find_files<cr>", "Find files" },
      g = { "<cmd>Telescope live_grep<cr>", "Grep through the project dir" },
      h = { "<cmd>Telescope help_tags<cr>", "Search for help tags" },
      j = { "<cmd>Telescope jumplist<cr>", "Search through jumplist" },
      l = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search through lines in the buffer" },
      o = { "<cmd>Telescope old_files only_cwd=true<cr>", "Search through recently opened files" },
      -- This is still Lua as it might be lazily loaded
      p = {
        telescope.extensions.neoclip.default,
        "Search through the clipboard to reassign the current paste",
      },
      s = { "<cmd>Telescope search_history<cr>", "Lists recent search history" },
      t = { "<cmd>Telescope treesitter<cr>", "Search through treesitter tags" },
      w = { require("telescope-tabs").list_tabs, "Search tabs" },
    },
  }, {
    prefix = "<leader>",
    noremap = true,
  })
end

return M

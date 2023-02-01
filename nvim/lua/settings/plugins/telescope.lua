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
  telescope.load_extension("neoclip")

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

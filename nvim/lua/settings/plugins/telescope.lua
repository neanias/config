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

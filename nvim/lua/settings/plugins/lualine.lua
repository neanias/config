local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
}

function M.config()
  local lualine = require("lualine")

  local function window()
    return vim.api.nvim_win_get_number(0)
  end

  lualine.setup({
    options = {
      theme = "auto",
      disabled_filetypes = {
        "help",
        "startuptime",
        "qf",
        "lspinfo",
        "checkhealth",
        "man",
        "NvimTree",
        statusline = {
          "fugitive",
        },
      },
      globalstatus = true,
    },
    extensions = { "nvim-tree", "fugitive" },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {},
      lualine_x = {
        {
          require("noice").api.status.mode.get,
          cond = require("noice").api.status.mode.has,
        },
        {
          require("noice").api.status.command.get,
          cond = require("noice").api.status.command.has,
        },
        "searchcount",
      },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "branch" },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    winbar = {
      lualine_a = {
        {
          "filename",
          path = 1,
        },
      },
      lualine_b = {
        "diff",
        "diagnostics",
      },
      lualine_c = {
        {
          require("nvim-navic").get_location,
          cond = require("nvim-navic").is_available,
        },
      },
      lualine_x = { "filetype" },
      lualine_y = { window, "progress" },
      lualine_z = { "location" },
    },
    inactive_winbar = {
      lualine_c = { "filename" },
      lualine_x = { window, "location" },
      lualine_z = {},
    },
  })
end

return M

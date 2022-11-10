local lualine = require("lualine")
local navic = require("nvim-navic")

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
        require("noice").api.statusline.mode.get_hl,
        cond = require("noice").api.statusline.mode.has,
      },
      {
        require("noice").api.statusline.command.get_hl,
        cond = require("noice").api.statusline.command.has,
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
    lualine_c = { { navic.get_location, cond = navic.is_available } },
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

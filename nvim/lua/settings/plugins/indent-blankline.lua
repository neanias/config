local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>ig",
      "<cmd>IBLToggle<cr>",
      desc = "Toggle indent guides",
    },
  },
  opts = {
    enabled = false,
    exclude = {
      filetypes = { "help", "Trouble", "lazy" },
    },
    scope = {
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
    },
  },
  config = function()
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}

return M

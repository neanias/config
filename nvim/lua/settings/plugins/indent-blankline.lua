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
}

return M

local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  keys = {
    {
      "<leader>ig",
      function()
        require("indent_blankline.commands").toggle()
      end,
      desc = "Toggle indent guides",
    },
  },
  opts = {
    enabled = false,
    use_treesitter = true,
    show_current_context = true,
    show_current_context_start = true,
    filetype_exclude = { "help", "Trouble", "lazy" },
  },
}

return M

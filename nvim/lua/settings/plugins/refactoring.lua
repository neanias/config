return {
  "ThePrimeagen/refactoring.nvim",
  keys = {
    {
      "<leader>r",
      function()
        require("refactoring").select_refactor()
      end,
      mode = "v",
      noremap = true,
      silent = true,
      expr = false,
    },
    {
      "<leader>rv",
      function()
        require("refactoring").debug.print_var({})
      end,
      mode = "v",
      desc = "Debug print the variable",
    },
    {
      "<leader>rc",
      function()
        require("refactoring").debug.cleanup({})
      end,
      desc = "Clear debug print statements",
    },
    {
      "<leader>rv",
      function()
        require("refactoring").debug.print_var({ normal = true })
      end,
      desc = "Debug print the variable",
    },
  },
  opts = {},
}

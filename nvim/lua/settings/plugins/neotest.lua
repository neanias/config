local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "olimorris/neotest-rspec",
    "haydenmeade/neotest-jest",
    "nvim-neotest/neotest-python",
  },
  keys = {
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run the whole test file",
    },
    {
      "<leader>tt",
      function()
        require("neotest").run.run()
      end,
      desc = "Runs the nearest test",
    },
    {
      "<leader>tx",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop the test",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle the summary window",
    },
    {
      "<leader>ta",
      function()
        require("neotest").run.run(vim.fn.getcwd())
      end,
      desc = "Run the full test suite",
    },
    {
      "]t",
      function()
        require("neotest").jump.next()
      end,
      desc = "Jump to the next test",
    },
    {
      "[t",
      function()
        require("neotest").jump.prev()
      end,
      desc = "Jump to the previous test",
    },
  },
}

function M.config()
  require("neotest").setup({
    adapters = {
      require("neotest-rspec"),
      require("neotest-jest"),
      require("neotest-python"),
    },
  })
end

return M

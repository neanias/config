local wk = require("which-key")
local neotest = require("neotest")

wk.register({
  name = "+test",
  f = {
    function()
      neotest.run.run(vim.fn.expand("%"))
    end,
    "Run the whole test file",
  },
  t = {
    function()
      neotest.run.run()
    end,
    "Runs the nearest test",
  },
  x = {
    function()
      neotest.run.stop()
    end,
    "Stop the test",
  },
  s = {
    function()
      neotest.summary.toggle()
    end,
    "Toggle the summary window",
  },
  a = {
    function()
      neotest.run.run(vim.fn.getcwd())
    end,
    "Run the full test suite, presuming that vim's directory is the same as the project root.",
  },
}, {
  prefix = "<leader>t",
})

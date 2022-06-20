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
    neotest.run.run,
    "Runs the nearest test",
  },
  x = {
    neotest.run.stop,
    "Stop the test",
  },
  s = {
    neotest.summary.toggle,
    "Toggle the summary window",
  },
}, {
  prefix = "<leader>t",
})

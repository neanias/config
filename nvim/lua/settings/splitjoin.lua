local wk = require("which-key")

wk.register({
  j = { "<Cmd>SplitjoinSplit<CR>", "Smart split 2 lines using SplitJoin" },
  k = { "<Cmd>SplitjoinJoin<CR>", "Smart join 2 lines using SplitJoin" },
}, {
  prefix = "s",
})

local wk = require("which-key")

wk.register({
  name = "+hop",
  w = { "<cmd>HopWord<CR>", "Search for hop directions" },
  b = { "<cmd>HopWord<CR>", "Search for hop directions" },
  f = { "<cmd>HopChar1<CR>", "Search for hop directions to a certain char" },
}, {
  prefix = "<leader><leader>",
})

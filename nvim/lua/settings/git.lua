local wk = require("which-key")

wk.register({
  g = {
    name = "+git",
    s = { ":tab Git<cr>", "Open Fugitive viewer" },
    c = {
      ":tab Git commit<cr>",
      "Open Fugitive commit dialog",
    },
  },
}, {
  prefix = "<leader>",
  noremap = true,
})

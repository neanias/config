local wk = require("which-key")
require("plenary") -- Needed to stop neogit crash
local neogit = require("neogit")

neogit.setup({
  integrations = {
    diffview = true,
  }
})

wk.register({
  g = {
    name = "+neogit",
    s = { neogit.open, "Open Neogit viewer" },
    c = { function() neogit.open({ "commit" }) end, "Open Neogit commit dialog" },
  }
}, {
  prefix = "<leader>",
  noremap = true,
})

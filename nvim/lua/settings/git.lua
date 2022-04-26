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

local gs = require("gitsigns")

wk.register({
  ["]c"] = {
    function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end,
    "Go to next hunk",
  },
  ["[c"] = {
    function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end,
    "Go to previous hunk",
  },
})

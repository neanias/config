local wk = require("which-key")
local gs = require("gitsigns")

wk.register({
  g = {
    name = "+git",
    s = { ":tab Git<cr>", "Open Fugitive viewer" },
    c = {
      ":tab Git commit<cr>",
      "Open Fugitive commit dialog",
    },
    w = {
      gs.stage_buffer,
      "Stage the current buffer",
    },
    S = {
      gs.stage_hunk,
      "Stage the current hunk",
    },
  },
}, {
  prefix = "<leader>",
  noremap = true,
})

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

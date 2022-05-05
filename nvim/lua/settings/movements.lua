local hop = require("hop")
local hint = require("hop.hint")
local wk = require("which-key")

wk.register({
  name = "+hop",
  w = {
    function()
      hop.hint_words({ direction = hint.HintDirection.AFTER_CURSOR })
    end,
    "Search for hop directions",
  },
  b = {
    function()
      hop.hint_words({ direction = hint.HintDirection.BEFORE_CURSOR })
    end,
    "Search for hop directions",
  },
  f = { hop.hint_char1, "Search for hop directions to a certain char" },
  l = { hop.hint_lines_skip_whitespace, "Hop to a specific line" },
}, {
  prefix = "<leader><leader>",
})

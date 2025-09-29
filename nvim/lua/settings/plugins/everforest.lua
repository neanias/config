local M = {
  "neanias/everforest-nvim",
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  local everforest = require("everforest")
  everforest.setup({
    background = "medium",
    transparent_background_level = 0,
    italics = true,
    disable_italic_comments = false,
    inlay_hints_background = "dimmed",
    on_highlights = function(hl, palette)
      hl["@string.special.symbol.ruby"] = { link = "@field" }
      hl["DiagnosticUnderlineWarn"] = { undercurl = true, sp = palette.yellow }
    end,
  })
  everforest.load()
end

return M

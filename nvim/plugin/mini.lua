vim.pack.add({
  "https://github.com/nvim-mini/mini.align",
  "https://github.com/nvim-mini/mini.basics",
  "https://github.com/nvim-mini/mini.bracketed",
  "https://github.com/nvim-mini/mini.move",
  "https://github.com/nvim-mini/mini.hipatterns",
})

require("mini.align").setup()
require("mini.basics").setup({
  options = {
    basic = false,
  },
  mappings = {
    option_toggle_prefix = "yo",
  },
  autocommands = {
    basic = false,
  },
})

require("mini.bracketed").setup({
  comment = { suffix = "k", options = {} },
  diagnostic = { suffix = "", options = {} }, -- Clashes with LSP
  treesitter = { suffix = "h", options = {} },
})

require("mini.move").setup({
  mappings = {
    up = "[e",
    down = "]e",

    line_up = "[e",
    line_down = "]e",
  },
})

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

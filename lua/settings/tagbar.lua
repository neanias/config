-- Tagbar

local wk = require("which-key")

-- open the taglist (method browser) using ,t
wk.register({
  T = { "<Cmd>TagbarToggle<CR>", "Toggle the Tagbar", silent = true, noremap = true },
}, { prefix = "<leader>" })

vim.g.tagbar_type_ruby = {
  kinds = {
    "m:modules",
    "c:classes",
    "d:describes",
    "C:contexts",
    "f:methods",
    "F:singleton methods"
  }
}

vim.g.tagbar_type_snippets = {
  ctagstype = "snippets",
  kinds = {
    "s:snippets",
  }
}

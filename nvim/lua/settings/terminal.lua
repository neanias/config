local wk = require("which-key")

wk.register({
  ["<ESC>"] = { "<C-\\><C-n>" },
  ["<Leader><ESC>"] = { "<C-\\><C-n>" },
}, {
  noremap = true,
  mode = "t",
})

-- 100k lines of scrollback in terminal buffer:
vim.opt.scrollback = -1

-- autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
vim.cmd("autocmd TermOpen term://* startinsert")

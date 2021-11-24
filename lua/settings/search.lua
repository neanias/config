local wk = require("which-key")

vim.o.hlsearch = true
vim.g["incsearch#auto_nohlsearch"] = 1 

wk.register({
  ["/"] = { "<Plug>(incsearch-forward)", "Incremental searching forwards" },
  ["?"] = { "<Plug>(incsearch-backward)", "Incremental searching backwards" },
  ["g/"] = { "<Plug>(incsearch-stay)", "Doesn't move the cursor whilst searching unless explicitly used" },

  n = { "<Plug>(insearch-nohl-n)" },
  N = { "<Plug>(insearch-nohl-N)" },
  ["*"] = { "<Plug>(incsearch-nohl-*" },
  ["#"] = { "<Plug>(incsearch-nohl-#" },
  ["g*"] = { "<Plug>(incsearch-nohl-g*" },
  ["g#"] = { "<Plug>(incsearch-nohl-g#" },
})

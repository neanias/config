local wk = require("which-key")

wk.register({
  name = "+Trouble",
  d = { "<cmd>Trouble document_diagnostics<cr>", "Show document LSP diagnostics in Trouble" },
  l = { "<cmd>Trouble loclist<cr>", "Open loclist in Trouble dialogue" },
  q = { "<cmd>Trouble quickfix<cr>", "Open quickfix list in Trouble" },
  t = { "<cmd>TroubleToggle<cr>", "Toggle Trougle window" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Show workspace LSP diagnostics in Trouble" },
  x = { "<cmd>Trouble<cr>", "Open Trouble dialogue" },
}, {
  prefix = "<leader>x",
  silent = true,
  noremap = true,
})

wk.register({
  ["gR"] = { "<cmd>Trouble lsp_references<cr>", "Reveal LSP references under cursor in Trouble" },
}, {
  silent = true,
  noremap = true,
})

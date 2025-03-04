local wk = require("which-key")

local M = {}

function M.setup(_, buffer)
  local keymap = {
    { "<leader>l", buffer = buffer, group = "LSP" },
    {
      "<leader>la",
      vim.lsp.buf.code_action,
      buffer = buffer,
      desc = "Selects a code action from the input list that is available",
      mode = { "n", "v" },
    },
    {
      "<leader>lc",
      vim.lsp.codelens.run,
      buffer = buffer,
      desc = "Run CodeLens",
      mode = { "n", "v" },
    },
    {
      "<leader>lC",
      vim.lsp.codelens.refresh,
      buffer = buffer,
      desc = "Refresh & display CodeLens",
      mode = { "n", "v" },
    },
    {
      "<leader>lr",
      vim.lsp.buf.rename,
      buffer = buffer,
      desc = "Rename",
    },
    {
      "<leader>lq",
      function()
        vim.diagnostic.setqflist({ open = true })
      end,
      buffer = buffer,
      desc = "Puts all diagnostics in the quickfix list",
    },
    { "g", buffer = buffer, group = "LSP" },
    {
      "gD",
      vim.lsp.buf.declaration,
      buffer = buffer,
      desc = "Go to declaration",
    },
    {
      "gR",
      "<cmd>Trouble lsp_references<cr>",
      buffer = buffer,
      desc = "Reveal LSP references under cursor in Trouble",
    },
    {
      "gd",
      vim.lsp.buf.definition,
      buffer = buffer,
      desc = "Go to definition",
    },
    {
      "gi",
      vim.lsp.buf.implementation,
      buffer = buffer,
      desc = "Lists all the implementations for the symbol",
    },
    {
      "grf",
      vim.lsp.buf.references,
      buffer = buffer,
      desc = "Lists all references to the symbol under the cursor",
    },
  }

  wk.add(keymap)
end

return M

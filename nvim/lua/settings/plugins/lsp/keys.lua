local wk = require("which-key")

local M = {}

function M.setup(_, buffer)
  local keymap = {
    { "<leader>l", buffer = buffer, group = "LSP" },
    {
      "<leader>lD",
      "<cmd>Lspsaga lsp_finder<cr>",
      buffer = buffer,
      desc = "Reveals the definition of the type of the symbol",
    },
    { "<leader>lb", "<cmd>Lspsaga show_buf_diagnostics<cr>", buffer = buffer, desc = "Show buffer diagnositcs" },
    { "<leader>lc", buffer = buffer, group = "code" },
    {
      "<leader>lca",
      vim.lsp.buf.code_action,
      buffer = buffer,
      desc = "Selects a code action from the input list that is available",
    },
    {
      "<leader>lcr",
      "<cmd>Lspsaga rename<cr>",
      buffer = buffer,
      desc = "Renames all references to the symbol under the cursor",
    },
    {
      "<leader>ld",
      "<cmd>Lspsaga peek_definition<cr>",
      buffer = buffer,
      desc = "Peek the definition of the symbol under the cursor",
    },
    {
      "<leader>le",
      "<cmd>Lspsaga show_line_diagnostics ++quiet<cr>",
      buffer = buffer,
      desc = "Opens a floating window with the diagnostics for current line",
    },
    {
      "<leader>lq",
      function()
        vim.diagnostic.setqflist({ open = false })
      end,
      buffer = buffer,
      desc = "Puts all diagnostics in the quickfix list",
    },
    {
      "K",
      "<cmd>Lspsaga hover_doc<cr>",
      buffer = buffer,
      desc = "Displays hover information about the symbol under the cursor",
    },
    { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", buffer = buffer, desc = "Go to previous diagnostic" },
    { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", buffer = buffer, desc = "Go to next diagnostic" },
    { "g", buffer = buffer, group = "LSP" },
    {
      "gD",
      vim.lsp.buf.declaration,
      buffer = buffer,
      desc = "Jump to the declaration of the symbol under the cursor",
    },
    {
      "gR",
      "<cmd>Trouble lsp_references<cr>",
      buffer = buffer,
      desc = "Reveal LSP references under cursor in Trouble",
    },
    {
      "gd",
      "<cmd>Lspsaga goto_definition<cr>",
      buffer = buffer,
      desc = "Jump to the definition of the symbol under the cursor",
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
    {
      "<leader>lca",
      "<cmd>lua vim.lsp.buf.code_action()<cr>",
      buffer = buffer,
      desc = "Code action",
      mode = "v",
    },
  }

  wk.add(keymap)
end

return M

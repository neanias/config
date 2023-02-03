local wk = require("which-key")

local M = {}

function M.setup(client, buffer)
  local capabilities = client.server_capabilities

  local keymap = {
    buffer = buffer,
    ["<leader>l"] = {
      name = "+LSP",
      f = {
        {
          require("settings.plugins.lsp.formatting").format,
          "Format the current buffer",
          cond = capabilities.documentFormatting,
        },
        {
          require("settings.plugins.lsp.formatting").format,
          "Format range",
          cond = capabilities.documentRangeFormatting,
          mode = "v",
        },
      },
      b = {
        "<cmd>Lspsaga show_buf_diagnostics<cr>",
        "Show buffer diagnositcs",
      },
      c = {
        name = "+code",
        r = {
          "<cmd>Lspsaga rename<cr>",
          "Renames all references to the symbol under the cursor",
          cond = capabilities.renameProvider,
        },
        a = {
          { vim.lsp.buf.code_action, "Selects a code action from the input list that is available" },
          { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action", mode = "v" },
        },
      },
      d = { "<cmd>Lspsaga peek_definition<cr>", "Peek the definition of the symbol under the cursor" },
      D = { "<cmd>Lspsaga lsp_finder<cr>", "Reveals the definition of the type of the symbol" },
      e = {
        "<cmd>Lspsaga show_line_diagnostics ++quiet<cr>",
        "Opens a floating window with the diagnostics for current line",
      },
      q = {
        function()
          vim.diagnostic.setqflist({ open = false })
        end,
        "Puts all diagnostics in the quickfix list",
      },
    },
    g = {
      name = "+LSP",
      D = { vim.lsp.buf.declaration, "Jump to the declaration of the symbol under the cursor" },
      d = { "<cmd>Lspsaga goto_definition<cr>", "Jump to the definition of the symbol under the cursor" },
      i = { vim.lsp.buf.implementation, "Lists all the implementations for the symbol" },
      rf = { vim.lsp.buf.references, "Lists all references to the symbol under the cursor" },
      R = { "<cmd>Trouble lsp_references<cr>", "Reveal LSP references under cursor in Trouble" },
    },
    K = { "<cmd>Lspsaga hover_doc<cr>", "Displays hover information about the symbol under the cursor" },
    ["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Go to previous diagnostic" },
    ["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Go to next diagnostic" },
  }

  wk.register(keymap)
end

return M

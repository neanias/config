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
      c = {
        name = "+code",
        r = {
          vim.lsp.buf.rename,
          "Renames all references to the symbol under the cursor",
          cond = capabilities.renameProvider,
        },
        a = {
          { vim.lsp.buf.code_action, "Selects a code action from the input list that is available" },
          { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action", mode = "v" },
        },
      },
      D = { vim.lsp.buf.type_definition, "Jumps to the definition of the type of the symbol" },
      e = { vim.diagnostic.open_float, "Opens a floating window with the diagnostics for current line" },
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
      d = { vim.lsp.buf.definition, "Jump to the definition of the symbol under the cursor" },
      i = { vim.lsp.buf.implementation, "Lists all the implementations for the symbol" },
      rf = { vim.lsp.buf.references, "Lists all references to the symbol under the cursor" },
    },
    K = { vim.lsp.buf.hover, "Displays hover information about the symbol under the cursor" },
    ["[d"] = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
    ["]d"] = { vim.diagnostic.goto_next, "Go to next diagnostic" },
  }

  wk.register(keymap)
end

return M

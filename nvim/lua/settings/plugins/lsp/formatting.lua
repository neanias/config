local M = {}

function M.format()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

  vim.lsp.buf.format({
    timeout_ms = 2000,
    bufnr = buf,
    filter = function(client)
      if have_nls then
        return client.name == "null-ls"
      else
        return client.name ~= "null-ls"
      end
    end,
  })
end

function M.setup(client, buf)
  -- format on save
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = buf,
      callback = M.format,
      group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
    })
  end
end

return M

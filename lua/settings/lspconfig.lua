local nvim_lsp = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  local wk = require("which-key")

  wk.register({
    K = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "Displays hover information about the symbol under the cursor" },
    ["[d"] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Go to previous diagnostic" },
    ["]d"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
  }, {
    noremap = true,
    silent = true,
  })

  wk.register({
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Jump to the declaration of the symbol under the cursor" },
    d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Jump to the definition of the symbol under the cursor" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Lists all the implementations for the symbol" },
    rf = { "<cmd>lua vim.lsp.buf.references()<CR>", "Lists all references to the symbol under the cursor" },
  }, {
    noremap = true,
    silent = true,
    prefix = "g",
  })

  wk.register({
    wa = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add the folder at path to the workspace folders." },
    wr = {
      "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
      "Remove the folder at path from the workspace folders.",
    },
    wl = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List workspace folders" },
    D = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Jumps to the definition of the type of the symbol" },
    rn = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Renames all references to the symbol under the cursor" },
    ca = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Selects a code action from the input list that is available" },
    e = {
      "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
      "Opens a floating window with the diagnostics for current line",
    },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Sets the location list" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Formats the current buffer" },
  }, {
    noremap = true,
    silent = true,
    prefix = "<leader>",
  })
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "solargraph" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  })
end

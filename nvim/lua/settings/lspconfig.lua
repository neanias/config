local nvim_lsp = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Attach navic if possible
  if client.server_capabilities.documentSymbolProvider then
    local navic = require("nvim-navic")
    navic.attach(client, bufnr)
  end

  -- Mappings
  local wk = require("which-key")

  wk.register({
    K = { vim.lsp.buf.hover, "Displays hover information about the symbol under the cursor" },
    ["[d"] = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
    ["]d"] = { vim.diagnostic.goto_next, "Go to next diagnostic" },
  }, {
    noremap = true,
    silent = true,
  })

  wk.register({
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    name = "+LSP",
    D = { vim.lsp.buf.declaration, "Jump to the declaration of the symbol under the cursor" },
    d = { vim.lsp.buf.definition, "Jump to the definition of the symbol under the cursor" },
    i = { vim.lsp.buf.implementation, "Lists all the implementations for the symbol" },
    rf = { vim.lsp.buf.references, "Lists all references to the symbol under the cursor" },
  }, {
    noremap = true,
    silent = true,
    prefix = "g",
  })

  wk.register({
    name = "+LSP",
    f = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
      "Format the current buffer",
    },
    wa = { vim.lsp.buf.add_workspace_folder, "Add the folder at path to the workspace folders." },
    wr = { vim.lsp.buf.remove_workspace_folder, "Remove the folder at path from the workspace folders." },
    wl = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List workspace folders" },
    D = { vim.lsp.buf.type_definition, "Jumps to the definition of the type of the symbol" },
    rn = { vim.lsp.buf.rename, "Renames all references to the symbol under the cursor" },
    ca = { vim.lsp.buf.code_action, "Selects a code action from the input list that is available" },
    e = { vim.diagnostic.open_float, "Opens a floating window with the diagnostics for current line" },
    q = {
      function()
        vim.diagnostic.setqflist({ open = false })
      end,
      "Puts all diagnostics in the quickfix list",
    },
  }, {
    noremap = true,
    silent = true,
    prefix = "<leader>l",
  })

  wk.register({
    name = "+LSP",
    f = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
      "Format the selected range",
    },
    ca = { vim.lsp.buf.code_action, "Selects a code action from the input list that is available" },
  }, {
    mode = "v",
    noremap = true,
    silent = true,
    prefix = "<leader>l",
  })
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "solargraph" }

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end


nvim_lsp.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
local null_ls = require("null-ls")

local sources = {
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.rubocop.with({
    command = "bin/rubocop",
  }),
  null_ls.builtins.code_actions.gitsigns,
}

null_ls.setup({
  sources = sources,
  on_attach = on_attach,
})

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require("lsp-inlayhints").on_attach(client, bufnr, false)
  end,
})

local M = {
  "neovim/nvim-lspconfig",
  version = false, -- Latest tag is behind
  name = "lsp",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    { "b0o/SchemaStore.nvim", version = false },
    "jose-elias-alvarez/typescript.nvim",
    "ray-x/lsp_signature.nvim",
    {
      "glepnir/lspsaga.nvim",
      cmd = "Lspsaga",
      opts = {
        lightbulb = { enable = false },
        symbol_in_winbar = { enable = false },
      },
    },
  },
}

function M.config()
  require("neodev").setup({
    library = { plugins = { "neotest" }, types = true },
  })
  require("mason")

  local function on_attach(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end
    require("settings.plugins.lsp.keys").setup(client, bufnr)

    local callback = function()
      local params = vim.lsp.util.make_text_document_params(bufnr)

      client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
        if err then
          return
        end

        vim.lsp.diagnostic.on_publish_diagnostics(
          nil,
          vim.tbl_extend("keep", params, { diagnostics = result.items }),
          { client_id = client.id }
        )
      end)
    end

    if client.name == "ruby_ls" then
      callback()
    end
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })

  local servers = {
    denols = {},
    jsonls = {
      -- lazy-load schemastore when needed
      on_new_config = function(new_config)
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
      end,
      settings = {
        json = {
          format = {
            enable = true,
          },
          validate = { enable = true },
        },
      },
    },
    pyright = {},
    ruby_ls = {},
    rust_analyzer = {
      settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true },
          checkOnSave = {
            command = "clippy",
            extraArgs = { "--no-deps" },
          },
        },
      },
    },
    lua_ls = {
      single_file_support = true,
      settings = {
        Lua = {
          completion = {
            workspaceWord = true,
            callSnippet = "Both",
          },
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
    },
    tsserver = {},
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local function setup(server)
    local server_opts = servers[server] or {}
    server_opts.capabilities = capabilities

    if server == "tsserver" then
      require("typescript").setup({ server = server_opts })
      return true
    end

    require("lspconfig")[server].setup(server_opts)
  end

  local mlsp = require("mason-lspconfig")
  local available = mlsp.get_available_servers()

  local ensure_installed = {} ---@type string[]
  for server, server_opts in pairs(servers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts
      -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
      if server_opts.mason == false or not vim.tbl_contains(available, server) then
        setup(server)
      else
        ensure_installed[#ensure_installed + 1] = server
      end
    end
  end

  require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
  require("mason-lspconfig").setup_handlers({ setup })
  require("lsp_signature").setup()
end

return M

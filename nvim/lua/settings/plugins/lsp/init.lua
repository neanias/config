local M = {
  "neovim/nvim-lspconfig",
  version = false, -- Latest tag is behind
  name = "lsp",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "saghen/blink.cmp",
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    { "b0o/SchemaStore.nvim", version = false },
    "ray-x/lsp_signature.nvim",
    {
      "nvimdev/lspsaga.nvim",
      cmd = "Lspsaga",
      opts = {
        lightbulb = { enable = false },
        symbol_in_winbar = { enable = false },
        diagnostic = {
          border_follow = false,
        },
      },
    },
    "SmiteshP/nvim-navic",
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
      },
    },
  },
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      serverity_sort = true,
    },
    inlay_hints = {
      enabled = false,
    },
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
    servers = {
      cssls = {},
      dockerls = {},
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
      omnisharp = {},
      pylsp = {
        autostart = false,
        cmd = { "poetry", "run", "pylsp" },
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                maxLineLength = 88,
              },
            },
          },
        },
      },
      pyright = {
        cmd = { "poetry", "run", "pyright-langserver", "--stdio" },
      },
      ruby_lsp = {
        mason = false,
        cmd = { table.concat({ os.getenv("HOME"), ".rbenv", "shims", "ruby-lsp" }, "/") },
        init_options = {
          enabledFeatures = {
            codeActions = true,
            completion = true,
            definition = true,
            diagnostics = true,
            documentHighlights = true,
            documentSymbols = true,
            foldingRanges = true,
            formatting = true,
            hover = true,
            inlayHint = true,
            onTypeFormatting = true,
            semanticHighlighting = true,
            signatureHelp = true,
            workspaceSymbol = true,
          },
          featuresConfiguration = {
            inlayHint = {
              implicitHashValue = false,
              implicitRescue = true,
            },
          },
          formatter = "standard",
          linters = { "standard" },
        },
      },
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
            hint = {
              enable = true,
              arrayIndex = "Auto",
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
              library = vim.tbl_extend(
                "force",
                vim.api.nvim_get_runtime_file("", true), -- This is slow, but gives us lots of info
                { "${3rd}/luassert/library", "${3rd}/luv/library" }
              ),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      },
      somesass_ls = {},
      terraformls = {},
      ts_ls = {},
      vimls = {},
    },
  },
}

function M.config(_, opts)
  require("mason")

  local function on_attach(client, bufnr)
    if client.supports_method("textDocument/documentSymbol") then
      require("nvim-navic").attach(client, bufnr)
      require("nvim-navbuddy").attach(client, bufnr)
    end
    require("settings.plugins.lsp.keys").setup(client, bufnr)
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)

      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end,
  })

  vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

  local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    opts.capabilities or {},
    {
      textDocument = {
        foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
      },
    }
  )
  capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

  local servers = opts.servers

  local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
      capabilities = vim.deepcopy(capabilities),
    }, servers[server] or {})

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

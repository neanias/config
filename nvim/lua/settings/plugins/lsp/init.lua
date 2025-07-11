local M = {
  "neovim/nvim-lspconfig",
  version = false, -- Latest tag is behind
  name = "lsp",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "saghen/blink.cmp",
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    { "b0o/SchemaStore.nvim", version = false },
    { "ray-x/lsp_signature.nvim", version = false },
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
      basedpyright = {
        cmd = { "uv", "run", "basedpyright-langserver", "--stdio" },
      },
      ruff = {
        mason = false,
        cmd = { "uv", "run", "ruff", "server" },
        cmd_env = { RUFF_TRACE = "messages" },
        init_options = {
          settings = {
            logLevel = "error",
          },
        },
        keys = {
          {
            "<leader>co",
            function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.organizeImports" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Organize Imports",
          },
        },
      },
      cssls = {},
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
      ruby_lsp = {
        mason = false,
        cmd = { table.concat({ os.getenv("HOME"), ".rbenv", "shims", "ruby-lsp" }, "/") },
        init_options = {
          enabledFeatures = {
            codeActions = true,
            codeLens = true,
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
      ts_ls = {},
      vimls = {},
    },
  },
}

function M.config(_, opts)
  require("mason")

  ---@param client vim.lsp.Client
  ---@param bufnr integer
  local function on_attach(client, bufnr)
    if client:supports_method("textDocument/documentSymbol") then
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

      if client:supports_method("textDocument/foldingRange") then
        local win = vim.api.nvim_get_current_win()
        vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
      end

      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end,
  })

  vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

  local servers = opts.servers

  local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
      capabilities = vim.deepcopy(capabilities),
    }, servers[server] or {})

    vim.lsp.config(server, server_opts)
  end

  local ensure_installed = {} ---@type string[]
  for server, server_opts in pairs(servers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts
      setup(server)
      ensure_installed[#ensure_installed + 1] = server
    end
  end

  require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
end

return M

local M = {
  "neovim/nvim-lspconfig",
  version = false, -- Latest tag is behind
  name = "lsp",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
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
      ruby_ls = {
        init_options = {
          enabledFeatures = {
            codeActions = true,
            diagnostics = true,
            documentHighlights = true,
            documentSymbols = true,
            formatting = true,
            hover = true,
            inlayHint = true,
            onTypeFormatting = true,
            semanticHighlighting = true,
          },
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
      tailwindcss = {},
      terraformls = {},
      tsserver = {},
    },
  },
}

function M.config(_, opts)
  require("neodev").setup({
    library = { plugins = { "neotest" }, types = true },
  })
  require("mason")

  local function on_attach(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
      require("nvim-navbuddy").attach(client, bufnr)
    end
    require("settings.plugins.lsp.keys").setup(client, bufnr)

    local callback = function()
      local params = vim.lsp.util.make_text_document_params(bufnr)

      client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
        if err then
          local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
          vim.lsp.log.error(err_msg)
          return
        end

        local diagnostic_items = {}
        if result then
          diagnostic_items = result.items
        end

        vim.lsp.diagnostic.on_publish_diagnostics(
          nil,
          vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
          { client_id = client.id }
        )
      end)
    end

    if client.name == "ruby_ls" then
      callback()

      local ruby_group = vim.api.nvim_create_augroup("ruby_ls", { clear = false })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "InsertLeave", "TextChanged" }, {
        buffer = bufnr,
        callback = callback,
        group = ruby_group,
      })
    end
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })

  vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.default_capabilities() or {},
    opts.capabilities or {},
    {
      textDocument = {
        foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
      },
    }
  )

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

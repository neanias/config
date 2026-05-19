vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  desc = "LSP plugins setup",
  once = true,
  callback = function()
    vim.pack.add({
      "https://github.com/neovim/nvim-lspconfig",
      "https://github.com/mason-org/mason.nvim",
      "https://github.com/mason-org/mason-lspconfig.nvim",
      "https://github.com/saghen/blink.cmp",
      "https://github.com/folke/neoconf.nvim",
      "https://github.com/b0o/SchemaStore.nvim",
      "https://github.com/ray-x/lsp_signature.nvim",
      "https://github.com/SmiteshP/nvim-navic",
      "https://github.com/folke/which-key.nvim",
    })

    local opts = {
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
              checkOnSave = true,
              check = {
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
                  vim.api.nvim_get_runtime_file("lua", true), -- This is slow, but gives us lots of info
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
        gleam = {
          mason = false,
        },
        terraformls = {},
      },
    }

    require("mason").setup()

    ---@param client vim.lsp.Client
    ---@param bufnr integer
    local function on_attach(client, bufnr)
      if client:supports_method("textDocument/documentSymbol") then
        require("nvim-navic").attach(client, bufnr)
      end

      local wk = require("which-key")
      wk.add({
        { "<leader>l", buffer = bufnr, group = "LSP" },
        {
          "<leader>la",
          vim.lsp.buf.code_action,
          buffer = bufnr,
          desc = "Selects a code action from the input list that is available",
          mode = { "n", "v" },
        },
        {
          "<leader>lc",
          vim.lsp.codelens.run,
          buffer = bufnr,
          desc = "Run CodeLens",
          mode = { "n", "v" },
        },
        {
          "<leader>lq",
          function()
            vim.diagnostic.setqflist({ open = true })
          end,
          buffer = bufnr,
          desc = "Puts all diagnostics in the quickfix list",
        },
        { "g", buffer = bufnr, group = "LSP" },
        {
          "gD",
          vim.lsp.buf.declaration,
          buffer = bufnr,
          desc = "Go to declaration",
        },
        {
          "gR",
          "<cmd>Trouble lsp_references<cr>",
          buffer = bufnr,
          desc = "Reveal LSP references under cursor in Trouble",
        },
      })
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buffer = args.buf
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        if client == nil then
          error("No client found for buffer")
        end

        on_attach(client, buffer)

        if client:supports_method("textDocument/foldingRange") then
          local win = vim.api.nvim_get_current_win()
          vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end

        if client:supports_method("textDocument/completion") then
          vim.lsp.completion.enable(true, client_id, buffer)
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
      vim.lsp.enable(server)
    end

    local ensure_installed = {} ---@type string[]
    for server, server_opts in pairs(servers) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        setup(server)
        if server_opts["mason"] == nil or server_opts["mason"] ~= nil and server_opts["mason"] == true then
          ensure_installed[#ensure_installed + 1] = server
        end
      end
    end

    require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
  end,
})

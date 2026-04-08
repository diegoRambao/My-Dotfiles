---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },
    -- Formatting delegado a conform.nvim (ver plugins/conform.lua)
    formatting = {
      format_on_save = { enabled = false },
      disabled = {},
      timeout_ms = 1000,
    },
    servers = {
      "angularls",
      "html",
      "cssls",
    },
    ---@diagnostic disable: missing-fields
    config = {
      -- ── Angular Language Server ──
      -- Usa @angular/language-server@15.2.1 instalado manualmente en Mason
      -- (compatible con Angular 15 + TS 4.8.x del proyecto Nequi).
      -- NO usar el pack astrocommunity.pack.angular (instala la ultima version).
      angularls = {
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern("angular.json", "nx.json")(fname)
        end,
        cmd = function()
          local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
          local ngserver = mason_packages .. "/angular-language-server/node_modules/@angular/language-server/bin/ngserver"
          return {
            ngserver,
            "--stdio",
            "--tsProbeLocations",
            "",
            "--ngProbeLocations",
            "",
          }
        end,
        on_new_config = function(new_config, new_root_dir)
          local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
          local ngserver = mason_packages .. "/angular-language-server/node_modules/@angular/language-server/bin/ngserver"
          -- Probe locations: project node_modules + Mason packages
          local probe_locations = table.concat({
            new_root_dir .. "/node_modules",
            mason_packages .. "/angular-language-server/node_modules",
          }, ",")
          new_config.cmd = {
            ngserver,
            "--stdio",
            "--tsProbeLocations",
            probe_locations,
            "--ngProbeLocations",
            probe_locations,
          }
        end,
      },
      vtsls = {
        -- Para Nx monorepos: usar la raiz del monorepo como root.
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern("nx.json", "workspace.json")(fname)
            or util.root_pattern("tsconfig.base.json")(fname)
            or util.root_pattern("tsconfig.json", "package.json")(fname)
            or util.root_pattern(".git")(fname)
        end,
        settings = {
          vtsls = {
            -- NO usar autoUseWorkspaceTsdk ni tsdk cuando el proyecto usa TS 4.x.
            -- vtsls 0.3.0 llama a languageService.ensureProjectAnalyzed() que no
            -- existe en TS 4.x, causando crash de TSServer con SIGTERM.
            -- Se deja que vtsls use su TS bundled (5.9.3). Con baseUrl: "./" en
            -- tsconfig.base.json, la resolucion de paths funciona igual en TS 5.x.
            autoUseWorkspaceTsdk = false,
          },
          typescript = {
            preferences = { quoteStyle = "single" },
            suggest = { completeFunctionCalls = true },
            updateImportsOnFileMove = { enabled = "always" },
          },
          javascript = {
            preferences = { quoteStyle = "single" },
            updateImportsOnFileMove = { enabled = "always" },
          },
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- angularls ahora habilitado con @angular/language-server@15.2.1
      -- (ver config.angularls arriba)
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
        -- Flutter mappings
        ["<Leader>fr"] = { "<Cmd>FlutterRun<CR>", desc = "Flutter Run" },
        ["<Leader>fq"] = { "<Cmd>FlutterQuit<CR>", desc = "Flutter Quit" },
        ["<Leader>fR"] = { "<Cmd>FlutterReload<CR>", desc = "Flutter Reload" },
        ["<Leader>fD"] = { "<Cmd>FlutterDevices<CR>", desc = "Flutter Devices" },
        ["<Leader>fo"] = { "<Cmd>FlutterOutlineToggle<CR>", desc = "Flutter Outline" },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}

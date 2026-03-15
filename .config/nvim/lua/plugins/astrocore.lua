-- AstroCore: core options, keymaps, and autocmds
-- Translated from VSCode settings.json

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
      highlighturl = true,
      notifications = true,
    },
    sessions = {
      autosave = {
        last = true, -- guarda "Last Session" al cerrar
        cwd = true, -- guarda sesion por directorio al cerrar
      },
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    options = {
      opt = {
        relativenumber = true, -- editor.lineNumbers: "relative"
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        scrolloff = 8, -- editor.cursorSurroundingLines: 8
        clipboard = "unnamedplus", -- vim.useSystemClipboard: true
        hlsearch = true, -- vim.hlsearch: true
        incsearch = true, -- vim.incsearch: true
        showmode = false, -- clean UI (minimap disabled equivalent)
        cursorline = true, -- better cursor visibility
        winbar = "%f %m", -- Mostrar nombre del archivo en cada split
      },
      g = {},
    },
    -- Keymaps translated from VSCode Vim extension config
    -- Leader is <Space> (set in lazy_setup.lua)
    mappings = {
      -- ╔══════════════════════════════════════════╗
      -- ║           NORMAL MODE                     ║
      -- ╚══════════════════════════════════════════╝
      n = {
        -- Search in current buffer (fuzzy find like Cmd+F in VSCode)
        ["<Leader>fs"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },

        -- Clear search highlights (<C-n> → :nohl)
        ["<C-n>"] = { "<cmd>nohl<cr>", desc = "Clear search highlights" },

        -- Hover documentation (gh → showDefinitionPreviewHover)
        ["gh"] = { function() vim.lsp.buf.hover() end, desc = "Hover documentation" },

        -- Buffer navigation (S-h/S-l → prev/next buffer)
        ["<S-h>"] = { "<cmd>bprevious<cr>", desc = "Previous buffer" },
        ["<S-l>"] = { "<cmd>bnext<cr>", desc = "Next buffer" },

        -- Vertical split (<Leader>v → :vsplit)
        ["<Leader>v"] = { "<cmd>vsplit<cr>", desc = "Vertical split" },

        -- Close buffer/window (<Leader>q)
        -- If there are multiple windows, close the current window.
        -- If there is only one window, close the buffer.
        ["<Leader>q"] = {
          function()
            if vim.fn.winnr("$") > 1 then
              vim.cmd("close")
            else
              require("astrocore.buffer").close()
            end
          end,
          desc = "Close window or buffer",
        },

        -- Save file (<Leader>w → save)
        -- NOTE: Overrides AstroNvim's Window group if it exists
        ["<Leader>w"] = { "<cmd>w<cr>", desc = "Save file" },

        -- Half-page scroll centered (<Leader>j/k → C-d/C-u)
        ["<Leader>j"] = { "<C-d>zz", desc = "Scroll half-page down" },
        ["<Leader>k"] = { "<C-u>zz", desc = "Scroll half-page up" },

        -- Split line at cursor (K → lineBreakInsert)
        -- NOTE: Overrides default K (LSP hover). Use 'gh' for hover instead.
        ["K"] = { "i<CR><Esc>", desc = "Split line at cursor", silent = true },

        -- ── LSP Navigation ──
        -- Peek definition (opens in Telescope for preview-like experience)
        ["gpd"] = { "<cmd>Telescope lsp_definitions<cr>", desc = "Peek definition" },

        -- Go to implementation
        ["gi"] = { function() vim.lsp.buf.implementation() end, desc = "Go to implementation" },

        -- Peek implementation
        ["gpi"] = { "<cmd>Telescope lsp_implementations<cr>", desc = "Peek implementation" },

        -- Quick fix / Code action
        -- NOTE: Overrides default gq (format operator). Use 'gw' for formatting text instead.
        ["gq"] = { function() vim.lsp.buf.code_action() end, desc = "Code action (quick fix)" },

        -- Find references
        ["gr"] = { "<cmd>Telescope lsp_references<cr>", desc = "Find references" },

        -- Go to type definition
        -- NOTE: Overrides default gt (next tab). Use :tabnext for tab navigation.
        ["gt"] = { function() vim.lsp.buf.type_definition() end, desc = "Go to type definition" },

        -- Peek type definition
        ["gpt"] = { "<cmd>Telescope lsp_type_definitions<cr>", desc = "Peek type definition" },

        -- ── Window navigation ──
        ["<Leader>h"] = { "<C-w>h", desc = "Focus left pane" },
        ["<Leader>l"] = { "<C-w>l", desc = "Focus right pane" },

        -- ── Save without formatting ──
        ["<Leader>W"] = {
          function()
            vim.cmd("noautocmd w")
          end,
          desc = "Save without formatting",
        },

        -- ── Copy path ──
        ["<Leader>yp"] = {
          function()
            local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
            vim.fn.setreg("+", path)
            vim.notify("Copied: " .. path)
          end,
          desc = "Copy relative path",
        },
        ["<Leader>yP"] = {
          function()
            local path = vim.api.nvim_buf_get_name(0)
            vim.fn.setreg("+", path)
            vim.notify("Copied: " .. path)
          end,
          desc = "Copy absolute path",
        },
        ["<Leader>yf"] = {
          function()
            local name = vim.fn.expand("%:t")
            vim.fn.setreg("+", name)
            vim.notify("Copied: " .. name)
          end,
          desc = "Copy filename",
        },
        ["<Leader>yd"] = {
          function()
            local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.:h")
            vim.fn.setreg("+", dir)
            vim.notify("Copied: " .. dir)
          end,
          desc = "Copy directory path",
        },
        ["<Leader>yl"] = {
          function()
            local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
            local line = vim.fn.line(".")
            local result = path .. ":" .. line
            vim.fn.setreg("+", result)
            vim.notify("Copied: " .. result)
          end,
          desc = "Copy path:line",
        },

        -- ── Text transforms ──
        -- Handled by text-case.nvim (see plugins/textcase.lua)
        -- <Leader>tu = UPPER, tl = lower, tc = camelCase, ts = snake_case,
        -- tp = PascalCase, tk = kebab-case, tt = Title Case, t/ = picker
      },

      -- ╔══════════════════════════════════════════╗
      -- ║           INSERT MODE                     ║
      -- ╚══════════════════════════════════════════╝
      i = {
        -- Quick escape (ii → Esc)
        ["ii"] = { "<Esc>", desc = "Exit insert mode" },
      },

      -- ╔══════════════════════════════════════════╗
      -- ║       OPERATOR-PENDING MODE               ║
      -- ╚══════════════════════════════════════════╝
      o = {
        -- L → end of line, H → first non-blank character
        ["L"] = { "$", desc = "End of line" },
        ["H"] = { "^", desc = "First non-blank" },
      },

      -- ╔══════════════════════════════════════════╗
      -- ║           VISUAL MODE                     ║
      -- ╚══════════════════════════════════════════╝
      v = {
        -- Also apply H/L in visual mode for consistency
        ["L"] = { "$", desc = "End of line" },
        ["H"] = { "^", desc = "First non-blank" },
      },
    },
  },
}

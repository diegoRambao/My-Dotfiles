-- Git: Neogit (source control panel) + diffview (diffs & merge conflicts)
-- Equivalente al panel Source Control de VSCode

---@type LazySpec
return {
  -- ── Diffview: visor de diffs y resolucion de conflictos merge ──
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      { "<Leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff view (working tree)" },
      { "<Leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current)" },
      { "<Leader>gF", "<cmd>DiffviewFileHistory<cr>", desc = "File history (all)" },
      { "<Leader>gm", "<cmd>DiffviewOpen HEAD<cr>", desc = "Merge conflict view" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { layout = "diff2_horizontal" },
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = true,
        },
      },
      file_panel = {
        listing_style = "tree",
        win_config = {
          position = "left",
          width = 35,
        },
      },
      keymaps = {
        view = {
          ["q"] = "<cmd>DiffviewClose<cr>",
        },
        file_panel = {
          ["q"] = "<cmd>DiffviewClose<cr>",
        },
        file_history_panel = {
          ["q"] = "<cmd>DiffviewClose<cr>",
        },
      },
    },
  },

  -- ── Neogit: cliente git completo (stage, commit, push, pull, branches) ──
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<Leader>gg", "<cmd>Neogit<cr>", desc = "Neogit status (git panel)" },
      { "<Leader>gc", "<cmd>Neogit commit<cr>", desc = "Git commit" },
      { "<Leader>gp", "<cmd>Neogit push<cr>", desc = "Git push" },
      { "<Leader>gP", "<cmd>Neogit pull<cr>", desc = "Git pull" },
      { "<Leader>gb", "<cmd>Neogit branch<cr>", desc = "Git branches" },
      { "<Leader>gl", "<cmd>Neogit log<cr>", desc = "Git log" },
      { "<Leader>gs", "<cmd>Neogit stash<cr>", desc = "Git stash" },
    },
    opts = {
      -- Integrar diffview para diffs dentro de Neogit
      integrations = {
        diffview = true,
        telescope = true,
      },
      -- Abrir Neogit en un tab (como el panel de VSCode)
      kind = "tab",
      -- Signos en el status panel
      signs = {
        hunk = { "", "" },
        item = { "▸", "▾" },
        section = { "▸", "▾" },
      },
      -- Commit popup: abrir editor de mensaje en split
      commit_editor = {
        kind = "split",
      },
      -- Auto-refresh al volver al buffer de Neogit
      auto_refresh = true,
    },
  },

  -- ── Gitsigns: extender con keymaps de hunk (stage/reset inline) ──
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      -- Habilitar blame line virtual text
      opts.current_line_blame = true
      opts.current_line_blame_opts = {
        delay = 500,
        virt_text_pos = "eol",
      }
    end,
    keys = {
      -- Navegacion entre hunks
      { "]g", function() require("gitsigns").next_hunk() end, desc = "Next git hunk" },
      { "[g", function() require("gitsigns").prev_hunk() end, desc = "Previous git hunk" },
      -- Stage/reset hunks (como el +/- en VSCode gutter)
      { "<Leader>ga", function() require("gitsigns").stage_hunk() end, desc = "Stage hunk" },
      { "<Leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset hunk" },
      { "<Leader>gA", function() require("gitsigns").stage_buffer() end, desc = "Stage buffer (all)" },
      { "<Leader>gR", function() require("gitsigns").reset_buffer() end, desc = "Reset buffer (all)" },
      { "<Leader>gu", function() require("gitsigns").undo_stage_hunk() end, desc = "Undo stage hunk" },
      { "<Leader>gv", function() require("gitsigns").preview_hunk() end, desc = "Preview hunk diff" },
      -- Visual mode: stage/reset selection
      {
        "<Leader>ga",
        function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
        mode = "v",
        desc = "Stage selected lines",
      },
      {
        "<Leader>gr",
        function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
        mode = "v",
        desc = "Reset selected lines",
      },
    },
  },
}

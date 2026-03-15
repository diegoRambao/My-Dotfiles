---@type LazySpec
return {
  -- ── Copilot: autocompletado inline (ghost text) ──
  -- copilot.vim (oficial de GitHub) - requiere Node 18+ (compatible con Node 20)
  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      -- Keymaps para sugerencias inline
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, desc = "Copilot accept" })
      vim.keymap.set("i", "<C-j>", "<Plug>(copilot-accept-line)", { desc = "Copilot accept line" })
      vim.keymap.set("i", "<C-k>", "<Plug>(copilot-accept-word)", { desc = "Copilot accept word" })
      vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)", { desc = "Copilot next suggestion" })
      vim.keymap.set("i", "<C-p>", "<Plug>(copilot-previous)", { desc = "Copilot prev suggestion" })
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)", { desc = "Copilot dismiss" })

      -- Filetypes habilitados/deshabilitados
      vim.g.copilot_filetypes = {
        ["*"] = true,
        ["markdown"] = true,
        ["yaml"] = true,
      }
    end,
  },

  -- ── CopilotChat: chat/asistente interactivo ──
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatToggle",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatTests",
      "CopilotChatCommit",
    },
    opts = {
      model = "claude-3.5-sonnet", -- o "gpt-4o" si prefieres
      window = {
        layout = "vertical",       -- panel lateral
        width = 0.35,              -- 35% del ancho
      },
    },
    keys = {
      -- Toggle del chat
      { "<Leader>aa", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
      -- Acciones rapidas sobre seleccion visual o buffer
      { "<Leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain code", mode = { "n", "v" } },
      { "<Leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review code", mode = { "n", "v" } },
      { "<Leader>af", "<cmd>CopilotChatFix<cr>", desc = "Fix code", mode = { "n", "v" } },
      { "<Leader>ao", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize code", mode = { "n", "v" } },
      { "<Leader>ad", "<cmd>CopilotChatDocs<cr>", desc = "Generate docs", mode = { "n", "v" } },
      { "<Leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate tests", mode = { "n", "v" } },
      { "<Leader>ac", "<cmd>CopilotChatCommit<cr>", desc = "Generate commit msg" },
      -- Pregunta libre sobre seleccion
      {
        "<Leader>aq",
        function()
          local input = vim.fn.input("Copilot > ")
          if input ~= "" then vim.cmd("CopilotChat " .. input) end
        end,
        desc = "Quick chat",
        mode = { "n", "v" },
      },
    },
  },
}

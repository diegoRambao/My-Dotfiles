-- Text case transforms (VSCode-like)
-- Keymaps under <Leader>t* for normal and visual mode
---@type LazySpec
return {
  "johmsalas/text-case.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  lazy = false,
  config = function()
    local textcase = require("textcase")
    textcase.setup({})

    -- Register Telescope extension for interactive picker
    require("telescope").load_extension("textcase")

    -- ── Normal mode: operates on current word ──
    -- ── Visual mode: operates on selection ──
    local maps = {
      { "tu", "to_upper_case",       "UPPER CASE" },
      { "tl", "to_lower_case",       "lower case" },
      { "tc", "to_camel_case",       "camelCase" },
      { "ts", "to_snake_case",       "snake_case" },
      { "tp", "to_pascal_case",      "PascalCase" },
      { "tk", "to_dash_case",        "kebab-case" },
      { "tt", "to_title_case",       "Title Case" },
      { "td", "to_dot_case",        "dot.case" },
      { "tC", "to_constant_case",    "CONSTANT_CASE" },
    }

    for _, m in ipairs(maps) do
      local key, method, label = m[1], m[2], m[3]

      -- Normal mode: current word
      vim.keymap.set("n", "<Leader>" .. key, function()
        textcase.current_word(method)
      end, { desc = label })

      -- Visual mode: selection
      vim.keymap.set("v", "<Leader>" .. key, function()
        textcase.operator(method)
      end, { desc = label })
    end

    -- Interactive picker: <Leader>t/ opens Telescope with all transforms
    vim.keymap.set("n", "<Leader>t/", "<cmd>TextCaseOpenTelescope<cr>", { desc = "Text case picker" })
    vim.keymap.set("v", "<Leader>t/", "<cmd>TextCaseOpenTelescope<cr>", { desc = "Text case picker" })
  end,
}

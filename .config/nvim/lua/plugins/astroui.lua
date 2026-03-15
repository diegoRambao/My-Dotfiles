-- AstroUI: colorscheme and UI configuration
-- Auto-detects system theme (macOS) and switches:
--   Dark  → Tokyo Night (Night)
--   Light → Tokyo Night (Day)

---@type LazySpec
return {
  -- Tokyo Night theme (dark + light variants)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
      on_colors = function(colors)
        colors.bg = "#011628"
        colors.bg_dark = "#011423"
        colors.bg_float = "#011423"
        colors.bg_highlight = "#143652"
        colors.bg_popup = "#011423"
        colors.bg_search = "#0A64AC"
        colors.bg_sidebar = "#011423"
        colors.bg_statusline = "#011423"
        colors.bg_visual = "#275378"
        colors.border = "#547998"
        colors.fg = "#CBE0F0"
        colors.fg_dark = "#B4D0E9"
        colors.fg_float = "#CBE0F0"
        colors.fg_gutter = "#627E97"
        colors.fg_sidebar = "#B4D0E9"
      end,
    },
  },

  -- Auto-detect system dark/light mode (macOS)
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    priority = 999, -- load after themes but early
    opts = {
      update_interval = 1000, -- check every second
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd("colorscheme tokyonight-night")
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd("colorscheme tokyonight-day")
      end,
    },
  },

  -- Configure AstroUI
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      -- Initial colorscheme (auto-dark-mode overrides this at startup)
      colorscheme = "tokyonight-night",
      highlights = {
        init = {
          -- Custom highlight for yanked text (vim.highlightedyank.color: #a9dc7660)
          HighlightedYank = { bg = "#a9dc76", blend = 40 },
          GitSignsAdd = { fg = "#9ece6a", bold = true },
          GitSignsChange = { fg = "#e0af68", bold = true },
          GitSignsDelete = { fg = "#f7768e", bold = true },
          GitSignsUntracked = { fg = "#7aa2f7", bold = true },
        },
      },
      icons = {
        LSPLoading1 = "⠋",
        LSPLoading2 = "⠙",
        LSPLoading3 = "⠹",
        LSPLoading4 = "⠸",
        LSPLoading5 = "⠼",
        LSPLoading6 = "⠴",
        LSPLoading7 = "⠦",
        LSPLoading8 = "⠧",
        LSPLoading9 = "⠇",
        LSPLoading10 = "⠏",
      },
    },
  },
}

-- Custom statusline using heirline + Tokyo Night palette
-- Rounded separators, vibrant mode colors, git + diagnostics + LSP info

---@type LazySpec
return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astroui.status")
    local C = require("tokyonight.colors").setup()

    -- Mode colors from Tokyo Night palette
    local mode_colors = {
      n = C.blue,
      i = C.green,
      v = C.magenta,
      V = C.magenta,
      ["\22"] = C.magenta,
      c = C.orange,
      s = C.purple,
      S = C.purple,
      ["\19"] = C.purple,
      R = C.red,
      r = C.red,
      ["!"] = C.red,
      t = C.green1,
    }

    opts.statusline = {
      hl = { fg = C.fg, bg = C.bg_dark },

      -- ▌ MODE
      status.component.mode({
        mode_text = { padding = { left = 1, right = 1 } },
        surround = {
          separator = { "", "" },
          color = function()
            return { main = mode_colors[vim.fn.mode(1):sub(1, 1)] or C.blue }
          end,
        },
        hl = { fg = C.bg_dark, bold = true },
      }),

      -- ▌ FILE INFO
      status.component.file_info({
        filename = { modify = ":." },
        filetype = false,
        surround = {
          separator = { " ", "" },
          color = { main = C.bg_highlight },
        },
        hl = { fg = C.fg },
      }),

      -- ▌ GIT BRANCH
      status.component.git_branch({
        surround = {
          separator = { " ", "" },
          color = { main = C.bg_highlight },
        },
        hl = { fg = C.blue, bold = true },
      }),

      -- ▌ GIT DIFF
      status.component.git_diff({
        surround = { separator = { " ", "" } },
      }),

      -- ▌ FILL
      status.component.fill(),

      -- ▌ DIAGNOSTICS
      status.component.diagnostics({
        surround = { separator = { "", " " } },
      }),

      -- ▌ LSP
      status.component.lsp({
        lsp_client_names = { icon = { padding = { right = 1 } } },
        surround = {
          separator = { " ", "" },
          color = { main = C.bg_highlight },
        },
        hl = { fg = C.cyan, bold = true },
      }),

      -- ▌ LOCATION (line:col)
      status.component.nav({
        percentage = false,
        ruler = { padding = { left = 1, right = 1 } },
        surround = {
          separator = { "", "" },
          color = function()
            return { main = mode_colors[vim.fn.mode(1):sub(1, 1)] or C.blue }
          end,
        },
        hl = { fg = C.bg_dark, bold = true },
      }),
    }
  end,
}

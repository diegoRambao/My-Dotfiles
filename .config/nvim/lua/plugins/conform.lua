---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  dependencies = { "mason.nvim", "williamboman/mason-lspconfig.nvim" },
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      jsonc = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      astro = { "prettierd", "prettier", stop_after_first = true },
      dart = { "dart_format" },
      java = { "google-java-format" },
      lua = { "stylua" },
    },
    format_on_save = function(bufnr)
      -- No formatear si el buffer tiene variable deshabilitada
      if vim.b[bufnr].disable_autoformat then return end
      return { timeout_ms = 2000, lsp_format = "fallback" }
    end,
  },
}

---@type LazySpec
return {
  "akinsho/flutter-tools.nvim",
  ft = "dart",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    flutter_path = "/Users/andres.rambao/develop/flutter/bin/flutter",
    dev_log = {
      enabled = true,
      open_cmd = "tabedit",
    },
    lsp = {
      color = { enabled = true },
      settings = {
        showTodos = true,
        completeFunctionCalls = true,
        renameFilesWithClasses = "prompt",
        enableSnippets = true,
      },
    },
    widget_guides = { enabled = true },
  },
}

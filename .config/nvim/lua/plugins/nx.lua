-- Nx monorepo support
-- Provides :Nx commands for running generators, targets, and navigating Nx workspaces

---@type LazySpec
return {
  {
    "Equilibris/nx.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      nx_cmd_root = "npx nx",
    },
    keys = {
      { "<Leader>nx", "<cmd>Telescope nx actions<cr>", desc = "Nx actions" },
      { "<Leader>ng", "<cmd>Telescope nx generators<cr>", desc = "Nx generators" },
    },
  },
}

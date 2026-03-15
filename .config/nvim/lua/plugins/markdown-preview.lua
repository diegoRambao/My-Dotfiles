---@type LazySpec
return {
  {
    -- Disable the browser-based markdown preview
    "iamcco/markdown-preview.nvim",
    enabled = false,
  },
  {
    -- In-editor markdown rendering (headings, lists, tables, code blocks, etc.)
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- Render on file open
      enabled = true,
      -- Render in these modes (normal and command)
      render_modes = { "n", "c" },
      -- Heading styles
      heading = {
        enabled = true,
        icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
      },
      -- Code block rendering
      code = {
        enabled = true,
        style = "full",
        border = "thin",
      },
      -- Bullet list rendering
      bullet = {
        enabled = true,
      },
      -- Checkbox rendering
      checkbox = {
        enabled = true,
      },
    },
    keys = {
      {
        "<leader>cp",
        "<cmd>RenderMarkdown toggle<cr>",
        desc = "Toggle Markdown Preview",
        ft = "markdown",
      },
    },
  },
}

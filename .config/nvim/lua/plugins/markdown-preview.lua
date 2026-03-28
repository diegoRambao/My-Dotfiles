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
      -- More similar to VSCode: render only while viewing, not while typing commands
      render_modes = { "n" },
      -- Heading styles
      heading = {
        enabled = true,
        icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
        sign = false,
        width = "block",
        position = "inline",
        border = false,
        left_pad = 0,
        right_pad = 0,
      },
      -- Code block rendering
      code = {
        enabled = true,
        sign = false,
        width = "block",
        border = "hide",
        language_name = true,
        language_icon = false,
      },
      paragraph = {
        enabled = true,
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

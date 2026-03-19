-- AstroCommunity: import community modules
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- ── Language packs ──
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.typescript" }, -- vtsls + treesitter JS/TS/JSX/TSX
  { import = "astrocommunity.pack.eslint" }, -- eslint-lsp via Mason
  { import = "astrocommunity.pack.json" }, -- JSON/JSONC
  -- { import = "astrocommunity.pack.angular" }, -- Desactivado: Angular LS requiere TS >= 5.0, el proyecto usa TS 4.8.4 y ngserver crashea
  { import = "astrocommunity.pack.astro" }, -- Astro LS + treesitter
  { import = "astrocommunity.pack.dart" }, -- Flutter/Dart (flutter-tools.nvim + dart LSP)
  { import = "astrocommunity.pack.java" }, -- Java (jdtls)

  -- ── Editing support ──
  { import = "astrocommunity.editing-support.nvim-ts-autotag" }, -- auto-rename HTML/JSX/Angular tags
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" }, -- bracket pair colorization
  { import = "astrocommunity.editing-support.todo-comments-nvim" }, -- resalta TODO/FIXME/HACK/BUG + busqueda Telescope

  -- ── Indent ──
  { import = "astrocommunity.indent.indent-blankline-nvim" }, -- lineas de indentacion visual

  -- ── Search ──
  { import = "astrocommunity.search.nvim-spectre" }, -- buscar y reemplazar en todo el proyecto

  -- ── Motion ──
  { import = "astrocommunity.motion.flash-nvim" }, -- easymotion equivalent
  { import = "astrocommunity.motion.mini-surround" }, -- surround: add/delete/replace surroundings
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },
}

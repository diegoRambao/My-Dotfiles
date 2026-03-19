-- blink.cmp: optimize completion responsiveness
-- Reduces debounce and prefetches on trigger characters (like '.')

---@type LazySpec
return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      -- Show the completion menu immediately after trigger characters
      trigger = {
        prefetch_on_insert = true,
        show_on_trigger_character = true,
      },
      -- Show menu faster
      menu = {
        auto_show = true,
      },
      -- Preselect first item for faster confirmation
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
    },
    -- Reduce LSP response timeout and debounce
    sources = {
      providers = {
        lsp = {
          timeout_ms = 2000,
        },
      },
    },
  },
}

-- Neo-tree: wider panel, cursor highlight, close on file open

---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- Mostrar archivos ocultos (con estilo atenuado)
        hide_dotfiles = false, -- No ocultar archivos/carpetas que empiezan con .
        hide_gitignored = false, -- Mostrar archivos en .gitignore (atenuados)
      },
    },
    window = {
      position = "right",
      width = math.floor(vim.o.columns * 0.4), -- 40% del ancho de la ventana
      mappings = {
        ["l"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" then
            if node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            else
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            end
          else
            require("neo-tree.sources.common.commands").open(state)
          end
        end,
        ["h"] = "close_node", -- Cerrar carpeta y subir al padre con h
      },
    },
    default_component_configs = {
      indent = {
        highlight = "NeoTreeIndentMarker",
      },
      git_status = {
        symbols = {
          added = "+",
          modified = "~",
          deleted = "-",
          renamed = "→",
          untracked = "?",
          ignored = "◌",
          unstaged = "✗",
          staged = "✓",
          conflict = "!",
        },
      },
    },
    git_status_async = true,
    enable_cursor_hijack = true, -- mantiene el cursor visible dentro del tree
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
  init = function()
    -- Resaltar la linea donde esta el cursor dentro de Neo-tree
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "neo-tree",
      callback = function()
        vim.wo.cursorline = true
      end,
    })
  end,
}

-- This will run last in the setup process.
-- Custom polish translated from VSCode settings.

-- ── Silenciar comandos VSCode-specific de vtsls ──
-- vtsls envia "setContext" y "_typescript.*" via workspace/executeCommand.
-- En Neovim 0.11+, los comandos LSP se buscan en vim.lsp.commands.
-- Sin estos no-ops, aparece "Command setContext not found" en cada sesion.
vim.lsp.commands["setContext"] = function() end
vim.lsp.commands["_typescript.goToSourceDefinition"] = function() end
vim.lsp.commands["_typescript.findAllFileReferences"] = function() end

-- ── Highlighted Yank ──
-- vim.highlightedyank.enable: true
-- vim.highlightedyank.duration: 250
-- vim.highlightedyank.color: "#a9dc7660" (defined in astroui highlights)
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  desc = "Highlight on yank (from VSCode vim.highlightedyank)",
  callback = function()
    vim.hl.on_yank({ higroup = "HighlightedYank", timeout = 250 })
  end,
})

-- ── ESLint Fix All on Save ──
-- editor.codeActionsOnSave: { "source.fixAll.eslint": "always" }
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("eslint_fix_all", { clear = true }),
  desc = "Run EslintFixAll on save (from VSCode source.fixAll.eslint)",
  callback = function(args)
    -- Only run if eslint-lsp is attached to the buffer
    local clients = vim.lsp.get_clients({ bufnr = args.buf, name = "eslint" })
    if #clients > 0 then
      vim.cmd("EslintFixAll")
    end
  end,
})

-- ── Comando personalizado: NewFile ──
-- Crea un nuevo archivo en el directorio actual
vim.api.nvim_create_user_command("NewFile", function(opts)
  local filename = opts.args
  if filename == "" then
    -- Si no proporciona nombre, abre input dialog
    filename = vim.fn.input("Nombre del archivo: ", "", "file")
  end

  if filename ~= "" then
    local full_path = vim.fn.getcwd() .. "/" .. filename
    -- Crear directorios intermedios si no existen
    vim.fn.mkdir(vim.fn.fnamemodify(full_path, ":h"), "p")
    -- Abrir el archivo (se crea al guardar)
    vim.cmd("edit " .. full_path)
    vim.notify("Nuevo archivo: " .. filename, vim.log.levels.INFO)
  end
end, { nargs = "?", desc = "Crear un nuevo archivo en el proyecto" })

-- ── Markdown smart wrap ──
-- Wrap para párrafos, pero sin romper visualmente tablas o bloques de código.
local markdown_wrap_group = vim.api.nvim_create_augroup("markdown_wrap", { clear = true })

local function is_markdown_table_line(line)
  if line == "" then return false end
  return line:match("^%s*|.*|%s*$") ~= nil
end

local function is_inside_markdown_fence(bufnr, row)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, row, false)
  local inside_fence = false

  for _, line in ipairs(lines) do
    if line:match("^%s*```") or line:match("^%s*~~~") then inside_fence = not inside_fence end
  end

  return inside_fence
end

local function update_markdown_wrap(bufnr)
  bufnr = bufnr or 0
  if vim.bo[bufnr].filetype ~= "markdown" then return end

  local win = vim.api.nvim_get_current_win()
  if vim.api.nvim_win_get_buf(win) ~= bufnr then return end

  local row = vim.api.nvim_win_get_cursor(win)[1]
  local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1] or ""
  local disable_wrap = is_markdown_table_line(line) or is_inside_markdown_fence(bufnr, row)

  vim.wo[win].wrap = not disable_wrap
  vim.wo[win].linebreak = not disable_wrap
  vim.wo[win].breakindent = not disable_wrap
  vim.wo[win].showbreak = disable_wrap and "" or "↪ "
end

vim.api.nvim_create_autocmd("FileType", {
  group = markdown_wrap_group,
  pattern = "markdown",
  desc = "Enable smart wrap for Markdown",
  callback = function(args)
    update_markdown_wrap(args.buf)
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved", "CursorMovedI", "TextChanged", "TextChangedI", "InsertLeave" }, {
  group = markdown_wrap_group,
  desc = "Update wrap mode for Markdown tables and code fences",
  callback = function(args)
    update_markdown_wrap(args.buf)
  end,
})

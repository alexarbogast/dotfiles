local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    cpp = { "clang_format" },
    markdown = { "prettier" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options

--type conform.options
local options = {
  lsp_fallback = true,
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    cpp = { "clang_format" },
    markdown = { "prettier" },
  },
}

require("conform").setup(options)

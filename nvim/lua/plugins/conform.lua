return {
  "stevearc/conform.nvim",
  -- event = 'BufWritePre', -- uncomment for format on save
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      cpp = { "clang-format" },
      markdown = { "prettier" },
      tex = { "tex-fmt" },
    },
  },
}

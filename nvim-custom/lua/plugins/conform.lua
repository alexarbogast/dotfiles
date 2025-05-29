return {
  "stevearc/conform.nvim",
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

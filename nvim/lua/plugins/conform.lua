return {
  "stevearc/conform.nvim",
  -- event = 'BufWritePre', -- uncomment for format on save
  opts = {
    formatters_by_ft = {
      cpp = { "clang-format" },
      lua = { "stylua" },
      markdown = { "prettier" },
      nix = { "nixfmt" },
      python = { "black" },
      tex = { "tex-fmt" },
    },
  },
}

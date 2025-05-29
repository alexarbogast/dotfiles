return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      -- lua
      "lua-language-server",
      "stylua",

      -- python
      "pyright",
      "mypy",
      "black",

      -- rust
      "rust-analyzer",

      -- c/cpp
      "clangd",
      "clang-format",

      -- other
      "texlab",
      "prettier",
    },
  },
}

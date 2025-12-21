return {
  "neovim/nvim-lspconfig",
  config = function()
    require("nvchad.configs.lspconfig").defaults()
    -- require("configs.lspconfig")

    local servers = {
      "pyright",
      "clangd",
      "rust_analyzer",
      "texlab",
    }
    -- local nvlsp = require("nvchad.configs.lspconfig")
    vim.lsp.enable(servers)

  end,
}

return {
  "neovim/nvim-lspconfig",
  config = function()
    require("nvchad.configs.lspconfig").defaults()
    -- require("configs.lspconfig")
    --

    -- Configure clangd BEFORE enabling
    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--header-insertion=never",
      },
    })

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

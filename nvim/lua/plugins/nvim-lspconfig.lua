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
    local nvlsp = require("nvchad.configs.lspconfig")

    -- lsps with default config
    for _, lsp in ipairs(servers) do
      require("lspconfig")[lsp].setup({
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
      })
    end
  end,
}

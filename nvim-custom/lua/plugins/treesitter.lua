return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "cpp",
        "yaml",
        "toml",
        "bash",
        "xml",
        "vimdoc",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = false },
    })
  end,
}

local plugins = {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
  	"williamboman/mason.nvim",
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
  },
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
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
  		},
  	},
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}

return plugins

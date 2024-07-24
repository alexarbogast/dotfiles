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
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_latexmk = {
        out_dir = "build",
        aux_dir = "build/aux",
      }
    end
  }
}

return plugins

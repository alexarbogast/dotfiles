local plugins = {
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
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
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
        --"latex",
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
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
    "stevearc/conform.nvim",
    config = function()
      require "custom.configs.conform"
    end,
  },
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      -- put vim.gvimtex_* settings here
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "generic"
      vim.g.vimtex_compiler_generic = {
        command = "docker run --rm -v .:/workdir texlive/texlive latexmk " ..
                  "-output-directory=build " ..
                  "-aux-directory=build/aux " ..
                  "-pdf -pvc ",
        out_dir = "build",
      }
    end,
  },
}
return plugins

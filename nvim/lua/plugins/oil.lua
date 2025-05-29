return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
    },
  },
  event = "VeryLazy",
  cmd = "Oil",
  keys = {
    {"-", "<cmd>Oil --float<CR>", desc = "Open parent directory in Oil" }
  }
  -- Optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  -- lazy = false,
}

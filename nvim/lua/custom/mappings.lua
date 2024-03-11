local M = {}

M.general = {
  n = {
    -- switch between windows
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft <cr>"},
    ["<C-j>"] = { "<cmd> TmuxNavigateDown <cr>"},
    ["<C-k>"] = { "<cmd> TmuxNavigateUp <cr>"},
    ["<C-l>"] = { "<cmd> TmuxNavigateRight <cr>"},

    -- format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
  },

  i = {
    -- Ctrl + Backspace removes a whole word (just like other apps)
    ["<C-BS>"] = { "<Esc>cvb" },
  },
}

return M

local M = {}

M.general = {
  n = {
    -- switch between windows 
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<cr>"},
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<cr>"},
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<cr>"},
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<cr>"},
 },
}

return M

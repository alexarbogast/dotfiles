require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.tex", "*.md"},
  callback = function()
    vim.cmd "set spell"
    vim.cmd "set textwidth=80"
  end,
})

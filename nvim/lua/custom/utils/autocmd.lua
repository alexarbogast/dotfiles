local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
  desc = "Remove trailing whitespace on save",
  pattern = { "*" },
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    pcall(function() vim.cmd [[%s/\s\+$//e]] end)
    vim.fn.setpos(".", save_cursor)
  end,
})

-- oil
vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open parent directory in Oil" })

-- diagnostics
vim.keymap.set("n", "<leader>df", function()
  vim.diagnostic.open_float()
end, { desc = "LSP open diagnostics in float" })

-- format
vim.keymap.set("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "Format current file" })

-- comment
vim.keymap.set("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
vim.keymap.set("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- other
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "move left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "move right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "move up" })

vim.keymap.set("i", "<C-BS>", "<ESC>cvb")

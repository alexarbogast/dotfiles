require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("i", "<C-BS>", "<ESC>cvb")

-- telescope
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Telescope lsp document symbols" })

-- lsp
map("n", "<leader>df", function()
  vim.diagnostic.open_float()
end, { desc = "LSP open diagnostics in float" })

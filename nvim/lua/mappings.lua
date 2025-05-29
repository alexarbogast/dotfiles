require("nvchad.mappings")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("i", "<C-BS>", "<ESC>cvb")

-- telescope
map("n", "<leader>fs", require("telescope.builtin").lsp_document_symbols, { desc = "Telescope lsp document symbols" })
map("n", "<leader>fr", require("telescope.builtin").lsp_references, { desc = "Telescope lsp references" })

-- tmux navigation (fixing conflicting nvchad + vim-tmux-navtigator mappings)
map("n", "<c-h>", "<cmd>:TmuxNavigateLeft<cr>")
map("n", "<c-j>", "<cmd>:TmuxNavigateDown<cr>")
map("n", "<c-k>", "<cmd>:TmuxNavigateUp<cr>")
map("n", "<c-l>", "<cmd>:TmuxNavigateRight<cr>")
map("n", "<c-\\>", "<cmd>:TmuxNavigatePrevious<cr>")

-- lsp
map("n", "<leader>df", function()
  vim.diagnostic.open_float()
end, { desc = "LSP open diagnostics in float" })

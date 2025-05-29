return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load vimtex
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_latexmk = {
      out_dir = "build",
      aux_dir = "build/aux",
    }
    vim.g.vimtex_quickfix_ignore_filters = {
      [[Underfull]],
      [[Overfull]],
    }
  end,
}

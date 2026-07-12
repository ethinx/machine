local api = vim.api

-- go to last loc when opening a buffer
api.nvim_create_autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- close quickfix
vim.cmd("autocmd FileType qf nnoremap <buffer> <CR>  <CR>:cclose<CR>")
vim.cmd("autocmd FileType qf nnoremap <buffer> <ESC> :cclose<CR>")

vim.cmd([[
  au BufNewFile,BufRead *.bean,*.beancount set filetype=beancount
]])

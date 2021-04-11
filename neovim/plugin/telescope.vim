lua require("johann2357")

nnoremap <leader>t :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>g :lua require('telescope.builtin').git_status()<CR>
nnoremap <Leader>f :lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>l :lua require('telescope.builtin').lsp_document_diagnostics()<CR>


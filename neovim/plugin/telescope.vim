lua require("johann2357")

nnoremap <leader>t :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>g :lua require('telescope.builtin').git_status()<CR>
nnoremap <Leader>f :lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>l :lua require('telescope.builtin').lsp_document_diagnostics()<CR>

" git-worktree
" <Enter> - switches to that worktree
" <c-d> - deletes that worktree
" <c-f> - toggles forcing of the next deletion
nnoremap <Leader>w :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
nnoremap <Leader>c :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>


lua require("johann2357")

nnoremap <leader>t <cmd>lua require("telescope.builtin").git_files()<CR>
nnoremap <Leader>g <cmd>lua require("telescope.builtin").git_status()<CR>
nnoremap <Leader>f <cmd>lua require("telescope.builtin").find_files()<CR>
nnoremap <Leader>l <cmd>lua require("telescope.builtin").diagnostics()<CR>
nnoremap <Leader>h <cmd>lua require("telescope.builtin").help_tags()<CR>
nnoremap <Leader>r <cmd>lua require("telescope.builtin").live_grep()<CR>

" git-worktree
" <Enter> - switches to that worktree
" <c-d> - deletes that worktree
" <c-f> - toggles forcing of the next deletion
nnoremap <Leader>w :lua require("telescope").extensions.git_worktree.git_worktrees()<CR>
nnoremap <Leader>c :lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>


lua require("johann2357")

nnoremap <leader>t <cmd>lua require("telescope.builtin").git_files()<CR>
nnoremap <Leader>g <cmd>lua require("telescope.builtin").git_status()<CR>
nnoremap <Leader>f <cmd>lua require("telescope.builtin").find_files()<CR>
nnoremap <Leader>l <cmd>lua require("telescope.builtin").diagnostics()<CR>
nnoremap <Leader>L <cmd>lua require("telescope.builtin").lsp_references()<CR>
nnoremap <Leader>d <cmd>lua require("telescope.builtin").lsp_definitions()<CR>
nnoremap <Leader>h <cmd>lua require("telescope.builtin").help_tags()<CR>
nnoremap <Leader>r <cmd>lua require("telescope.builtin").live_grep()<CR>
nnoremap <Leader>R <cmd>lua require("telescope.builtin").grep_string()<CR>
nnoremap <Leader>b <cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>
nnoremap <Leader>m <cmd>lua require("telescope.builtin").man_pages()<CR>
nnoremap <Leader>' <cmd>lua require("telescope.builtin").keymaps()<CR>

" git-worktree
" <Enter> - switches to that worktree
" <c-d> - deletes that worktree
" <c-f> - toggles forcing of the next deletion
nnoremap <Leader>w :lua require("telescope").extensions.git_worktree.git_worktrees()<CR>
nnoremap <Leader>c :lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>


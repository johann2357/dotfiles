" Switch to buffer
nnoremap <Leader>.a :lua require("nvim-smartbufs").goto_buffer(1)<CR>
nnoremap <Leader>.o :lua require("nvim-smartbufs").goto_buffer(2)<CR>
nnoremap <Leader>.e :lua require("nvim-smartbufs").goto_buffer(3)<CR>
nnoremap <Leader>.u :lua require("nvim-smartbufs").goto_buffer(4)<CR>
nnoremap <Leader>.h :lua require("nvim-smartbufs").goto_buffer(5)<CR>
nnoremap <Leader>.t :lua require("nvim-smartbufs").goto_buffer(6)<CR>
nnoremap <Leader>.n :lua require("nvim-smartbufs").goto_buffer(7)<CR>
nnoremap <Leader>.s :lua require("nvim-smartbufs").goto_buffer(8)<CR>
nnoremap <Leader>k :lua require("nvim-smartbufs").goto_next_buffer()<CR>
nnoremap <Leader>j :lua require("nvim-smartbufs").goto_prev_buffer()<CR>

" Switch to terminal
nnoremap <Leader>ca :lua require("nvim-smartbufs").goto_terminal(1)<CR>
nnoremap <Leader>co :lua require("nvim-smartbufs").goto_terminal(2)<CR>
nnoremap <Leader>ce :lua require("nvim-smartbufs").goto_terminal(3)<CR>
nnoremap <Leader>cu :lua require("nvim-smartbufs").goto_terminal(4)<CR>

" Close buffers
nnoremap <Leader>qq :lua require("nvim-smartbufs").close_current_buffer()<CR>
nnoremap <Leader>qa :lua require("nvim-smartbufs").close_buffer(1)<CR>
nnoremap <Leader>qo :lua require("nvim-smartbufs").close_buffer(2)<CR>
nnoremap <Leader>qe :lua require("nvim-smartbufs").close_buffer(3)<CR>
nnoremap <Leader>qu :lua require("nvim-smartbufs").close_buffer(4)<CR>
nnoremap <Leader>qh :lua require("nvim-smartbufs").close_buffer(5)<CR>
nnoremap <Leader>qt :lua require("nvim-smartbufs").close_buffer(6)<CR>
nnoremap <Leader>qn :lua require("nvim-smartbufs").close_buffer(7)<CR>
nnoremap <Leader>qs :lua require("nvim-smartbufs").close_buffer(8)<CR>

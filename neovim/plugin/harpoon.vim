" File navigation
nnoremap <Leader>.. :lua require("harpoon.mark").add_file()<CR>
nnoremap <Leader>.c :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <Leader>k :lua require("harpoon.ui").nav_next()<CR>
nnoremap <Leader>j :lua require("harpoon.ui").nav_prev()<CR>

nnoremap <Leader>.a :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <Leader>.o :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <Leader>.e :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <Leader>.u :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <Leader>.h :lua require("harpoon.ui").nav_file(5)<CR>
nnoremap <Leader>.t :lua require("harpoon.ui").nav_file(6)<CR>
nnoremap <Leader>.n :lua require("harpoon.ui").nav_file(7)<CR>
nnoremap <Leader>.s :lua require("harpoon.ui").nav_file(8)<CR>

" Terminal navigation
nnoremap <Leader>ca :lua require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <Leader>co :lua require("harpoon.term").gotoTerminal(2)<CR>
nnoremap <Leader>ce :lua require("harpoon.term").gotoTerminal(3)<CR>
nnoremap <Leader>cu :lua require("harpoon.term").gotoTerminal(4)<CR>

nnoremap <Leader>c. :lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>


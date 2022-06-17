-- Set Leader Key
vim.g.mapleader = " "

-- Quick nohlsearch
vim.keymap.set("n", "<Leader><Esc>", "<cmd>noh<CR>")

-- Yank and paste from clipboard
vim.keymap.set("v", "<Leader>y", '"+y')
vim.keymap.set("v", "<Leader>p", '"+p')
vim.keymap.set("n", "<Leader>p", '"+p')

-- Keep it centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "{", "{zzzv")
vim.keymap.set("n", "}", "}zzzv")
vim.keymap.set("n", "<c-u>", "<c-u>zzzv")
vim.keymap.set("n", "<c-d>", "<c-d>zzzv")
vim.keymap.set("n", "<c-o>", "<c-o>zzzv")
vim.keymap.set("n", "<c-i>", "<c-i>zzzv")

-- Quickfix
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zzzv")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zzzv")

-- Moving stuff
vim.keymap.set("v", "J", "<cmd>m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", "<cmd>m '<-2<CR>gv=gv")

-- Undo breakpoints
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", "<", "<<c-g>u")
vim.keymap.set("i", ">", "><c-g>u")
vim.keymap.set("i", "=", "=<c-g>u")
vim.keymap.set("i", "(", "(<c-g>u")
vim.keymap.set("i", ")", ")<c-g>u")
vim.keymap.set("i", "[", "[<c-g>u")
vim.keymap.set("i", "]", "]<c-g>u")
vim.keymap.set("i", "{", "{<c-g>u")
vim.keymap.set("i", "}", "}<c-g>u")
vim.keymap.set("i", "+", "+<c-g>u")
vim.keymap.set("i", "-", "-<c-g>u")
vim.keymap.set("i", "=", "=<c-g>u")
vim.keymap.set("i", "<space>", "<space><c-g>u")

-- Resize splits
vim.keymap.set("n", "<C-w><", "<cmd>vertical resize +6<CR>")
vim.keymap.set("n", "<C-w>>", "<cmd>vertical resize -6<CR>")
vim.keymap.set("n", "<C-w>.", "<cmd>resize +6<CR>")
vim.keymap.set("n", "<C-w>,", "<cmd>resize -6<CR>")

-- Terminal mappings
vim.keymap.set("t", "<C-^>", "<C-\\><C-n><C-^>")
vim.keymap.set("t", "<C-w>w", "<C-\\><C-n>")
vim.keymap.set("t", "<C-w>c", "<C-\\><C-n><C-w>c")
vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l")
vim.keymap.set("t", "<C-w>v", "<C-\\><C-n><C-w>v")

-- Jumplist mutations
vim.keymap.set("n", "<expr> k", '(v:count > 13 ? "m\'" . v:count : "") . "k"')
vim.keymap.set("n", "<expr> j", '(v:count > 13 ? "m\'" . v:count : "") . "j"')

-- Toggle winbar
vim.keymap.set("n", "<Leader>x", require("johann2357.sets").toggle_winbar)

-- Select the last changed text
vim.keymap.set("n", "gp", "`[v`]")


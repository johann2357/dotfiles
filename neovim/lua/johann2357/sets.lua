-- Encoding
vim.o.fileencoding = "utf-8"
vim.o.encoding = "utf-8"
-- Search beahavior
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.smartcase = true
-- tab behavior
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.smartindent = true
-- Continue comment marker in new lines.
vim.o.formatoptions = vim.o.formatoptions .. "o"
-- Horizontal split below current.
vim.o.splitbelow = true
-- Vertical split to right of current.
vim.o.splitright = true
-- default 4000ms - reduce it for better user experience
vim.o.updatetime = 50
-- custom
vim.o.laststatus = 3
vim.o.cc = 100
vim.o.ruler = true
vim.o.foldenable = false
vim.o.signcolumn = "no"
vim.o.nu = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.termguicolors = true
vim.o.scrolloff = 6
vim.o.showcmd = true
vim.o.showmode = true

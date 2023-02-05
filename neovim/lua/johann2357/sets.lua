-- Encoding
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
-- Search beahavior
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.smartcase = true
-- tab behavior
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true
-- Continue comment marker in new lines.
vim.opt.formatoptions:append("o")
-- Horizontal split below current.
vim.opt.splitbelow = true
-- Vertical split to right of current.
vim.opt.splitright = true
-- default 4000ms - reduce it for better user experience
vim.opt.updatetime = 50
-- custom
vim.opt.laststatus = 2
vim.opt.colorcolumn = "120"
vim.opt.ruler = true
vim.opt.foldenable = false
vim.opt.signcolumn = "no"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 6
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.isfname:append("@-@")
-- undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true
-- ignore stuff
vim.opt.wildignore:append({
    '*.so',
    '*.swp',
    '*.pyc',
    '*.out',
    '*.out',
    '**/__pycache__/*',
    '**/.git/*',
    '**/node_modules/*',
    '**/dist/*',
})

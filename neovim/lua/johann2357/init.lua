require("johann2357.comment")
require("johann2357.devicons")
require("johann2357.hardline")
require("johann2357.harpoon")
require("johann2357.lsp")
require("johann2357.remaps")
require("johann2357.sets")
require("johann2357.telescope")
require("johann2357.treesitter")

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

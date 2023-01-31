require("johann2357.sets")
require("johann2357.remaps")
require("johann2357.colors")
require("johann2357.devicons")

require("johann2357.comment")
require("johann2357.hardline")
require("johann2357.harpoon")
require("johann2357.lsp")
require("johann2357.telescope")
require("johann2357.treesitter")
require("johann2357.zenmode")

-- TODO: fix autocmd
-- local LangSettings = vim.api.nvim_create_augroup('LangSettings', {})
-- vim.api.nvim_create_autocmd("CustomLangSettings", {
--     group = LangSettings,
--     pattern = "*.yaml",
--     callback = function()
--         vim.opt.tabstop = 2
--         vim.opt.softtabstop = 2
--         vim.opt.shiftwidth = 2
--     end,
-- })

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

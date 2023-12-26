require('johann2357.sets')
require('johann2357.remaps')
require('johann2357.lazy')

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

vim.api.nvim_exec([[
    augroup jinja2
        autocmd!
        autocmd BufNewFile,BufRead *.jinja2 setfiletype htmldjango
    augroup END
]], false)

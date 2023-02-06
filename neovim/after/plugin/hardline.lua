require("hardline").setup {
    -- theme = "gruvbox_minimal",
    theme = "catppuccin_minimal",
    bufferline = true,
    bufferline_settings = {
        use_harpoon_marks = true,
        show_index = true,
        separator = ' ',
        -- exclude_terminal = true,
    },
    sections = {
        -- {class = 'mode', item = require('hardline.parts.mode').get_item},
        {class = 'med', item = require('hardline.parts.git').get_item, hide = 80},
        '%<',
        {class = 'med', item = require('hardline.parts.filename').get_item},
        {class = 'med', item ='%='},
        {class = 'error', item = require('hardline.parts.lsp').get_error},
        {class = 'warning', item = require('hardline.parts.lsp').get_warning},
        {class = 'warning', item = require('hardline.parts.whitespace').get_item},
        {class = 'med', item = require('hardline.parts.line').get_item, hide = 60},
    },
}
-- currently hardline overwrites `showmode`
vim.opt.showmode = true

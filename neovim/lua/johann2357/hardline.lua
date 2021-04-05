require("hardline").setup {
    theme = "gruvbox_minimal",
    bufferline = true,
    bufferline_settings = {
        exclude_terminal = true,
        show_index = true,
    },
    sections = {
        {class = 'mode', item = require('hardline.parts.mode').get_item},
        {class = 'high', item = require('hardline.parts.git').get_item, hide = 80},
        '%<',
        {class = 'med', item = require('hardline.parts.filename').get_item},
        {class = 'med', item ='%='},
        {class = 'error', item = require('hardline.parts.lsp').get_error},
        {class = 'warning', item = require('hardline.parts.lsp').get_warning},
        {class = 'warning', item = require('hardline.parts.whitespace').get_item},
        {class = 'low', item = require('hardline.parts.line').get_item, hide = 80},
    },
}

local M = {}

-- Encoding
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
-- Search beahavior
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.smartcase = true
-- tab behavior
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
vim.opt.laststatus = 3
vim.opt.cc = "100"
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

-- dynamic stuff
M.toggle_winbar = function()
    local winbar = vim.api.nvim_get_option("winbar")
    if winbar == nil or winbar == "" then
        vim.api.nvim_set_option("winbar", "%=%R %M %f")
    else
        vim.api.nvim_set_option("winbar", "")
    end
end

return M

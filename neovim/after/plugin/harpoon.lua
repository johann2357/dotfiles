require("harpoon").setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
        tmux_autoclose_windows = false,
        -- filetypes that you want to prevent from adding to the harpoon list menu.
        excluded_filetypes = { "harpoon" },
        -- set marks specific to each git branch inside git repository
        mark_branch = true,
        -- enable tabline with harpoon marks
        tabline = true,
        tabline_prefix = "   ",
        tabline_suffix = "   ",
    },
    menu = {
        width = vim.api.nvim_win_get_width(0) - 10,
    }
})


local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>..", mark.add_file)
vim.keymap.set("n", "<leader>.c", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>k", ui.nav_next)
vim.keymap.set("n", "<leader>j", ui.nav_prev)

vim.keymap.set("n", "<leader>.a", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>.o", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>.e", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>.u", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>.h", function() ui.nav_file(5) end)
vim.keymap.set("n", "<leader>.t", function() ui.nav_file(6) end)
vim.keymap.set("n", "<leader>.n", function() ui.nav_file(7) end)
vim.keymap.set("n", "<leader>.s", function() ui.nav_file(8) end)

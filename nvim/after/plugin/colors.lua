vim.g.gruvbox_italic = 0
vim.g.gruvbox_italicize_comments = 0
vim.g.gruvbox_undercurl = 1
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_sign_column = 'bg0'

vim.cmd.colorscheme('gruvbox')
-- vim.cmd.colorscheme('solarized')
-- vim.cmd.colorscheme('minimalist')
-- vim.cmd.colorscheme('everforest')

vim.api.nvim_exec([[
    highlight clear SignColumn
]], true)

vim.api.nvim_exec([[
    match RedundantSpaces /\s\+$/
]], true)

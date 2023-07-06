vim.api.nvim_exec([[
    let g:solarized_termcolors=256
]], true)

vim.cmd.colorscheme('gruvbox')
-- vim.cmd.colorscheme('solarized')
-- vim.cmd.colorscheme('minimalist')

vim.g.gruvbox_italic = 0
vim.g.gruvbox_italicize_comments = 0
vim.g.gruvbox_undercurl = 1
vim.g.gruvbox_contrast_dark = 'hard'

--  FIXME: not showing colors properly
vim.api.nvim_exec([[
    " FIXME: not showing colors properly
    highlight clear SignColumn
]], true)

vim.cmd.highlight({ "RedundantSpaces", "ctermbg=red", "guibg=red" })
vim.cmd.highlight({ "CursorLineNr", "guibg=none" })
vim.cmd.highlight({ "Normal", "guibg=none", "ctermbg=none" })

vim.cmd.highlight({ "SignifySignAdd"    , "cterm=bold", "ctermbg=none", "ctermfg=119" })
vim.cmd.highlight({ "DiffAdd"           , "cterm=bold", "ctermbg=none", "ctermfg=119" })
vim.cmd.highlight({ "DiffDelete"        , "cterm=bold", "ctermbg=none", "ctermfg=167" })
vim.cmd.highlight({ "DiffChange"        , "cterm=bold", "ctermbg=none", "ctermfg=227" })
vim.cmd.highlight({ "SignifySignDelete" , "cterm=bold", "ctermbg=237",  "ctermfg=167" })
vim.cmd.highlight({ "SignifySignChange" , "cterm=bold", "ctermbg=237",  "ctermfg=227" })

vim.api.nvim_exec([[
    match RedundantSpaces /\s\+$/
]], true)

-- Normal mode, gd - go to definition of word under cursor
vim.keymap.set('n', '<leader>d', '<Plug>(coc-definition)', { silent = true })

-- vim.keymap.set('n', '<leader>t', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', '<leader>i', '<Plug>(coc-implementation)', { silent = true })
vim.keymap.set('n', '<leader>r', '<Plug>(coc-references)', { silent = true })

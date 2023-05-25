-- Normal mode, gd - go to definition of word under cursor
vim.keymap.set('n', '<leader>d', '<Plug>(coc-definition)', { silent = true })

-- vim.keymap.set('n', '<leader>t', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', '<leader>i', '<Plug>(coc-implementation)', { silent = true })
vim.keymap.set('n', '<leader>r', '<Plug>(coc-references)', { silent = true })
vim.keymap.set('n', '<leader>q', '<Plug>(coc-codeaction-selected)', { silent = true })
vim.keymap.set('n', 'ff', '<Plug>(coc-format-selected)', { silent = true })
vim.keymap.set('x', 'ff', '<Plug>(coc-format-selected)', { silent = true })
vim.keymap.set('x', '<leader>rr', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })

vim.keymap.set('n', '<leader>h', ":call CocActionAsync('doHover')<cr>")

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
-- vim.keymap.set("i", "<cr>", [[ coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>" ]], { silent = true })

vim.api.nvim_create_autocmd("CursorHold", {
    -- group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

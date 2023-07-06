local keyset = vim.keymap.set

-- Normal mode, <leader>d - go to definition of word under cursor

-- vim.keymap.set('n', '<leader>t', '<Plug>(coc-type-definition)', { silent = true })
keyset('n', '<leader>i',  '<Plug>(coc-implementation)', { silent = true })
keyset('n', '<leader>d',  '<Plug>(coc-definition)', { silent = true })
keyset('n', '<leader>r',  '<Plug>(coc-references)', { silent = true })

keyset('n', '<leader>ac', '<Plug>(coc-codeaction-cursor)', { silent = true })
keyset('n', '<leader>q',  '<Plug>(coc-codeaction-selected)', { silent = true })

keyset('v', '<leader>ff', '<Plug>(coc-format-selected)', { silent = true })
keyset('n', '<leader>re', '<Plug>(coc-codeaction-refactor)', { silent = true })
keyset('x', '<leader>rr', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", { nowait = true })

keyset('n', '<leader>h', ":call CocActionAsync('doHover')<cr>")

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
-- vim.keymap.set("i", "<cr>", [[ coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>" ]], { silent = true })

vim.api.nvim_create_autocmd("CursorHold", {
    -- group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


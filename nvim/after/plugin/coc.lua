local keyset = vim.keymap.set

-- Normal mode, <leader>d - go to definition of word under cursor

-- vim.keymap.set('n', '<leader>t', '<Plug>(coc-type-definition)', { silent = true })
-- Navigation
keyset('n', '<leader>i',  '<Plug>(coc-implementation)', { silent = true })
keyset('n', '<leader>d',  '<Plug>(coc-definition)', { silent = true })
keyset('n', '<leader>r',  '<Plug>(coc-references)', { silent = true })

-- Refactors
keyset('n', "<leader>rn", "<Plug>(coc-rename)", { silent = true })
keyset('v', '<leader>ff', '<Plug>(coc-format-selected)', { silent = true })

-- These two seem to be the same, probably getting rid of the second one.
keyset('v', '<leader>rr', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })
keyset('v', '<leader>ml', '<Plug>(coc-codeaction-selected)', { silent = true })

keyset('n', '.rn', '<Plug>(coc-diagnostic-next-error)', { silent = true })
keyset('n', '.rp', '<Plug>(coc-diagnostic-prev-error)', { silent = true })

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice

vim.api.nvim_create_autocmd("CursorHold", {
    -- group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


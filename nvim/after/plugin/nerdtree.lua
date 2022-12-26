vim.g.NERDTreeIgnore = { [[ \.pyc$ ]], [[ \.pyo$ ]], 'node_modules' }

function OpenFileTree()
    -- if I'm opening a existing file look for it in
    -- file tree, otherwise show current CWD

    -- TBD
    vim.api.nvim_exec([[ execute (expand('%:p') != '') ? 'NERDTreeFind' : 'NERDTree' ]], true);
end

-- map <leader>t :call OpenFileTree()<CR>
vim.keymap.set('n', '<leader>t', OpenFileTree, { remap = false })

vim.api.nvim_exec( [[

" workaround to set bufhidden=delete without making NerdTree to break.
" https://github.com/preservim/nerdtree/issues/47

function s:set_hidden()
    if empty(&buftype) "most explorer plugins have buftype=nofile
        setlocal bufhidden=delete
    endif
endfunction

autocmd BufRead * call s:set_hidden()

]], true)

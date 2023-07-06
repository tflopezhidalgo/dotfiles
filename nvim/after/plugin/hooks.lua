-- TODO: find better place for this
-- https://neovim.io/doc/user/options.html#'runtimepath'

vim.api.nvim_exec([[

" ===== Hooks =====
augroup default
    au!
    autocmd FileType python setlocal formatprg=black\ -q\ -t\ py27\ -
    autocmd FileType cpp setlocal formatprg=clang-format\ --style=google
    autocmd FileType rust setlocal formatprg=rustfmt
    autocmd FileType typescript,json setlocal

    " limpiar espacios al final de las lineas
    autocmd BufWritePre * :%s/\s\+$//e

    autocmd BufRead,BufNewFile *.js* set shiftwidth=2
    autocmd BufRead,BufNewFile *.ts* set shiftwidth=2
    autocmd BufRead,BufNewFile *.sql* set shiftwidth=2
    autocmd BufRead,BufNewFile *.md* set wrap  "" want to be able to read full sentences
augroup END

" ==================

]], true)



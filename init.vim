
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vim_plug_path)
    echo "Downloading source code for Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

call plug#begin('~/.config/nvim/plugged')

" text object for indentation
Plug 'michaeljsmith/vim-indent-object'

"" árbol de directorios
Plug 'scrooloose/nerdtree'

" Cerrado de a pares de parentésis / llaves, etc
Plug 'Townk/vim-autoclose'

" elegir buffer
Plug 't9md/vim-choosewin'

"" git wrapper
Plug 'tpope/vim-fugitive'

" marca los diffs de git / hg en los laterales
Plug 'mhinz/vim-signify'

" colors
Plug 'morhetz/gruvbox'

" Common languages
" - coc-elixir"
" - coc-flow"
" - coc-json"
" - coc-rust-analyzer"
" - coc-tsserver"
" - coc-python"

"" autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"" lua based ast
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" lol
Plug 'tflopezhidalgo/vim-pipe'


call plug#end()

" this first setting decides in which order try to guess your current vcs
let g:signify_vcs_list = ['git']

" si fue compilado con +termguicolors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

colorscheme gruvbox

let NERDTreeIgnore = ['\.pyc$', '\.pyo$', 'node_modules']

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

"gruvbox
let g:gruvbox_italic= 0
let g:gruvbox_italicize_comments = 0
let g:gruvbox_undercurl = 1
let g:gruvbox_contrast_dark = "hard"

"FuzzyFinder should ignore all files in .gitignore
let ignorefile = ".gitignore"
if filereadable(ignorefile)
  let ignore = '\v\~$'
  for line in readfile(ignorefile)
    let line = substitute(line, '\.', '\\.', 'g')
    let line = substitute(line, '\*', '.*', 'g')
    let ignore .= '|^' . line
  endfor

  let g:fuf_coveragefile_exclude = ignore . '|.\*node_modules.\*'
endif

" Basic config
set completeopt+=preview
set wildmode=longest,list
set noswapfile
set incsearch nohlsearch
set directory^=$HOME/.config/nvim/tmp/
set tabstop=4 softtabstop=0 expandtab shiftwidth=0 smarttab
set number relativenumber
set scrolloff=15
set nowrap

" ignore case when searching
set ignorecase
set smartcase

" show commands being typed
set showcmd
set background=dark
set shell=/bin/zsh

" FIXME: not showing colors properly
highlight clear SignColumn

" nicer colors
highlight SignifySignAdd    cterm=bold ctermbg=none  ctermfg=119
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

function OpenFileTree()
    "" if I'm opening a existing file look for it in
    "" file tree, otherwise show current CWD
    execute (expand('%:p') != '') ? 'NERDTreeFind' : 'NERDTree'
endfunction

"===== Mappings =====

let mapleader = ","

" Normal mode, gd - go to definition of word under cursor
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>t <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)
map e <Nop>

" switch between pair of brackets / parenthesis, etc
nnoremap <tab> %
vnoremap <tab> %

"nerdtree
map <leader>t :call OpenFileTree()<CR>

imap jj <Esc>

map<silent> + :vertical res +5<cr>
map<silent> - :vertical res -5<cr>

" mostrar los cambios
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)

nmap ñ <Plug>(choosewin)
nmap ; <Plug>(choosewin)

map cp "+y

map<silent> <leader>f :GFiles <enter>
map<silent> <leader>a :Ag <enter>

" get me out of terminal with default esc
tmap jj <C-\><C-n>

" ===== Hooks =====

augroup default
    au!
    autocmd FileType python setlocal formatprg=black\ -q\ -t\ py27\ -
    autocmd FileType cpp setlocal formatprg=clang-format\ --style=google
    autocmd FileType rust setlocal formatprg=rustfmt

    " limpiar espacios al final de las lineas
    autocmd BufWritePre * :%s/\s\+$//e

    autocmd BufRead,BufNewFile *.js* set shiftwidth=2 syntax=typescript
    autocmd BufRead,BufNewFile *.ts* set shiftwidth=2
    autocmd BufRead,BufNewFile *.sql* set shiftwidth=2
    autocmd BufRead,BufNewFile *.md* set wrap  "" want to be able to read full sentences
augroup END


"" mostrar extra whitespaces en rojo
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/

"" small details on coloring
highlight CursorLineNr guibg=None


"" enable treesitter magic
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF



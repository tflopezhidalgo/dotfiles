
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
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

" asynchronous execution
Plug 'neomake/neomake'

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

"" editor config (usar archivo de configuración para configurar vim)
Plug 'editorconfig/editorconfig-vim'

" colors
Plug 'morhetz/gruvbox'

"" autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

""" python lang sv
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }

"fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"" lua based ast
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

call plug#end()

" si fue compilado con +termguicolors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

colorscheme gruvbox

let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Le dice a vim que haga foco en la nueva ventana

let g:neomake_python_python_maker = neomake#makers#ft#python#python()
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
let g:neomake_python_flake8_maker = { 'args': ['--max-line-length=140', '--ignore=E731, E128, E127, E126'], }
let g:neomake_python_enabled_makers = ['flake8']

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git']

" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227


" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

"gruvbox
let g:gruvbox_italic= 0
let g:gruvbox_italicize_comments = 0
let g:gruvbox_undercurl = 1
let g:gruvbox_contrast_dark = "hard"


" fuzzyfinder
"FuzzyFinder should ignore all files in .gitignore
let ignorefile = ".gitignore"
if filereadable(ignorefile)
  let ignore = '\v\~$'
  for line in readfile(ignorefile)
    let line = substitute(line, '\.', '\\.', 'g')
    let line = substitute(line, '\*', '.*', 'g')
    let ignore .= '|^' . line
  endfor

  let g:fuf_coveragefile_exclude = ignore
endif


" Basic config
set completeopt+=preview
set completeopt+=noinsert
set wildmode=longest,list
set noswapfile
set incsearch nohlsearch
set directory^=$HOME/.config/nvim/tmp/
set tabstop=4 softtabstop=0 expandtab shiftwidth=0 smarttab
set number
set relativenumber 
set scrolloff=15
set nowrap
" ignore case when searching
set ignorecase
set smartcase

" show commands being typed
set showcmd
set background=dark

"===== Mappings =====

" Normal mode, gd - go to definition of word under cursor
nmap <silent> ,d <Plug>(coc-definition)
nmap <silent> ,t <Plug>(coc-type-definition)
nmap <silent> ,i <Plug>(coc-implementation)
nmap <silent> ,r <Plug>(coc-references)

" jedi goto
"nmap ,d :tab split<CR>:call jedi#goto()<CR>

" Always use very magic regex mode when searching
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v

" switch between pair of brackets / parenthesis, etc
nnoremap <tab> %
vnoremap <tab> %

"nerdtree
"
" TODO. spawn on cwd
map ,t :NERDTreeToggle<CR>

imap jj <Esc>
"map vs :vs
"map sp :sp
map<silent> + :vertical res +5<cr>
map<silent> - :vertical res -5<cr>

" mostrar los cambios
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)

nmap ñ <Plug>(choosewin)
nmap ; <Plug>(choosewin)

" Moverse entre buffers
" ojo porque hace que la b se bloquee esperando 
" ver si es un comando o el back
" map bn :bn<CR>
" map bp :bp<CR>
" map bd :bd<CR>

map cp "+y 

map @d Oimport pdb; pdb.set_trace()<Esc>

map<silent> ,f :FZF <enter>

" nnoremap <expr> f &foldlevel ? 'zM' :'zR'

"===== Hooks =====

autocmd FileType python setlocal formatprg=black\ -q\ -t\ py27\ -
autocmd TabLeave * let g:lasttab = tabpagenr()

" limpiar espacios al final de los archivos
autocmd BufWritePre *.js* %s/\s\+$//e
autocmd BufWritePre *.ts* %s/\s\+$//e
autocmd BufWritePre *.py %s/\s\+$//e
autocmd BufWritePre *.rb %s/\s\+$//e
autocmd BufWritePre *.java %s/\s\+$//e
autocmd BufWritePre *.groovy %s/\s\+$//e

" hooks para el linter
autocmd! BufWritePost * Neomake

autocmd BufRead,BufNewFile *.js* set shiftwidth=2 syntax=typescript
autocmd BufRead,BufNewFile *.ts* set shiftwidth=2
autocmd BufRead,BufNewFile *.sql* set shiftwidth=2

"" mostrar extra whitespaces en rojo 
highlight RedundantSpaces ctermbg=red guibg=red 
match RedundantSpaces /\s\+$/

"" small detaisl on coloring
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

set shell=/bin/zsh

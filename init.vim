
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

" syntax
Plug 'sheerun/vim-polyglot'

" asynchronous execution
Plug 'neomake/neomake'

"" barra de estado junto con sus temas
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"" árbol de directorios 
Plug 'scrooloose/nerdtree'

"" cantidad de matches que tuvimos en las búsquedas
Plug 'vim-scripts/IndexedSearch' 

" Cerrado de a pares de parentésis / llaves, etc
Plug 'Townk/vim-autoclose'

" elegir buffer 
Plug 't9md/vim-choosewin'

" highlight para pares de tags
Plug 'valloric/MatchTagAlways'

" Tagbar
Plug 'preservim/tagbar'

"" git wrapper
Plug 'tpope/vim-fugitive'

" marca los diffs de git / hg en los laterales
Plug 'mhinz/vim-signify'

"" editor config (usar archivo de configuración para configurar vim)
Plug 'editorconfig/editorconfig-vim'

" colors
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'

"" autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

""" python lang sv
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }

"fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


call plug#end()

" ============================================================================
" Install plugins the first time vim runs
"
if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" si fue compilado con +termguicolors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" use 256 colors when possible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
	let t_Co = 256
    colorscheme gruvbox
else
    colorscheme delek
endif


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

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'
let g:airline#extensions#whitespace#enabled = 0

let g:airline#extensions#tabline#enabled = 1           " enable airline tabline
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right
let g:airline#extensions#tabline#show_buffers = 1      " dont show buffers in the tabline
let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_tab_nr = 1       " disable tab numbers

"gruvbox
let g:gruvbox_italic= 1
let g:gruvbox_italicize_comments = 0
let g:gruvbox_undercurl = 1
let g:gruvbox_contrast_dark = "hard"

" Basic config
set completeopt+=preview
set completeopt+=noinsert
set wildmode=longest,list
set incsearch nohlsearch
set directory^=$HOME/.config/nvim/tmp/
set tabstop=4 softtabstop=0 expandtab shiftwidth=0 smarttab
set relativenumber number
set cursorline
set scrolloff=15
set nowrap
" ignore case when searching
set ignorecase

set smartcase
set re=0
syntax on

" show commands being typed
set showcmd

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
map ,t :NERDTreeFind<CR>
map ,t :NERDTreeToggle<CR>

imap jj <Esc>
map vs :vs
map sp :sp
map<silent> + :vertical res +5<cr>
map<silent> - :vertical res -5<cr>

" mostrar los cambios
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)

nmap ñ <Plug>(choosewin)
nmap ; <Plug>(choosewin)

" Moverse entre buffers
map bn :bn<CR>
map bp :bp<CR>
map bd :bd<CR>

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

autocmd BufRead,BufNewFile *.js* set shiftwidth=2
autocmd BufRead,BufNewFile *.ts* set shiftwidth=2

"" mostrar extra whitespaces en rojo 
highlight RedundantSpaces ctermbg=red guibg=red 
match RedundantSpaces /\s\+$/

set shell=/bin/zsh

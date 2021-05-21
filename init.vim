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

" md for us
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}

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

" completion for vim (like coc-core)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" python completion language for deoplete engine (python)
Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }

" completion, find references, etc for python
Plug 'davidhalter/jedi-vim'

""" under test

"fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


" use 256 colors when possible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
	let &t_Co = 256
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

" Use deoplete.
let g:deoplete#enable_at_startup = 0 
let g:deoplete#enable_ignore_case = 1

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" All these mappings work only for python code:
let g:jedi#goto_command = ',d'
let g:jedi#usages_command = ',o'
let g:jedi#goto_assignments_command = ',a'
let g:jedi#use_splits_not_buffers = "right"
nmap ,D :tab split<CR>:call jedi#goto()<CR>


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
"
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
"
let g:gruvbox_italic= 1
let g:gruvbox_italicize_comments = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_contrast_dark = "hard"

"nerdtree
"
" TODO. spawn on cwd
map ,t :NERDTreeFind<CR>
map ,t :NERDTreeToggle<CR>

" Basic config
set completeopt+=preview
set completeopt+=noinsert
set wildmode=longest,list
set incsearch nohlsearch
set directory^=$HOME/.config/nvim/tmp/
set tabstop=4 softtabstop=0 expandtab shiftwidth=0 smarttab
set relativenumber number
set background=dark
set termguicolors
set cursorline
set scrolloff=10
set nowrap


" Folding
set foldmethod=indent
set foldnestmax=99


" Mappings
imap jj <Esc>
map vs :vs
map<silent> + :vertical res +5<cr>
map<silent> - :vertical res -5<cr>

" mostrar los cambios
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)

nmap  ñ  <Plug>(choosewin)

" save as sudo
ca w!! w !sudo tee "%"

map TT :tabnew 
map tt :exe "tabn ".g:lasttab<CR>

" Moverse entre pestañas
map bn :bn<CR>
map bp :bp<CR>
map bd :bd<CR>

" Mover y modificar pestañas
map tm :tabm 
map ts :tab split<CR>

map cp "+y 

map @d Oimport pdb; pdb.set_trace()<Esc>

" ============== Hooks =================== "

autocmd FileType * exe "normal zR"
autocmd VimEnter * wincmd l

" nnoremap <expr> f &foldlevel ? 'zM' :'zR'
" TODO: especificar py27
autocmd FileType python setlocal formatprg=black\ -q\ -t\ py27\ -

autocmd TabLeave * let g:lasttab = tabpagenr()

" limpiar espacios al final de los archivos
autocmd BufWritePre *.js %s/\s\+$//e
autocmd BufWritePre *.py %s/\s\+$//e
autocmd BufWritePre *.rb %s/\s\+$//e
autocmd BufWritePre *.java %s/\s\+$//e
autocmd BufWritePre *.groovy %s/\s\+$//e

" hooks para el linter
autocmd! BufWritePost * Neomake

" on python files set as default formatter autopep8

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"" mostrar extra whitespaces en rojo 
highlight RedundantSpaces ctermbg=red guibg=red 
match RedundantSpaces /\s\+$/


" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/sh 

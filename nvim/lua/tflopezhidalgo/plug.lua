-- TODO: Pending to be migrated.

vim.api.nvim_exec([[ 
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

]], true)

-- Grab Plug's plugging function
-- and inject it as variable here
-- so we can use it as Plug('<your cool plugin>')

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('michaeljsmith/vim-indent-object')

-- Cerrado de a pares de parentésis / llaves, etc
Plug('Townk/vim-autoclose')

-- Change buffers quickly
Plug('t9md/vim-choosewin')

-- Colors
Plug('morhetz/gruvbox')

-- marca los diffs de git / hg en los laterales
Plug('mhinz/vim-signify')

-- árbol de directorios
Plug('scrooloose/nerdtree')

-- autocompletion
Plug('neoclide/coc.nvim', {['branch'] = 'release'})

-- fzf
Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install()'] })
Plug('junegunn/fzf.vim')

-- lua based ast
Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn['TSUpdate'] }) -- We recommend updating the parsers on update

--  Vim pipe
Plug('tflopezhidalgo/vim-pipe')

vim.call('plug#end')

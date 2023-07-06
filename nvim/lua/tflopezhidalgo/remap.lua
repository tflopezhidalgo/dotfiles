vim.g.mapleader = ','

vim.keymap.set('i', 'jj', '<esc>')

-- Switch between pair of brackets / parenthesis, etc
vim.keymap.set('n', '<tab>', '%', { remap = false })
vim.keymap.set('v', '<tab>', '%', { remap = false })

vim.keymap.set('n', 'cp', [[ "+y ]])
vim.keymap.set('v', 'cp', [[ "+y ]])

vim.keymap.set('n', '+', ':vertical res +5<cr>', { silent = true })
vim.keymap.set('n', '-', ':vertical res -5<cr>', { silent = true })

vim.keymap.set('n', '<leader>rr', ':source $HOME/.config/nvim/init.lua <enter>', { silent = false })

--  copy relative path
vim.keymap.set('n', 'cr', ':let @+ = expand("%:~:.")<cr>', { silent = true })

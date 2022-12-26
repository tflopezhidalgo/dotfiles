vim.keymap.set('n', '<leader>f', ':GFiles <enter>', { silent = true })
vim.keymap.set('n', '<leader>a', ':Ag <enter>', { silent = true })

-- TODO
vim.api.nvim_exec([[

"FuzzyFinder should ignore all files in .gitignore
let ignorefile = ".gitignore"

if filereadable(ignorefile)
  let ignore = '\v\~$'
  for line in readfile(ignorefile)
    let line = substitute(line, '\.', '\\.', 'g')
    let line = substitute(line, '\*', '.*', 'g')
    let ignore .= '|^' . line
  endfor

  " Ignore node_modules as well.
  let g:fuf_coveragefile_exclude = ignore . '|.\*node_modules.\*'
endif

]], true)




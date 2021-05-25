" Initial .gvimrc for MacVim

"set guifont=Monaco:h10
"set macligatures
set guifont=Fira\ Code:h12
"set guifont=Monaco\ for\ Powerline:h12
"set guifont=Source\ Code\ Pro\ for\ Powerline:h12

set lines=60
set columns=110
set nu
"set syntax=on
"set noantialias
set shell=/usr/local/bin/zsh

set transparency=10

" Color
"hi Cursor       gui=NONE    guibg=red       guifg=white
" Update color to hex code -- Louis 2021/0521
hi CursorLine   guibg=#1c1c1c
hi CursorColumn guibg=#1c1c1c
hi Search       guifg=#080808
hi CursorLineNr gui=bold    guifg=#ffd787


" Reorg VIM configuration file
" -- Louis 06010218

" vim-plug automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --------------------- plugins starts
call plug#begin('~/.vim/plugged')

Plug 'nanotech/jellybeans.vim' " color scheme
Plug 'vim-airline/vim-airline' " better status line
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive' " git operation in vim
Plug 'airblade/vim-gitgutter' " +/- mark for git change
Plug 'ctrlpvim/ctrlp.vim' " fuzzy file search
Plug 'Yggdroot/indentLine' " indent line
Plug 'scrooloose/nerdtree' " tree structure file browser
"Plug 'morhetz/gruvbox' "color scheme
Plug 'ntpeters/vim-better-whitespace' "show/cleanup unnecessary whitespace
Plug 'qpkorr/vim-bufkill' " delete buffer without destroying windows
Plug 'aperezdc/vim-template' " template for various filetypes
call plug#end()

" --------------------- vim alias/configuration
filetype plugin indent on
syntax enable

" set tab to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

set nu " set line number
set lbr " wrap long lines at a character in 'breakat' (local to window)
set ic " set search case-insensitive
set cursorline cursorcolumn " show a marker on the current line/column
set hlsearch " highlight search-match string
set backspace=indent,eol,start " enable delete key

" something about split
set splitbelow splitright " split window to below/right first
nnoremap <C-w><BAR> <C-w>v
nnoremap <C-w>_ <C-w>s

" move between buffers
nnoremap <PageUp>   :bnext<CR>
nnoremap <PageDown> :bprev<CR>
nnoremap <C-n>      :enew<CR>

" --------------------- jellybeans color fine-tune
colorscheme jellybeans
hi Normal ctermbg=NONE guibg=#000000
hi CursorLine   cterm=NONE ctermbg=234 guibg=#3E3D32
hi CursorColumn cterm=NONE ctermbg=234 guibg=#3E3E32
hi CursorLineNr cterm=NONE ctermbg=208 guifg=#FD971F gui=NONE
hi Search cterm=NONE ctermbg=yellow ctermfg=black

" --------------------- plugin setup
let g:airline_theme='powerlineish'
let g:Powerline_symbols='fancy'
let g:airline_powerline_fonts=1

" enable buffers and numbers in the tab bar
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" accelerate gitgutter performance
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 0

let g:gitgutter_sign_added = '✚'
"let g:gitgutter_sign_modified = '☰'
let g:gitgutter_sign_modified = '✱'
let g:gitgutter_sign_removed = '✖'
let g:gitgutter_sign_modified_removed = '✖'

let g:strip_whitespace_on_save = 1

" configure template info
let g:username = 'Louis Hsu'
let g:email = 'louis.shiu@gmail.com'

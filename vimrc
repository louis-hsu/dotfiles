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
"Plug 'airblade/vim-gitgutter' " +/- mark for git change
Plug 'mhinz/vim-signify' " replace airblade/vim-gitgutter
Plug 'ctrlpvim/ctrlp.vim' " fuzzy file search
Plug 'Yggdroot/indentLine' " indent line
Plug 'scrooloose/nerdtree' " tree structure file browser
"Plug 'morhetz/gruvbox' "color scheme
Plug 'ntpeters/vim-better-whitespace' "show/cleanup unnecessary whitespace
Plug 'qpkorr/vim-bufkill' " delete buffer without destroying windows
Plug 'aperezdc/vim-template' " template for various filetypes
Plug 'kh3phr3n/python-syntax' " rich python syntax highlighting
Plug 'valloric/youcompleteme' " code language autocompletion framework
Plug 'SirVer/ultisnips' "smart snippets completion engine
Plug 'honza/vim-snippets' "snippets collection
Plug 'ervandew/supertab' "define tab behavior smarter

call plug#end()

" --------------------- vim alias/configuration
set nocompatible
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

set diffopt=filler,vertical " setup diff option
nnoremap <C-N><C-N> :set invnumber<CR> " double C-N to turn on/off linenumber
set fileencoding=utf8
set encoding=utf8
set tenc=utf8

" something about split
set splitbelow splitright " split window to below/right first
nnoremap <C-w><BAR> <C-w>v
nnoremap <C-w>_ <C-w>s

" move between buffers
nnoremap <PageUp>   :bnext<CR>
nnoremap <PageDown> :bprev<CR>
nnoremap <C-n>      :enew<CR>

set formatoptions=cro " config behavior of comment leader

" --------------------- jellybeans color fine-tune
colorscheme jellybeans
hi Normal ctermbg=NONE guibg=#000000
hi CursorLine   cterm=NONE ctermbg=234 guibg=#3E3D32
hi CursorColumn cterm=NONE ctermbg=234 guibg=#3E3E32
hi CursorLineNr cterm=NONE ctermbg=208 guifg=#FD971F gui=NONE
hi Search cterm=NONE ctermbg=yellow ctermfg=black

" --------------------- plugin setup
"let g:airline_theme='powerlineish'
let g:airline_theme='wombat'
let g:Powerline_symbols='fancy'
let g:airline_powerline_fonts=1

" enable buffers and numbers in the tab bar
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" configure vim-signify
let g:signify_vcs_list = ['git']
let g:signify_realtime = 1
let g:signify_line_highlight = 0
let g:signify_show_count = 1
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

let g:strip_whitespace_on_save = 1

" configure template info
let g:username = 'Louis Hsu'
let g:email = 'louis.shiu@gmail.com'

" CtrlP configuration
let g:ctrlp_show_hidden=1
"let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth=40
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm|gradle|idea)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc|class|swp)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

let NERDTreeShowHidden=1 " show hidden file

" configure YCM
" point YCM to virtualenv path
let pipenv_venv_path = system('pipenv --venv')
if shell_error == 0
    let venv_path =substitute(pipenv_venv_path, '\n', '', '')
    let g:ycm_python_binary_path =venv_path . '/bin/python'
else
    let g:ycm_python_binary_path = 'python'
endif
" set preview window behavior
"let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" configure ultisnips
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" --------------------- disabled
" configure and accelerate gitgutter performance
"let g:gitgutter_realtime = 1
"let g:gitgutter_eager = 0
"let g:gitgutter_sign_added = '✚'
"let g:gitgutter_sign_modified = '☰'
"let g:gitgutter_sign_modified = '✱'
"let g:gitgutter_sign_removed = '✖'
"let g:gitgutter_sign_modified_removed = '✖'

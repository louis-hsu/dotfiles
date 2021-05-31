" Reorg VIM configuration file
" -- Louis 06010218

" vim-plug automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --------------------- plugins starts
call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim' " Nordic style theme
Plug 'vim-airline/vim-airline' " better status line
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive' " git operation in vim
Plug 'mhinz/vim-signify' " replace airblade/vim-gitgutter
Plug 'moll/vim-bbye' " optional dependency
Plug 'aymericbeaumet/vim-symlink' " fix fugitive-and-symbolic link issue
"Plug 'ctrlpvim/ctrlp.vim' " fuzzy file search
Plug 'Yggdroot/indentLine' " indent line
Plug 'scrooloose/nerdtree' " tree structure file browser
Plug 'ntpeters/vim-better-whitespace' "show/cleanup unnecessary whitespace
Plug 'qpkorr/vim-bufkill' " delete buffer without destroying windows

"Plug 'aperezdc/vim-template' " template for various filetypes
"Plug 'kh3phr3n/python-syntax' " rich python syntax highlighting
"Plug 'honza/vim-snippets' "snippets collection

" Move commented out plugin together -- Louis 2021/0521
"Plug 'valloric/youcompleteme' " code language autocompletion framework
"Plug 'SirVer/ultisnips' "smart snippets completion engine
"Plug 'morhetz/gruvbox' "color scheme
"Plug 'airblade/vim-gitgutter' " +/- mark for git change
"Plug 'nanotech/jellybeans.vim' " color scheme
"Plug 'ervandew/supertab' "define tab behavior smarter

call plug#end()

" --------------------- vim alias/configuration
set nocompatible
filetype plugin indent on
syntax enable

" set tab to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" setup backup dir to ~/.tmp for swp files --Louis 2018/1219
"set backupdir-=.
"set backupdir^=~/.tmp,/tmp
set backupdir=/tmp
set directory=/tmp//
set backup
" and the backup extension
au BufWritePre * let &bex = substitute(expand('%:p:h'), '/', ':', 'g') . strftime('-%FT%T')

" set k/j works on disply line while in wrap mode -- Louis 2018/1219
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

set nu " set line number
nnoremap <C-N><C-N> :set invnumber<CR> " double C-N to turn on/off linenumber
set lbr " wrap long lines at a character in 'breakat' (local to window)
set ic " set search case-insensitive
set cursorline cursorcolumn " show a marker on the current line/column
set hlsearch " highlight search-match string
set backspace=indent,eol,start " enable delete key

"autocmd BufNewFile,BufRead *.txt set ft=text

"
"set diffopt=filler,vertical " setup diff option
"set fileencoding=utf8
"set encoding=utf8
"set tenc=utf8
"
"" something about split
"set splitbelow splitright " split window to below/right first
"nnoremap <C-w><BAR> <C-w>v
"nnoremap <C-w>_ <C-w>s
"
"" Change to tab usage --Louis 20190520
"" move between buffers
"" nnoremap <PageUp>   :bnext<CR>
"" nnoremap <PageDown> :bprev<CR>
"" nnoremap <C-n>      :enew<CR>
"
"set formatoptions=cro " config behavior of comment leader
""set autowrite " auto save when switching buffer"
"
" --------------------- jellybeans color fine-tune
"colorscheme jellybeans
"hi Cursor       cterm=NONE  ctermbg=9
"hi CursorLineNr cterm=bold  ctermbg=21  ctermfg=226
"hi Search       cterm=NONE  ctermbg=214 ctermfg=232

" --------------------- nord color fine-tune
augroup nord-overrides
    autocmd!
    autocmd ColorScheme nord highlight Comment ctermfg=102
    autocmd ColorScheme nord highlight Normal ctermbg=NONE guibg=#000000
    autocmd ColorScheme nord highlight CursorLine cterm=NONE ctermbg=NONE
    autocmd ColorScheme nord highlight CursorColumn cterm=NONE ctermbg=234
    autocmd ColorScheme nord highlight CursorLineNr cterm=bold ctermfg=222
    autocmd ColorScheme nord highlight Search cterm=NONE ctermfg=232
augroup END

colorscheme nord
"hi Normal       ctermbg=NONE    guibg=#000000
"hi CursorLine   cterm=NONE  ctermbg=NONE
"hi CursorColumn cterm=NONE  ctermbg=234
"hi CursorLineNr cterm=bold  ctermfg=222
"hi Search       cterm=NONE  ctermfg=232
"let g:nord_cursor_line_number_bacground=1
let g:nord_bold_vertical_split_line=1
let g:nord_uniform_diff_background=1

" --------------------- plugin setup
"let g:airline_theme='powerlineish'
let g:airline_theme='wombat'
"let g:Powerline_symbols='fancy'

" Fix error code of symbol 'g:airline_symbols.colnr' -- Louis 2021/0521
if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif

let g:airline_powerline_fonts=1
let g:airline_symbols.colnr='㏇'
let g:airline_symbols.linenr='㏑'
let g:airline_section_z=airline#section#create_right(['%p%% %#__accent_bold#%{g:airline_symbols.linenr}:%l/%L %{g:airline_symbols.colnr}:%v%#__restore__#'])


" enable buffers and numbers in the tab bar
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" vim-better-whitespace
" Enable auto strip on saving -- Louis 2021/0507
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0


" vim-fugitive
" Set up branch mark -- Louis 2021/0521
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch#empty_message=''

" Yggdroot/indentLine
" Set command to turn indentline on/off -- Louis 2021/0521
nnoremap <C-I><C-I> :IndentLinesToggle<CR> " double C-I to turn on/off indentline

" vim-bufkill
" Set command to trigger buffer kill -- Louis 2021/0521
map <C-c> :BD<cr>

" NerdTree setup -- Louis 2021/0521
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeFind<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window left.
 autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

let NERDTreeShowHidden=1 " show hidden file

"" Change to tab movement --Louis 20190520
"" move between tab
"nnoremap <PageUp>   :tabnext<CR>
"nnoremap <PageDown> :tabprevious<CR>
"nnoremap <C-n>      :tabnew<CR>
"
"
"" configure vim-signify
"let g:signify_vcs_list = ['git']
"let g:signify_realtime = 1
""let g:signify_cursorhold_normal = 0  " aggressive show sign and save buffer
""let g:signify_cursorhold_insert = 0  " aggressive show sign and save buffer
"let g:signify_line_highlight = 0
"let g:signify_show_count = 1
"highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
"highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
"highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227
"
"let g:strip_whitespace_on_save = 1
"let g:strip_whitespace_confirm = 0
"
"" configure template info
"let g:username = 'Louis Hsu'
"let g:email = 'louis.shiu@gmail.com'
"
"" CtrlP configuration
"let g:ctrlp_show_hidden=1
""let g:ctrlp_clear_cache_on_exit = 0
"let g:ctrlp_max_files = 0
"let g:ctrlp_max_depth=40
"let g:ctrlp_custom_ignore = {
"    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm|gradle|idea)$',
"    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc|class|swp)$',
"    \ }
"let g:ctrlp_working_path_mode=0
"let g:ctrlp_match_window_bottom=1
"let g:ctrlp_max_height=15
"let g:ctrlp_match_window_reversed=0
"let g:ctrlp_mruf_max=500
"let g:ctrlp_follow_symlinks=1


"" configure YCM
"" point YCM to virtualenv path
""let pipenv_venv_path = system('pipenv --venv')
""if shell_error == 0
""    let venv_path =substitute(pipenv_venv_path, '\n', '', '')
""    let g:ycm_python_binary_path =venv_path . '/bin/python'
""else
""    let g:ycm_python_binary_path = 'python'
""endif
""" set preview window behavior
"""let g:ycm_autoclose_preview_window_after_completion = 1
""let g:ycm_autoclose_preview_window_after_insertion = 1
""let g:ycm_key_list_select_completion = ['<tab>']
""let g:ycm_key_list_previous_completion = ['<s-tab>']
"""let g:SuperTabDefaultCompletionType = '<C-n>'
"
"" configure ultisnips
"" better key bindings for UltiSnipsExpandTrigger
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"" take <cr><enter> as the hotkey to expand trigger
"" https://github.com/SirVer/ultisnips/issues/376
"let g:UltiSnipsExpandTrigger="<nop>"
"let g:ulti_expand_or_jump_res = 0
"function! <SID>ExpandSnippetOrReturn()
"    let snippet = UltiSnips#ExpandSnippetOrJump()
"    if g:ulti_expand_or_jump_res > 0
"        return snippet
"    else
"        return "\<CR>"
"    endif
"endfunction
"inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"
"
"" --------------------- disabled
"" configure and accelerate gitgutter performance
""let g:gitgutter_realtime = 1
""let g:gitgutter_eager = 0
""let g:gitgutter_sign_added = '✚'
""let g:gitgutter_sign_modified = '☰'
""let g:gitgutter_sign_modified = '✱'
""let g:gitgutter_sign_removed = '✖'
"""let g:gitgutter_sign_modified_removed = '✖'

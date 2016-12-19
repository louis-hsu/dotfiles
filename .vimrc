" $Id: _vimrc,v 1.11 2000/10/03 17:33:16 hmak Exp $
"
"     for Unix and OS/2:  ~/.vimrc
"  for MS-DOS and Win32:  $VIM/_vimrc ; $HOME/.vimrc

execute pathogen#infect()

" Syntax & File Types
if (version >= 500)
    " .gvimrc is executed after this so &bg decision must be made here
    set bg=dark

    " let c_comment_strings=1
    let is_fvwm2 = 1        " I use fvwm2, not fvwm1
 
    " vim v5.4 only:
    " Next line must occur before any ":filetype on" or ":syntax on" commands
    let myfiletypefile = "$HOME/.vimrc_filetypes"

    " source $HOME/.vimrc_syntax after default syntax files are executed
    let mysyntaxfile = "$HOME/.vimrc_syntax"
   
    if ! has("gui")
        " this will usually be done in .gvimrc
        syntax on
    endif
    
    " vim 7.0 or later
    syntax enable
endif

set nocompatible        " Use Vim defaults (much better!)
set viminfo='20,\"50,%,n$HOME/.viminfo
set bs=2                " allow backspacing over everything in insert mode
set ru                  " ruler on
set ch=3                " cmdheight
set ls=2                " laststatus (always show status line)
set is                  " incsearch on
set sbr=\ \             " showbreak (prefix for wrapped lines)
set lbr                 " linebreak (when wrapon, break lines at &brk)
set vb                  " visualbell (flash instead of beep)

" Coding
set tags=./tags,tags,$HOME/thesis/tags
set sft                 " showfulltag (include entire line for function match)
set notbs               " tagbsearch (don't assume that tag files are sorted)

"set path=.,/usr/include,/usr/include/g++-3,/Progra~1/DevStudio/VC/include,$HOME/thesis/include,$HOME/thesis/include2
"set dict=/usr/dict/words        " files to look in for <C-X><C-K>
set cpt=.,b             " complete (<C-N/P> looks in current and loaded bufs)
set noaw                " no autowrite (don't automatically write b4 makes)
set nobackup            " don't keep a backup file

set sw=4                " shiftwidth
set ts=4                " tabstop
"set tw=78               " textwidth
set tw=0
"set noet                " no expandtab but suppress tab
set cink=0{,0},:,0#,!^F,o,O,e  " cinkeys (use default including 0#)
set nows                " no wrapscan
set noai                " no autoindenting (gq formatting works better for ¶'s)

set so=2                " scroll off (always keep 2 lines of context around)
"set wh=12               " winheight (soft minimum for window height)
set noea                " equalalways off (windows don't resize on split/quit)
set sc                  " showcmd
set hls               " highlight search
set lcs=eol:¶,tab:>.,trail:_,extends:»  " listchars to show in list mode
set fileencoding=utf8
set encoding=utf8
set tenc=utf8

"============================= Key mappings
"
" None  Normal, Visual and Operator-pending
" n     Normal
" v     Visual
" o     Operator-pending
" !     Insert and Command-line
" i     Insert
" c     Command-line

mapclear

" Temporary hack to make it work on CMU machines
if has("unix") && ($OSTYPE != "linux")
    imap        <Del>   <BS>
endif

" cnoremap <Tab>  <C-L><C-D>
"cnoremap    <Tab>   <C-L>

nnoremap    <F6>    :set list!<CR>
inoremap    <F6>    <C-O>:set list!<CR>
nnoremap    <S-F6>  :set hls! \| set hls?<CR>
inoremap    <S-F6>  <C-O>:set hls! \| set hls?<CR>
nnoremap    <F5>    :set et! \| set et?<CR>
inoremap    <F5>    <C-O>:set et! \| set et?<CR>
nnoremap    <F7>    :set wrap! \| set wrap?<CR>
inoremap    <F7>    <C-O>:set wrap! \| set wrap?<CR>
nnoremap    <S-F7>  :set nu! \| set nu?<CR>
inoremap    <S-F7>  <C-O>:set nu! \| set nu?<CR>

nnoremap    ,rce    :split  $HOME/.vimrc <Bar> resize _<CR>63G
nnoremap    ,rcg    :split  $HOME/.gvimrc <Bar> resize _<CR>63G
nnoremap    ,rcu    :source $HOME/.vimrc <Bar> source $HOME/.gvimrc<CR>

"let $SKEL_DIR = $HOME . "/code/skel"

if has("unix")
    vnoremap    <F9>    :write! ~/tmp/.vim_clip<CR>
    nnoremap    <S-F9>  :read ~/tmp/.vim_clip<CR>
else
    vnoremap    <F9>    :write! /tmp/.vim_clip<CR>
    nnoremap    <S-F9>  :read   /tmp/.vim_clip<CR>
    nnoremap    ,pr     :set key= \| write d:/tmp/print/%:p:t<CR>

    " Windows doesn't support true links, so we can't fake the
    " skel directory location to be both the CVS directory and in
    " the home directory.  Have vim look at both locations.
"    if ! isdirectory($SKEL_DIR)
"        let $SKEL_DIR = "e:/cfg_files/skel"
"    endif
endif

if has("unix")
    if ($OSTYPE == "linux")
        nnoremap    ,sq     :%!cat -s<CR>
        vnoremap    ,sq     :!cat -s<CR>
    endif

    " vnoremap    ,sp     y:new<CR>p:%! ispell -a<CR>
    " nnoremap    ,sw     o---<ESC>:!echo "<cword>" \| ispell -a<CR>
    nnoremap    ,asp    Go---<ESC>:r!ispell -l < %<CR>
endif


" --- Movements (screen & buffers)
" (Many mappings are just Norm & Vis mode, no Op-Pending)

noremap     ,/      /\<\><Left><Left>
ounmap      ,/
noremap     ,?      ?\<\><Left><Left>
ounmap      ,?

nnoremap    <C-Right>   :bnext<CR>
nnoremap    <C-Left>    :bprev<CR>
nnoremap    ,bn         :bnext<CR>
nnoremap    ,bp         :bprev<CR>
nnoremap    ,bd         :BD<CR>
nnoremap    <C-Up>      <C-W>k
nnoremap    <C-Down>    <C-W>j
noremap     j       gj
ounmap      j
noremap     k       gk
ounmap      k
noremap     '       `
ounmap      '

nnoremap    ,tn     :tnext<CR>
nnoremap    ,tp     :tprev<CR>
nnoremap    ,cn     :cnext<CR>
nnoremap    ,cp     :cprev<CR>
nnoremap    ,[{     100[{z.
vnoremap    ,[{     100[{z.

nnoremap    <C-]>   g<C-]>

" --- Text Manipulation
nnoremap    <F2>    @a
noremap     <F8>    :g/^/norm 
ounmap      <F8>
" collapse consecutive empty (or tab only) lines
noremap     <S-F8>  :g/^[\t ]*$/,/[^\t ]/-j<CR>
ounmap      <S-F8>
" reverse all lines (move to line 0)
noremap     <C-F8>  :g/.*/m0<CR>
ounmap      <C-F8>

" noremap _g  :let efsave=&ef<Bar>let &ef=tempname()<Bar>exe ':!grep -n -w "<cword>" *.[ch] *.txt >'.&ef<CR>:cf<CR>:exe ":!rm ".&ef<CR>:let &ef=efsave<Bar>unlet efsave<CR><CR>:cc<CR>
"nnoremap <F3> :set noet<CR>A<< <C-R>=line(".")<CR>, <ESC>0%:let @b=line(".")<CR>%A<C-R>b >><ESC>0=%%o<ESC>j

nnoremap    ,yw     "*yiw
nnoremap    ,mif    :%s/</{/g \| %s/>/}/g<CR>
nnoremap    ,sub    :%s/\<LT>\>/<Left><Left><Left>
nnoremap    ,e      :e <C-R>=expand("%:p:h") . "/"<CR>
nnoremap    ,sp     :sp <C-R>=expand("%:p:h") . "/"<CR>

"                            |diff|
"  vi -o newfile oldfile ->  |new |
"                            |old |
map ,df   <C-W>k<C-W>j:!diff -bw -C 4 <C-R>% <C-R># > /tmp/vimtmp.dif<C-M><C-W>k<C-W>s:e! /tmp/vimtmp.dif<C-M>:!/bin/rm /tmp/vimtmp.dif<C-M><C-M>
 
" F8 : --dif file--     Makes current diff
"      --new file--     block show up in
"      --old file--     both windows
map ,dg  <C-W>k<C-W>k?^\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*$<CR>jYpdwf,DAGz<C-V><CR><Esc>"aYdd<C-W>j<C-W>j@a<C-W>k<C-W>k?^\*\*\*\*<CR>/^--- <CR>Ypdwf,DAGz<C-V><CR><Esc>"aYdd<C-W>j@a<C-W>kuuz<CR>


" --- Miscellaneous Mappings
"cnoreab     chfn    set guifont=lucida_sans_typewriter:h


"============================= Abbreviations
"
iabclear

if has("unix")
    iab         Yperl       #!/usr/bin/perl
    iab         Ytcsh       #!/bin/tcsh -f
    iab         Ycsh        #!/bin/csh -f
    iab         Ysh         #!/bin/sh -f
endif

iab         Ydat        <C-r>=strftime("%Y-%m-%d  %a")<CR>
iab         Ydate       <C-r>=strftime("%Y-%m-%d  %H:%M:%S  %a")<CR>
" iab         Ydate       <C-r>=strftime("%Y %b %d  %H:%M:%S  %a")<CR>


"============================= Autocommands
"
"   For "regular" files switch autoformatting to defaults
"   Don't change the order, it's important that the line with * comes first.

" formatoptions: (tcql default)
"   t (autowrap to textwidth)       c (autowrap comments)
"   o (ins comment on open)         r (ins comment on CR)
"   l (don't break long lines)      q (gq format comments)
"   2 (base indent on 2nd line)
au BufEnter,BufRead,BufNewFile  *   set et nosm fo=tcorql nocin com& ts=4 sw=4
au BufEnter,BufRead,BufNewFile  *   noremap ,{  :?^{??^\k.*(? mark k \| echo getline("'k")<CR>
au BufEnter,BufRead,BufNewFile  *   ounmap  ,{

" assume commented lines begin with # (we can always change this later)
au BufEnter  *  noremap     <F4>    :s@\(.*\)@# \1<CR>j
au BufEnter  *  ounmap      <F4>
au BufEnter  *  noremap     <S-F4>  :s@^\s*#\s\=\(.*\)\s*$@\1<CR>j
au BufEnter  *  ounmap      <S-F4>


au BufEnter,BufRead,BufNewFile  .Xdefaults      set et fo=tcorql com=:!
au BufEnter,BufRead,BufNewFile  .Xresources     set et fo=tcorql com=:!
au BufEnter,BufRead,BufNewFile  .cshrc          set et fo=tcorql com=:#
au BufEnter,BufRead,BufNewFile  .aliases        set et fo=tcorql com=:#
au BufEnter,BufRead,BufNewFile  .completions    set et fo=tcorql com=:#
au BufEnter,BufRead,BufNewFile  .fvwm2rc        set et fo=tcorql com=:#
au BufEnter,BufRead,BufNewFile  *.l     set sm fo=croql cin com=sr:/*,mb:*,el:*/
au BufEnter,BufRead,BufNewFile  .procmailrc     set et fo=tcorql com=n:#
au BufEnter,BufRead,BufNewFile  [Mm]akefile*        set noet fo=corq com=:#
"au BufEnter,BufRead,BufNewFile  skel.[Mm]akefile*   set noet fo=corq com=:#
au BufEnter,BufRead,BufNewFile *.csh    set noet fo=corq com=:#

"au BufNewFile  [Mm]akefile*     0read $SKEL_DIR/skel.Makefile
"au BufNewFile *.csh             0read $SKEL_DIR/skel.csh
"au BufNewFile *.sh              0read $SKEL_DIR/skel.sh
"au BufNewFile *.load            0read $SKEL_DIR/skel.load


augroup vim
    au!
    au BufEnter,BufRead,BufNewFile  .*vimrc     set et fo=tcorql com=:\"
    au BufEnter  .*vimrc    noremap     <F4>    :s@\(.*\)@" \1@<CR>j
    au BufEnter  .*vimrc    ounmap      <F4>
    au BufEnter  .*vimrc    noremap     <S-F4>  :s@^\s*"\s\=\(.*\)$@\1@<CR>j
    au BufEnter  .*vimrc    ounmap      <S-F4>
augroup END


augroup pineGrp
    au!
    au BufEnter,BufRead,BufNewFile  pico.[0-9]*     set tw=70 ts=4 sw=4 ai com=n:>,fb:- fo=tcql
    au BufLeave  pico.[0-9]*    set tw=0 ts=4 sw=4 noai
    au BufEnter  pico.[0-9]*    noremap     <F4>    :s@\(.*\)@> \1@<CR>j
    au BufEnter  pico.[0-9]*    ounmap      <F4>
    au BufEnter  pico.[0-9]*    noremap     <S-F4>  :s@^\s*>\s\=\(.*\)$@\1@<CR>j
    au BufEnter  pico.[0-9]*    ounmap      <S-F4>
augroup END


" This is a biggie autogroup for C, C++, Java
augroup cprog
    au!

    " set formatting for = command
    " *40 searches for unclosed comments up to 40 lines away for autoformatting
    " au BufEnter,BufRead,BufNewFile  *.[hcly],*.hh,*.cpp,*.cc,*.java  set sm fo=croql cin com=sr:/*,mb:*,el:*/,:// cino=t0,*40,g0

    " Temporarily adjust formatting for thesis
    au BufEnter,BufRead,BufNewFile  *.[hcly],*.hh,*.cpp,*.cc,*.java  set sw=4 ts=4 sm fo=croql cin com=sr:/*,mb:*,el:*/,:// cino=t0,*40,g2,{2,^-2,h1,>s

    " load program skeletons if available
"    au BufNewFile  *.c      0read $SKEL_DIR/skel.c
"    au BufNewFile  *.h      0read $SKEL_DIR/skel.h
"    au BufNewFile  *.cc     0read $SKEL_DIR/skel.cc
"    au BufNewFile  *.cpp    0read $SKEL_DIR/skel.cc
"    au BufNewFile  *.hh     0read $SKEL_DIR/skel.hh
"    au BufNewFile  *.java   0read $SKEL_DIR/skel.java
"    au BufNewFile  *.l      0read $SKEL_DIR/skel.l
"    au BufNewFile  *.y      0read $SKEL_DIR/skel.y
"    if has("unix")
"        au BufNewFile  *.C          0read $SKEL_DIR/skel.cc
"    endif

    " comment & uncomment C-style
    au BufEnter  *.[chly]   noremap <F4>    :s@\(.*\)@/* \1 */@<CR>j
    au BufEnter  *.[chly]   ounmap  <F4>
    au BufEnter  *.[chly]   noremap <S-F4>  :s@^\s*/\*\s\=\(.\{-}\)\s*\*/$@\1@<CR>j
    au BufEnter  *.[chly]   ounmap  <S-F4>

    " comment & uncomment C++/Java style
    au BufEnter  *.hh,*.cpp,*.cc,*.java noremap <F4>    :s@\(.*\)@// \1@<CR>j
    au BufEnter  *.hh,*.cpp,*.cc,*.java ounmap  <F4>
    au BufEnter  *.hh,*.cpp,*.cc,*.java noremap <S-F4>  :s@^\s*//\s\=\(.*\)$@\1@<CR>j
    au BufEnter  *.hh,*.cpp,*.cc,*.java ounmap  <S-F4>
    if has("unix")
        au BufEnter  *.C    noremap <F4>    :s@\(.*\)@// \1@<CR>j
        au BufEnter  *.C    ounmap  <F4>
        au BufEnter  *.C    noremap <S-F4>  :s@^\s*//\s\=\(.*\)$@\1@<CR>j
        au BufEnter  *.C    ounmap  <S-F4>
    endif

    " C programming constructs
    au BufEnter  *.[chCly],*.hh,*.cpp,*.cc,*.java  iab     Ysbl    {<ESC>o}<ESC>O 
    au BufEnter  *.[chCly],*.hh,*.cpp,*.cc         iab     Ydef    <ESC>0i#define
    au BufEnter  *.[chCly],*.hh,*.cpp,*.cc         iab     Ydeb    <ESC>0i#ifdef DEBUG<CR>#endif<ESC>O
    au BufEnter  *.[chCly],*.hh,*.cpp,*.cc         iab     Ytype   typedef
    au BufEnter  *.[chCly],*.hh,*.cpp,*.cc         iab     Yinc    <ESC>0i#include <><Left>
    au BufEnter  *.java                            iab     Yinc    <ESC>0iimport 

    au BufEnter  *.[chCly],*.hh,*.cpp,*.cc,*.java  iab     Yif     if ()<CR>{<CR>}<ESC>kk$i
    au BufEnter  *.[chCly],*.hh,*.cpp,*.cc,*.java  iab     Yelseif else if ()<CR>{<CR>}<ESC>kk$i
    au BufEnter  *.[chCly],*.hh,*.cpp,*.cc,*.java  iab     Yelse   else<CR>{<CR>}<ESC>O
    au BufEnter  *.[chCly],*.hh,*.cpp,*.cc,*.java  iab     Yfor    for (;;)<CR>{<ESC>o}<ESC>kk$F(a
    au BufEnter  *.[chCly],*.hh,*.cpp,*.cc,*.java  iab     Ywhile  while ()<CR>{<ESC>o}<ESC>kk$i
    au BufEnter  *.[chCly],*.hh,*.cpp,*.cc         iab     Ymain   int<CR>main ( int argc, char *argv[] ) <ESC>o{<ESC>o}<ESC>Oreturn 0;<ESC>O
    au BufEnter  *.[chCly],*.hh                    iab     Ypr     printf("\n");<ESC>2F"a
    au BufEnter  *.[chCly],*.hh                    iab     Yfpr    fprintf(FILE, "\n");<ESC>2F"a
    au BufEnter  *.java                            iab     Ypr     System.out.println("");<ESC>2F"a
    au BufEnter  *.cpp,*.cc                        iab     Ypr     cout << "" << endl;<ESC>2F"a
    au BufEnter  *.[chCly],*.hh,*.cpp,*.cc         iab     Yepr    fprintf(stderr, "\n");<ESC>2F"a
    au BufEnter  *.java                            iab     Yepr    System.err.println("");<ESC>2F"a
    au BufEnter  *.[chCly],*.hh,*.cpp,*.cc,*.java  iab     Yfunc   void foo(  )<CR>{<CR>}<ESC>kk$T(a
    au BufEnter  *.[chCly],*.hh,*.cpp,*.cc         iab     Yass    assert(  );<Left><Left><Left>

    au BufLeave  *.[chCly],*.hh,*.cpp,*.cc,*.java  iunab   Ysbl
    au BufLeave  *.[chCly],*.hh,*.cpp,*.cc         iunab   Ydef
    au BufLeave  *.[chCly],*.hh,*.cpp,*.cc         iunab   Ydeb
    au BufLeave  *.[chCly],*.hh,*.cpp,*.cc         iunab   Ytype
    au BufLeave  *.[chCly],*.hh,*.cpp,*.cc         iunab   Yinc
    au BufLeave  *.java                            iunab   Yinc
    au BufLeave  *.[chCly],*.hh,*.cpp,*.cc,*.java  iunab   Yif
    au BufLeave  *.[chCly],*.hh,*.cpp,*.cc,*.java  iunab   Yelseif
    au BufLeave  *.[chCly],*.hh,*.cpp,*.cc,*.java  iunab   Yelse
    au BufLeave  *.[chCly],*.hh,*.cpp,*.cc,*.java  iunab   Yfor
    au BufLeave  *.[chCly],*.hh,*.cpp,*.cc,*.java  iunab   Ywhile
    au BufLeave  *.[chCly],*.hh,*.cpp,*.cc         iunab   Ymain
    au BufLeave  *.[chCly],*.hh                    iunab   Ypr
    au BufLeave  *.[chCly],*.hh                    iunab   Yfpr
    au BufLeave  *.java                            iunab   Ypr
    au BufLeave  *.cpp,*.cc                        iunab   Ypr
    au BufLeave  *.[chCly],*.hh,*.cpp,*.cc         iunab   Yepr
    au BufLeave  *.java                            iunab   Yepr
    au BufLeave  *.[chCly],*.hh,*.cpp,*.cc,*.java  iunab   Yfunc
    au BufLeave  *.[chCly],*.hh,*.cpp,*.cc         iunab   Yass
augroup END


augroup perlprog
    au!
    au BufEnter,BufRead,BufNewFile  *.pl    set sm fo=croql cin com=:# cino=*40
"    au BufNewFile  *.pl     0read $SKEL_DIR/skel.pl
"    au FileWritePost,BufWritePost  *.pl     !chmod u+x %

    au BufEnter *.pl    noremap ,{   mk \| :?^\s*sub? print 3 \| norm `k<CR>
    au BufEnter *.pl    ounmap  ,{

    au BufEnter  *.pl   iab     Ypr  print STDOUT "\n";<ESC>2F"a
    au BufLeave  *.pl   iunab   Ypr
augroup END


augroup gzip
    " Remove all gzip autocommands
    au!

    " Enable editing of gzipped files
    " set binary mode before reading the file
    autocmd BufReadPre,FileReadPre      *.gz,*.bz2 set bin
    autocmd BufReadPost,FileReadPost    *.gz  call GZIP_read("gunzip")
    autocmd BufReadPost,FileReadPost    *.bz2 call GZIP_read("bunzip2")

    autocmd BufWritePost,FileWritePost  *.gz  call GZIP_write("gzip -9")
    autocmd BufWritePost,FileWritePost  *.bz2 call GZIP_write("bzip2 -9")

    autocmd FileAppendPre               *.gz  call GZIP_appre("gunzip")
    autocmd FileAppendPre               *.bz2 call GZIP_appre("bunzip2")

    autocmd FileAppendPost              *.gz  call GZIP_write("gzip -9")
    autocmd FileAppendPost              *.bz2 call GZIP_write("bzip2 -9")

    " After reading compressed file: Uncompress text in buffer with "cmd"
    fun! GZIP_read( cmd )
        execute "'[,']!" . a:cmd
        set     nobin
        execute ":doautocmd BufReadPost " . expand("%:r")
    endfun

    " After writing compressed file: Compress written file with "cmd"
    fun! GZIP_write( cmd )
        if rename(expand("<afile>"), expand("<afile>:r")) == 0
            execute "!" . a:cmd . " <afile>:r"
        endif
    endfun

    " Before appending to compressed file: Uncompress file with "cmd"
    fun! GZIP_appre( cmd )
        execute "!" . a:cmd . " <afile>"
        call rename(expand("<afile>:r"), expand("<afile>"))
    endfun
augroup END

"Add by Louis"
augroup easel
    " Remove all easel autocommands
    au!
    " Enable editing of easel files
    au BufEnter,BufRead,BufNewFile,BufLeave *.easel set noet
augroup END

if (version >= 503)
    comc                    " clear user defined ex commands

    " Clearcase commands
    if ($CLEARCASE_ROOT != "")
        com!    Cdesc   !cleartool desc %
        com!    Chist   !cleartool lshist % | head -20
        com!    Cvtree  !cleartool lsvtree -g % &
        com!    Cdiff   !cleartool diff -g -vst -pre -opt "-b" % &
    endif

    com!    Cdiff   !tkdiff -r HEAD "-bw" % &

    if has("unix")
        com!    Chx !chmod u+x %
        com!    Chw !chmod u+w %
    endif

    com! -range Lcount echo "Visual block = " . (line("'>") - line("'<") + 1) . "  lines"
endif

set ic
set scs
"set nu
"Double tap C-N to show/hide line number
:nmap <C-N><C-N> :set invnumber<CR>
set t_Co=256

filetype plugin indent on
"nnoremap <F8> :TlistToggle<CR>

"Color Setup
colorscheme jellybeans
hi Normal ctermbg=NONE guibg=#000000
hi CursorLine   cterm=NONE ctermbg=234 guibg=#3E3D32
hi CursorColumn cterm=NONE ctermbg=234 guibg=#3E3E32
hi CursorLineNr cterm=NONE ctermbg=208 guifg=#FD971F gui=NONE

"hi Cursor cterm=NONE ctermbg=red ctermfg=black
hi Search cterm=NONE ctermbg=yellow ctermfg=black

set cursorline cursorcolumn

"Powerline Setup
"let g:airline_theme='powerlineish'
let g:airline_theme='wombat'
let g:Powerline_symbols='fancy'
let g:airline_powerline_fonts=1
set noshowmode

"Autocomplpop Setup
let g:acp_completeOption='.,w,b,u,t,i,k'

"IDE setup"
"Type 'za' to fold a section
set foldmethod=indent
set foldlevel=99

"Fix VI Ctrl+KEY binding in tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is only
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" File template setup 
let g:email="louis.shiu@gmail.com"
let g:username='Louis Hsu'

" Useful aliases
" While forgetting to edit a file with sudo permission, run sudosave to save
cnoremap sudosave w !sudo tee % >/dev/null 

" CtrlP configuration
let g:ctrlp_show_hidden=1
"let g:ctrlp_clear_cache_on_exit = 0 
let g:ctrlp_max_files = 0 
let g:ctrlp_max_depth=40
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm|gradle|idea)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc|class)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

" Set diffopt
set diffopt=filler,vertical

" NERDTree configuration - 0625 2015
let NERDTreeShowHidden=1

" Change curor shape in different mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

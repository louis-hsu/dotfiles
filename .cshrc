#setenv TERM "xterm-color"
#setenv CLICOLOR "true"
setenv LSCOLORS deadfxdxcxegedabagacad
#setenv PATH /opt/local/bin:/opt/local/sbin/:${PATH}
#setenv MANPATH /opt/local/share/man:${MANPATH}
#setenv DISPLAY localhost:0.0
#if (! $?DISPLAY) then
#    setenv DISPLAY :0.0
#endif

# iTerm Tab and Title Customization and prompt customization
# Set the title bar and tabs of iTerm separately in tcsh
# The full path of current working directory will appear in the title bar
#
alias settitle 'echo -n "]2; "\!*""'
alias SetTitle 'settitle $HOST:r:r\:\:$cwd '
#
# The last two directories in the path will appear in the tab
# However, this is what will appear in the title bar of terminal.app
#
alias settab 'echo -n "]1; "\!*""'
alias SetTab 'settab $cwd:h:t/$cwd:t     '
#
# This dynamically updates both titles whenever you change directories
# If you use pushd and popd, alias them likewise to redefine them.
#
alias cd 'cd \!*;SetTab;SetTitle'
#
# Start the label update process on login to window
if ( $?prompt ) then
    SetTitle;SetTab
endif

#setenv LC_CTYPE zh_TW.Big5

setenv VIM_APP_DIR /Applications/Third_Party/Documenting/MacVim

set color
set autolist
set colorcat
set complete=enhance

# Hint from Marc Liyanage
#setenv SHORTHOST `echo -n $HOST | sed -e 's%\..*%%'`
#alias precmd 'printf "\033]0;%s @ $SHORTHOST\007" "${cwd}" | sed -e "s%$HOME%~%"'
#sched +0:00 alias postcmd 'printf "\033]0;%s @ $SHORTHOST\007" "\!#"'

# CVS configuration
#setenv CVSEDITOR "vim"
#setenv CVSROOT "/usr/local/cvsrep"

alias ls 'ls -vhGF'
alias ll 'ls -al'
alias grep 'grep --color'
# Alias
alias xterm 'xterm -geometry 100x36 -bg black -fg gray -j -sb -rightbar -sl 1000 &'
#alias vim '/opt/local/bin/vim'
#alias vi 'vim'
alias gvim 'mvim'
#alias gvim '/Applications/Third\ Party\ Apps/Documenting/MacVim/MacVim.app/Contents/MacOS/Vim -g'
alias ttop 'top -ocpu -R -F -s 2 -n30'
alias diff 'colordiff'
alias ssh 'ssh -Y'
#alias wireshark 'wireshark &'
alias less 'less -i'
alias updatedb 'sudo /usr/libexec/locate.updatedb'
#alias j 'autojump'
alias htcfs 'sshfs nshiu@davinci:/home/nshiu ~/RDisk/daVinci -oauto_cache,reconnect,defer_permissions,negative_vncache,volname=daVinci; cd ~/RDisk/daVinci'
alias outfs 'sshfs nshiu@raphael:/home/nshiu ~/RDisk/Raphael -oauto_cache,reconnect,defer_permissions,negative_vncache,volname=Raphael; cd ~/RDisk/Raphael'

alias uhtcfs 'cd ~/; umount ~/RDisk/daVinci'
alias uoutfs 'cd ~/; umount ~/RDisk/Raphael'

# HTC setup
#alias porthos 'ssh -Y nshiu@10.9.90.136'
#alias 3dsproject 'ssh -Y administrator@3ds-project'
#alias gb20test 'ssh -Y gb20@10.9.27.6'

##
# Your previous /Users/nshiu/.cshrc file was backed up as /Users/nshiu/.cshrc.macports-saved_2010-11-03_at_23:18:00
##

# Android SDK path -- Louis 2011/0420
setenv PATH ${PATH}:/Users/nshiu/Applications/ADT/sdk/tools:/Users/nshiu/Applications/ADT/sdk/platform-tools
alias ddms 'ddms &'

# For autojump -- Louis 2013/0412
#[ -s /usr/local/Cellar/autojump/21.1.2/etc/autojump.sh ] && sh /usr/local/Cellar/autojump/21.1.2/etc/autojump.sh

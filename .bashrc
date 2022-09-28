# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# If this is an xterm set the title to user@host:dir 
#PS1='[\u@\h:$(p=${PWD/#"$HOME"/~};((${#p}>30))&&echo "${p::10}...${p:(-19)}"||echo "\w")]\$ '
#PS1='[\e[0;32m\u@\h\e[m:\[\e[0;34m\]$(p=${PWD/#"$HOME"/~};((${#p}>30))&&echo "${p::10}...${p:(-19)}"||echo "\w")\[\e[m\]]\$ '
PS1='\n[\e[0;32m\u@\h\e[m:\[\e[0;34m\]\w\[\e[m\]]\n\$ '
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

# Color of 'ls'
export CLICOLOR=1

case "$TERM" in
xterm|rxvt)
    export LSCOLORS=deadfxdxcxegedabagacad
    ;;
*)
    export LSCOLORS=exfxcxdxbxegedabagacad
    ;;
esac

# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#    alias ls='ls --color=auto'
#    alias grep='grep --color=auto'
#    alias fgrep='fgrep --color=auto'
#    alias egrep='egrep --color=auto'
#fi

export EDITOR=vim
export VIM_APP_DIR=/Applications/Third_Party/Documenting/MacVim

# some more ls aliases
alias ls='ls -HCGF'
alias ll='ls -ahl'
#alias la='ls -A'
#alias l='ls -CF'
alias grep='grep --color'

alias gvim='$VIM_APP_DIR/mvim'
#alias vi='vim'
alias xterm='xterm -geometry 100x36 -bg black -fg gray -j -sb -rightbar -sl 1000 &'
alias ssh='ssh -Y'
alias p4v='p4v &'
alias top='top -ocpu -R -F -s 2 -n30'
alias htop='sudo htop'
alias diff='colordiff'
export LESS=-RFX
alias less='less -I'
alias tree='tree -AC'

alias updatedb='sudo /usr/libexec/locate.updatedb'
#alias monetfs='sshfs nshiu@monet:/home/nshiu ~/RDisk/Monet -oauto_cache,reconnect,default_permissions,volname=Monet; cd ~/RDisk/Monet'
alias gitrepofs='sshfs nshiu@gitrepo:/Users/nshiu ~/RDisk/Monet -oauto_cache,reconnect,default_permissions,volname=Monet; cd ~/RDisk/Monet'
alias degasfs='sshfs nshiu@degas:/home/nshiu ~/RDisk/Degas -oauto_cache,reconnect,default_permissions,volname=Degas; cd ~/RDisk/Degas'
alias ugitrepo='cd ~/; umount ~/RDisk/Monet'
alias udegas='cd ~/; umount ~/RDisk/Degas'

alias du='du -ch -d 1'
alias time='gtime -f "\n%E elapsed,\n%U user,\n%S system,\n%M memory\n%x status"'
alias tag='/usr/local/bin/ctags'

# Copy local bashrc to remote temp
# Source remote temp bashrc while ssh
sshs() {
    #mybash=`cat ~/.bashrc`
    #ssh -t ${*:1} "echo $mybash > /tmp/.bashrc_temp ; bash --rcfile /tmp/.bashrc_temp ; rm /tmp/.bashrc_temp"
    ssh ${*:1} "cat > /tmp/.bashrc_temp" < ~/.bashrc
    ssh -t ${*:1} "bash --rcfile /tmp/.bashrc_temp ; rm /tmp/.bashrc_temp"
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f $(brew --prefix)/etc/bash_completion ]; then
#    . $(brew --prefix)/etc/bash_completion
#fi

# Android SDK path -- Louis 2011/0420
export PATH=${PATH}:~/Applications/ADT/tools:~/Applications/ADT/platform-tools:~/Applications/ADT/build-tools/21.1.1
alias ddms='ddms &'

# APK analysis tool 
alias apka='cd /Applications/Third_Party/Development/APKAnalyser; java -Xmx1024m -jar apkanalyser-5.2-exec.jar &'

# Docker setup
export DOCKER_CERT_PATH=/Users/nshiu/.boot2docker/certs/boot2docker-vm
export export DOCKER_TLS_VERIFY=1
export DOCKER_HOST=tcp://192.168.59.103:2376

# Add dex2jar into PATH -- Louis 2015/0127
export PATH=${PATH}:/Applications/Third_Party/Development/dex2jar-0.0.9.15 

# Ruby/gem configuration -- Louis 2015/0203
# Since OS X 'locks' gem packages in /Library/Ruby/Gems with root privilege, I cannot install gem packages
# with my own account unless run 'sudo', which is a bad idea
# Install rbenv instead to create private Ruby environment to fix this issue
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi 

# For tmuxinator auto completion -- Louis 2015/0203
source ~/.tmuxinator/tmuxinator.bash

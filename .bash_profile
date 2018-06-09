export ARCHFLAGS="-arch x86_64"
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin

#bind "set completion-ignore-case on"
#bind "set show-all-if-ambiguous on"
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Color of 'ls'
#export CLICOLOR=1
#export LSCOLORS=deadfxdxcxegedabagacad
#export LSCOLORS=exfxcxdxbxegedabagacad

source ~/.bashrc


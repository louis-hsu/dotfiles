#!/bin/bash
# Version: 1.0.0
# Release date: 2015/0211
# Author: Louis Hsu
# 1. If file in .dotfiles not exists in $HOME, create softlink
# 2. If file in .dotfiles exists in %HOME, delete it from $HOME and create softlink
# 3. If File in .dotfiles has softlink in $HOME, ignore
#
# Version: 1.1.0
# Release date: 2015/0311
# 1. Update script to accept .(directory), such as .task
#
# Version: 1.2.0
# Release date: 2018/0608
# 1. Only select non-dot initial files
# 2. Change ln mechanism
#
# Version: 2.0.0
# Release date: 2021/0601
# Generate/copy softlink based on OS and if it's zsh dotfile

DOTFILES_LOCATION=$HOME/.dotfiles
LISTFILE='.fileListTamp'
POSTFIX=''

createSoftLink () {
    ln -s $DOTFILES_LOCATION/$1 $HOME/$1
}

reformFileName () {
    if [[ $1 =~ .*\.${POSTFIX} ]]; then
        echo "$1" | sed -e "s/\.${POSTFIX}//g"
    else
        echo $1
    fi
}

cd $DOTFILES_LOCATION
#\ls -al --ignore='.update*' $DOTFILE_LOCATION | awk '$9 ~ /^\./ && $9 !~ /\.$/ && $9 !~ /git/ {print $9}' > $LISTFILE
\ls -Al --color=no --ignore='update*' --ignore='.*' --ignore='*md' --ignore='*old' $DOTFILE_LOCATION | awk '{if ($9) print $9}' > $LISTFILE

# Separate dotfiles for macOS (darwin) and Ubuntu (linux) -- Louis 2021/0530
if [[ "$OSTYPE" == "darwin"* ]]; then
    POSTFIX='darwin'
else
#    \ls -Al --color=no --ignore='update*' --ignore='.*' --ignore='*md' --ignore='*old' --ignore='*darwin' $DOTFILE_LOCATION | awk '{if ($9) print $9}' > $LISTFILE
    POSTFIX='linux'
fi

while read -r line
do
    newLine=`echo "$line" | sed -e "s/\.linux//g"`
    rm -rf $HOME/.$newLine # Fix ln directory issue (.task)
    if [[ ${POSTFIX} == "darwin" ]]; then
        if [[ $newLine =~ ^z.* ]]; then
            ln -s -f ~/.zprezto/runcoms/${newLine} ~/.${newLine}
        else
            ln -s -f  ${DOTFILES_LOCATION}/${line} ${HOME}/.${newLine}
        fi
     else
        ln -s -f  ${DOTFILES_LOCATION}/${line} ${HOME}/.${newLine}
    fi

#    ln -s $DOTFILES_LOCATION/$line $HOME/.$newLine
done < $LISTFILE

rm -rf $LISTFILE

cd ~/.zprezto
git submodule update --init --recursive # re-sync submodules in prezto project
cd ~

# TODO
# Install missing packages
# Configure the system as much as possible
# 1. Install/upgrade python3 and pip install packages
# 2. Manual install exa (https://the.exa.website/install/linux#manual)
# 3. Install fzf (https://github.com/junegunn/fzf) with apt
# 4. Install tpm (https://github.com/tmux-plugins/tpm)
# 5. Install tmuxinator via apt and configure tmux layout
# 6. Install ydiff https://github.com/ymattw/ydiff (change python to python3)

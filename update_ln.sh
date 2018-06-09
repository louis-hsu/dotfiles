#!/bin/sh
# Version: 1.0.0
# Release date: 2015/0211
# Author: Louis Hsu
# 1. If file in .dotfiles not exists in $HOME, create softlink
# 2. If file in .dotfiles exists in %HOME, delete it from $HOME and create softlink
# 3. If File in .dotfiles has softlink in $HOME, ignore
#
# Version: 1.1.0
# Release date: 2015/0311
# 1. Update script to accept .(directory), such as .vima
#
# Version: 1.2.0
# Release date: 2018/0608
# 1. Only select non-dot initial files
# 2. Change ln mechanism

DOTFILES_LOCATION=$HOME/.dotfiles
LISTFILE='.fileListTamp'

createSoftLink ()
{
    ln -s $DOTFILES_LOCATION/$1 $HOME/$1
}

cd $DOTFILES_LOCATION
#\ls -al --ignore='.update*' $DOTFILE_LOCATION | awk '$9 ~ /^\./ && $9 !~ /\.$/ && $9 !~ /git/ {print $9}' > $LISTFILE
\ls -Al --color=no --ignore='update*' --ignore='.*' --ignore='*md' $DOTFILE_LOCATION | awk '{if ($9) print $9}' > $LISTFILE

while read -r line
do
    rm -rf $HOME/.$line
    ln -s $DOTFILES_LOCATION/$line $HOME/.$line
done < $LISTFILE

rm -rf $LISTFILE


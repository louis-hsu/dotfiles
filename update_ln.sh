#!/bin/sh
# Version: 1.0.0
# Release date: 2015/0211
# Author: Louis Hsu
# 1. If file in .dotfiles not exists in $HOME, create softlink
# 2. If file in .dotfiles exists in %HOME, delete it from $HOME and create softlink
# 3. If File in .dotfiles has softlink in $HOME, ignore

DOTFILES_LOCATION=$HOME'/.dotfiles'
LISTFILE="fileListTamp"

createSoftLink ()
{
    ln -s $DOTFILES_LOCATION/$1 $HOME/$1
}

cd $DOTFILES_LOCATION
ls -alF $DOTFILE_LOCATION | awk '$9 ~ /^\./ && $9 !~ /\/$/ && $9 !~ /git/ {print $9}' > $LISTFILE

while read -r line
do
    if [ ! -h "$HOME/$line" ] ; then
        if [ -e "$HOME/$line" ] ; then
            rm -rf "$HOME/$line"
        fi
        createSoftLink $line
    fi
done < "$LISTFILE"

rm -rf $LISTFILE


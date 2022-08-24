#!/bin/sh

# Sync dotfiles repo and ensure that dotfiles are tangled correctly afterward
# https://systemcrafters.net/managing-your-dotfiles/using-gnu-stow/
#
# Customization to handle/create zsh* files from ~/.zprezto/runcoms
# -- Louis 2022/0823

GREEN='\033[1;32m'
BLUE='\033[1;34m'
RED='\033[1;30m'
NC='\033[0m'

# Handle dot-files with 'stow' -- Louis

# Navigate to the directory of this script (generally ~/.dotfiles/.bin)
# I put it in .dotfiles directly and ingore .sh file in stow-local-ignore
# -- Louis 2022/0823
cd $(dirname $(readlink -f $0))
cd ..

echo "${BLUE}Stashing existing changes...${NC}"
stash_result=$(git stash push -m "sync-dotfiles: Before syncing dotfiles")
needs_pop=1
if [ "$stash_result" = "No local changes to save" ]; then
    needs_pop=0
fi

echo "${BLUE}Pulling updates from dotfiles repo...${NC}"
echo
git pull # simply pull the current branch
echo

if [ $needs_pop -eq 1 ]; then
    echo "${BLUE}Popping stashed changes...${NC}"
    echo
    git stash pop -q
fi

unmerged_files=$(git diff --name-only --diff-filter=U)
if [ ! -z $unmerged_files ]; then
   echo -e "${RED}The following files have merge conflicts after popping the stash:${NC}"
   echo
   printf %"s\n" $unmerged_files  # Ensure newlines are printed
else
   # Run stow to ensure all new dotfiles are linked
   stow --dotfiles .
fi

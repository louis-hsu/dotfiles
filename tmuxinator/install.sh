#! /bin/bash -e 
# 
# Handle tmuxinator configuration
# -- Louis 2022/0929

GREENB='\033[1;32m'
BLUEB='\033[1;34m'
REDB='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

DOTFILES_PATH=$HOME/.dotfiles

echo -e "${BLUEB}-------- .tmuxinator starts${NC}"
# Install tmuxinator package if not there
if ! command -v tmuxinator >/dev/null 2>&1; then
  echo -e "${RED}Package ${REDB}tmuxinator ${RED}is not there, install the package first...${NC}"
  if [[ $(uname) = 'Darwin' ]]; then
    brew install tmuxinator
  else
    sudo nala install -y tmuxinator
  fi 
fi

# Remove existing files/directories in .dotfiles and home directory 
# 1. Remove folders which would be git-clone afterward
# None
# 2. Remove existing softlinks in home directory
for file in $(dirname $(readlink -f "$0"))/*; do 
  dfile=$(echo "$(basename "$file")")
  if [[ ${dfile} =~ ^dot\-.* ]]; then
    rm -rf ~/.$(echo ${dfile} | sed 's/^dot\-\(.*\)/\1/')
  fi 
done 

# Stow the dotfiles
# cd $(dirname $(readlink -f "$0"))
# 
# Figure it out: --dir indicate home directory of package, then followed by package directory
# Also update command to suppress error message
# https://github.com/aspiers/stow/issues/65

echo -e "${GREEN}Stow tmuxinator configuration file(s)/directory(s)...${NC}"
stow --dotfiles -v --restow --target=$HOME --dir=$DOTFILES_PATH tmuxinator 2>&1 | grep -v "BUG in find_stowed_path"

echo -e "${BLUEB}-------- .tmuxinator ends${NC}\n"

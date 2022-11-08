#! /bin/bash -e 
# 
# Handle git-related configuration files
# -- Louis 2022/1004

GREENB='\033[1;32m'
BLUEB='\033[1;34m'
REDB='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

DOTFILES_PATH=$HOME/.dotfiles

echo -e "${BLUEB}-------- .git* start${NC}"
# Install git package if not there
if ! command -v git >/dev/null 2>&1; then
  echo -e "${RED}Package ${REDB}git ${RED}is not there, install the package first...${NC}"
  if [[ $(uname) = 'Darwin' ]]; then
    brew install git
  else
    sudo nala install -y git
  fi 
fi

# 1. Install Homebrew git for macOS if not there
# 2. Git is native in Ubuntu, but still check
if [[ $(uname) = 'Darwin' ]]; then 
  if [[ ! -f /opt/homebrew/bin/git ]]; then brew install git; fi
elif ! command -v git >/dev/null 2>&1; then
  sudo nala install -y git
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
# (https://github.com/aspiers/stow/issues/65)

echo -e "${BLUE}Stow git configuration file(s)/directory(s)...${NC}"
stow --dotfiles -v --restow --target=$HOME --dir=$DOTFILES_PATH git 2>&1 | grep -v "BUG in find_stowed_path"

echo -e "${BLUEB}-------- .git* end${NC}\n"

#! /bin/bash -e 
# 
# Handle bin folder for personal scripts
# -- Louis 2022/0928

GREENB='\033[1;32m'
BLUEB='\033[1;34m'
REDB='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

DOTFILES_PATH=$HOME/.dotfiles

packageInstall() {
  package=$1

  if [[ $(uname) = 'Darwin' ]]; then
    if ! command -v $package >/dev/null 2>&1; then 
      echo -e "${RED}Package ${REDB}${package} ${RED}is not there, install the package first...${NC}"
      brew install $package 
      brew services restart $package

      # Check if $package is installed successfully
      if ! command -v $package >/dev/null 2>&1; then 
        echo -e "${REDB}${package} installation is failed, quit the process.${NC}"
        return 1 
      fi
    fi 
  fi

  return 0 
}

echo -e "${BLUEB}-------- .bin starts${NC}"
# Install sleepwatcher if not there for sleep/wakeup scripts 
# For macOS only
if [[ $(packageInstall sleepwatcher) -ne 0 ]]; then 
  exit 1
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

echo -e "${GREEN}Stow .bin configuration file(s)/directory(s)...${NC}"
stow --dotfiles -v --restow --target=$HOME --dir=$DOTFILES_PATH bin 2>&1 | grep -v "BUG in find_stowed_path"

echo -e "${BLUEB}-------- .bin ends${NC}\n"

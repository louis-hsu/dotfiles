#! /bin/bash -e 
# 
# Handle cht.sh installation 
# -- Louis 2022/1003

GREENB='\033[1;32m'
BLUEB='\033[1;34m'
REDB='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

DOTFILES_PATH=$HOME/.dotfiles

echo -e "${BLUEB}-------- cht.sh starts${NC}"
# Install cht.sh and required package 'rlwrap' if not there
if ! command -v cht.sh >/dev/null 2>&1; then
  echo -e "${RED}Package ${REDB}cht.sh ${RED}is not there, install the package first...${NC}"

  # Check if rlwrap, which is required by cht.sh, is installed
  if ! command -v rlwrap >/dev/null 2>&1; then
    if [[ $(uname) = 'Darwin' ]]; then
      brew install rlwrap 
    else
      sudo nala install -y rlwrap 
    fi
  fi
  curl -s https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh && sudo chmod +x /usr/local/bin/cht.sh
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

echo -e "${BLUE}Stow cht.sh configuration file(s)/directory(s)...${NC}"
stow --dotfiles -v --restow --target=$HOME --dir=$DOTFILES_PATH chtsh 2>&1 | grep -v "BUG in find_stowed_path"

# Rename .chtsh to .cht.sh 
#mv $HOME/.chtsh $HOME/.cht.sh

echo -e "${BLUEB}-------- .cht.sh ends${NC}\n"

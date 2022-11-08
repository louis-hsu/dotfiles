#! /bin/bash -e 
# 
# Handle vim configuration
# Already switched to nvim but just in case
#
# -- Louis 2022/1107

GREENB='\033[1;32m'
BLUEB='\033[1;34m'
REDB='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

DOTFILES_PATH=$HOME/.dotfiles

echo -e "${BLUEB}-------- .vim/.vimrc start${NC}"
# 1. Install Homebrew vim for macOS if not there
# 2. Vim is native in Ubuntu, but still check
if [[ $(uname) = 'Darwin' ]]; then 
  if [[ ! -f /opt/homebrew/bin/vim ]]; then brew install vim; fi
elif ! command -v vim >/dev/null 2>&1; then
  sudo nala install -y vim
fi 

# Remove existing files/directories in .dotfiles and home directory 
# 1. Remove folders which would be git-clone afterward
rm -rf $DOTFILES_PATH/vim/dot-vim/autoload
rm -rf $DOTFILES_PATH/vim/dot-vim/plugged 

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

echo -e "${GREEN}Stow vim configuration file(s)/directory(s)...${NC}"
stow --dotfiles -v --restow --target=$HOME --dir=$DOTFILES_PATH vim 2>&1 | grep -v "BUG in find_stowed_path"

echo -e "${BLUEB}-------- .vim/.vimrc end${NC}\n"

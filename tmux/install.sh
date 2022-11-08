#! /bin/bash -e 
# 
# Handle tmux and plugins (via tpm)
# -- Louis 2022/0928

GREENB='\033[1;32m'
BLUEB='\033[1;34m'
REDB='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

DOTFILES_PATH=$HOME/.dotfiles

echo -e "${BLUEB}-------- .tmux starts${NC}"
# Install tmux package if not there
if ! command -v tmux >/dev/null 2>&1; then
  echo -e "${RED}Package ${REDB}tmux ${RED}is not there, install the package first...${NC}"
  if [[ $(uname) = 'Darwin' ]]; then
    brew install tmux
  else
    sudo nala install -y tmux
  fi 
fi


# Remove existing files/directories in .dotfiles and home directory 
# 1. Remove folders which would be git-clone afterward
rm -rf $DOTFILES_PATH/tmux/dot-tmux/plugins

# 2. Remove existing softlinks in home directory
for file in $(dirname $(readlink -f "$0"))/*; do 
  dfile=$(echo "$(basename "$file")")
  if [[ ${dfile} =~ ^dot\-.* ]]; then
    rm -rf ~/.$(echo ${dfile} | sed 's/^dot\-\(.*\)/\1/')
  fi 
done 

# git clone tpm package if not there
if [[ ! -d $DOTFILES_PATH/tmux/dot-tmux/plugins/tpm ]]; then
  echo -e "${RED}Package ${REDB}TPM ${RED}is not there, git clone the package first...${NC}"
  git clone https://github.com/tmux-plugins/tpm $DOTFILES_PATH/tmux/dot-tmux/plugins/tpm 
fi 

# Stow the dotfiles
# cd $(dirname $(readlink -f "$0"))
# 
# Figure it out: --dir indicate home directory of package, then followed by package directory
# Also update command to suppress error message
# (https://github.com/aspiers/stow/issues/65)

echo -e "${GREEN}Stow tmux configuration file(s)/directory(s)...${NC}"
stow --dotfiles -v --restow --target=$HOME --dir=$DOTFILES_PATH tmux 2>&1 | grep -v "BUG in find_stowed_path"

# Install plugins specified in ~/.tmux.conf
# It seems tmux needs some time to source conf before tpm installing plugins
echo -e "${GREEN}Install tmux plugins via TPM...${NC}"
tmux start-server
tmux new-session -d
tmux source ~/.tmux.conf 
sleep 1
~/.tmux/plugins/tpm/scripts/install_plugins.sh 
tmux kill-server

echo -e "${BLUEB}-------- .tmux ends${NC}\n"


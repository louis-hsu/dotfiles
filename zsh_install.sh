#! /bin/bash -e 
# 
# Handle prezto and zsh dot files symlink 
#
# -- Louis 2022/0928

GREENB='\033[1;32m'
BLUEB='\033[1;34m'
REDB='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

DOTFILES_PATH=$HOME/.dotfiles

echo -e "${BLUEB}-------- .zprezto starts${NC}"

# 1. Install Homebrew zsh for macOS if not there
# 2. Zsh is native in Ubuntu, simply switch to it
# TODO 
# Make zsh check more generic instead of specific path 
if [[ $(uname) = 'Darwin' ]]; then 
  if [[ ! $(echo $SHELL) =~ ^\/opt\/homebrew.* ]]; then 
    if [[ ! -f /opt/homebrew/bin/zsh ]]; then brew install zsh; fi
    chsh -s /opt/homebrew/bin/zsh 
  fi
elif [[ ! $(echo $SHELL) =~ .*zsh ]]; then 
  chsh -s $(which zsh)
fi 

# Remove existing prezto git and re-git-clone 
rm -rf $DOTFILES_PATH/zsh/dot-zprezto
if [[ $(uname) = 'Darwin' ]]; then
  git clone --recurse-submodules -j8 git@github.com:louis-hsu/prezto.git $DOTFILES_PATH/zsh/dot-zprezto
else
  git clone --recurse-submodules -j8 -b ubuntu --single-branch git@github.com:louis-hsu/prezto.git $DOTFILES_PATH/zsh/dot-zprezto
fi 

# Create symbolic link dot-z* to runcoms/z*
cd $DOTFILES_PATH/zsh 
for file in ./dot-zprezto/runcoms/*; do 
  zfile=$(echo "$(basename "$file")")
  if [[ ${zfile} =~ ^z.* ]]; then ln -sf $file dot-${zfile}; fi 
done
 
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

echo -e "${GREEN}Stow zprezto configuration file(s)/directory(s)...${NC}"
stow --dotfiles -v --restow --target=$HOME --dir=$DOTFILES_PATH zsh 2>&1 | grep -v "BUG in find_stowed_path"

# Source the new .z* files 
# TODO
# Need to confirm the shell at this moment then run source
#source ~/.zprofile 
#source ~/.zshrc 

echo -e "${BLUEB}-------- .zprezto ends${NC}\n"

#! /bin/bash -e 
# 
# Handle task and taskopen
# TODO
# Integrate the setup of task notes created by taskopen 
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

packageInstall() {
  package=$1
  if ! command -v $package >/dev/null 2>&1; then 
    echo -e "${RED}Package ${REDB}${package} ${RED}is not there, install the package first...${NC}"
    if [[ $(uname) = 'Darwin' ]]; then 
      brew install $package 
    else
      # Need to handle different package name in Ubuntu
      case "$package" in 
        task)   sudo nala install -y taskwarrior;;
        cpanm)  sudo nala install -y cpanminus;;
      esac
    fi 

    # Check if $package is installed successfully
    if ! command -v $package >/dev/null 2>&1; then 
      echo -e "${REDB}${package} installation is failed, quit the process.${NC}"
      return 1 
    fi
  fi 
  
  return 0
}

echo -e "${BLUEB}-------- .task/.taskopen start${NC}"
# Install task if not there
if [[ $(packageInstall task) -ne 0 ]]; then 
  exit 1
fi 

# Install perl and JSON.pm which is required by taskopen 
# cpan should be covered by perl (macOS) or Ubuntu natively
if [[ $(packageInstall perl) -ne 0 ]]; then 
  exit 1
else
  # Configure Perl library location to local for better management
  if [[ ! $(perl -V | \ag PERL_MM_OPT) =~ .*perl5lib ]]; then
    PERL_MM_OPT="INSTALL_BASE=$HOME/.perl5lib" cpan local::lib
  fi 
fi 

if ! perl -e "use JSON" >/dev/null 2>&1; then 
  cpan install JSON 
fi 

# Install taskopen package if not there
if ! command -v taskopen >/dev/null 2>&1; then
  echo -e "${RED}Package ${REDB}taskopen is not there, install the package first...${NC}"
  
  # Remove taskopen.git and re-git-clone
  # Then checkout v1.1.5 since v2.0 totally ruin the workflow
  # TODO
  # 1. Migrate to taskopen 2.0 which seems with more features
  # 2. Check backward compatibility after upgrading to 2.0
  rm -rf $DOTFILES_PATH/task/taskopen.git
  git clone git@github.com:jschlatow/taskopen.git $DOTFILES_PATH/task/taskopen.git
  cd $DOTFILES_PATH/task/taskopen.git
  git checkout v1.1.5
  
  # Build taskopen
  # Need 'sudo' to install to /usr/local/bin with man page
  sudo make install
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

echo -e "${BLUE}Stow task/taskopen configuration file(s)/directory(s)...${NC}"
stow --dotfiles -v --restow --target=$HOME --dir=$DOTFILES_PATH task 2>&1 | grep -v "BUG in find_stowed_path"

# Sync tasks from server
task sync
echo -e "${GREENB}Don't forget to handle directory 'tasknotes' for 'taskopen'${NC}"
echo -e "${BLUEB}-------- .task/.taskopen end${NC}\n"

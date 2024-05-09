#! /bin/bash -e 
# 
# Main script to handle all dot-files installations, including:
# 1. Prerequisite check
# 2. Brew formulas installation
# 3. Submodules check/update
# 4. Symbolic link creation
# 5. Untracked repositories clone
# -- Louis 2024/0506

##########################################################
# Definitions
##########################################################

# Colors
readonly GREENB='\033[1;32m'
readonly BLUEB='\033[1;34m'
readonly YELLOWB='\033[1;33m'
readonly REDB='\033[1;31m'
readonly WHITEB='\033[1m'
readonly GREEN='\033[0;32m'     # Green      │ Successful result
readonly BLUE='\033[0;34m'      # Blue       │ Lines, bulletin and separators
readonly YELLOW='\033[0;33m'    # Yellow     │ Emphasis
readonly RED='\033[0;31m'       # Red        │ Failed or alert
readonly GREY='\033[0;90m'      # Grey       │ Credits or description
readonly NC='\033[0m'           # Color reset

readonly BLUE_LINE="${BLUE}\
─────────────────────────────────────────────────────────────────────────────────────\
${NC}"

# System info
readonly _DOTFILES_PATH=$HOME/.dotfiles

##########################################################
# Helpers
##########################################################

# Print out description with the same length (85)
# The gap would be repalced by white space
function _descriptionPrint () {
  local _m=$1
  local _mlength=${#_m} 
  local _gap=$(echo "85 - ${_mlength}" | bc)

  for (( i=1; i <= ${_gap}; i++ )); do 
    _m="${_m} "

  done
  #echo -e "${GREY}${_m}${NC}\c"
  echo -e "${_m}\c"
}

# Result/message printing function 
# Globals: None
# Arguments:
#   $1 0:OK   1:FAILED  2:INFO  3:NOTICE
#   $2 message
# Returns: None
function _rmessagePrint () {
  local result=$1
  local message=$2

  case $result in 
    0) #OK
      echo -e "${GREY}[${NC}${GREEN}  OK  ${NC}${GREY}]${NC}"
      ;;
    1) #Failed
      echo -e "${GREY}[${NC}${RED}Failed${NC}${GREY}]${NC}"
      ;;
    2) #Info 
      echo -e "${GREY}[${NC}${YELLOW} Info ${NC}${GREY}]${NC}"
  esac
  
  if [ -n "${message}" ]; then
    echo -e "${YELLOW}${message}${NC}"
  fi
}

# Compare 2 directories: ~/.$D and $_DOTFILES_PATH/dot-$D 
# And cp extra files in $D to dot-$D 
# Then rm $D
function _dirComp () {
  local _d=$1
  local _dotd="dot-${_d}"


}

##########################################################
# Main process
##########################################################

echo -e "${BLUE}\
┌───────────────────────────────────────────────────────────────────────────────────┐
│                    ${BLUEB}macOS Environment (zsh/Apps) Configuration${BLUE}                     │
│                                                                                   │
│ Following items are not covered in the configuration script:                      │
│ 1. 'ssh' public/private keys are not tracked in the git repository                │
│ 2. 'xcode-select' installed manually in advance is required                       │
│    (https://developer.apple.com/download/more/                                    │
│ 3. '/etc/hosts' is not tracked in the git repository                              │
│ 4. Switch to brew 'zsh after configuration is done successfully                   │
│    ('chsh -s /opt/homebrew/bin/zsh')                                              │
└───────────────────────────────────────────────────────────────────────────────────┘
${NC}"

##########################################################
# 1. Prerequisites check
# - The script is in _DOTFILES_PATH
# - 'git', 'homebrew' are installed and current shell is 'zsh'
# - The git repository is latest pulled
##########################################################
echo -e "${BLUE_LINE}"
echo -e "${WHITEB}1. Prerequisite checking${NC}\n"

_descriptionPrint "○ If 'zsh' is the current shell?"
if [[ $(echo -e "${SHELL}") =~ "zsh" ]]; then  
  _rmessagePrint 0

else 
  _rmessagePrint 1 "Change current shell to 'zsh' manually then run the script again"
  exit 1
fi

_descriptionPrint "○ If installation script is in ${_DOTFILES_PATH}?"
if [ "${_DOTFILES_PATH}" = $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) ]; then
  _rmessagePrint 0

else
  _rmessagePrint 1 "Installation script is not in ${_DOTFILES_PATH}, quit the configuration process"
  exit 1

fi

_descriptionPrint "○ If 'homebrew' is installed?"
# By default 'brew' might not in $PATH yet
if command -v /opt/homebrew/bin/brew > /dev/null 2>&1; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:${PATH}"
  _rmessagePrint 0

else # 'homebrew' is not there, install 'brew' 
  _rmessagePrint 2 "'brew' is not there, start Homebrew installation process...."
  
  echo -e "${GREY}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo -e "${NC}"
  
  if command -v /opt/homebrew/bin/brew > /dev/null 2>&1; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:${PATH}"
    echo -e "${YELLOW}'brew' installation ${GREEN}Succeeds${YELLOW}, continue the configuration${NC}"

  else
    echo -e "${YELLOW}'brew' installation ${RED}Fails${YELLOW}, quit the configuration process${NC}"
    exit 1

  fi
fi 

_descriptionPrint "○ If 'git' is installed?"
if command -v git > /dev/null 2>&1; then
  _rmessagePrint 0 

else # 'git' is not there, install 'git'
  _rmessagePrint 2 "'git' is not there, start 'git' installation process...."
  
  echo -e "${GREY}"
  brew install --quiet git 
  echo -e "${NC}"

  if command -v git > /dev/null 2>&1; then
    echo -e "${YELLOW}'git' installation ${GREEN}Succeeds${YELLOW}, continue the configuration${NC}"

  else 
    echo -e "${YELLOW}'git' installation ${RED}Fails${YELLOW}, quit the configuration process${NC}"
    exit 1

  fi 
fi 

_descriptionPrint "○ If this is the git repository with the latest commit?"
if git rev-parse --git-dir > /dev/null 2>&1; then
  git fetch
  # Determine current branch
  _cbranch=$(git rev-parse --abbrev-ref HEAD)
  
  # Check if the current branch is up to date with its upstream
  _lhead=$(git rev-parse HEAD)
  _rhead=$(git rev-parse @{u})  # Assumes there is an upstream set
  
  if [ "${_lhead}" = "${_rhead}" ]; then
    _rmessagePrint 0
  else
    _rmessagePrint 1 "Local repository is not up to date, manual update is required, quit the configuration process"
    exit 1

  fi
else
  _rmessagePrint 1 "Not a git repository, quit the configuration process"
  exit 1

fi

##########################################################
# 2. Brew formulas installation
# (~/.dotfiles/dot-config/homebrew/Brewfile)
##########################################################
echo -e "\n${BLUE_LINE}"
echo -e "${WHITEB}2. Brew formulas installation${NC}"

echo -e "${GREY}"
brew bundle install --file ~/.dotfiles/dot-config/homebrew/Brewfile
echo -e "${NC}"

_descriptionPrint "○ Install formulas based on '~/.dotfiles/dot-config/homebrew/Brewfile'"
if [ $? != 0 ]; then
  _rmessagePrint 1 "'brew bundle install' fails, quit the configuration process"
  exit 1

else 
  _rmessagePrint 0 

fi

##########################################################
# 3. Submodules check/update
# Just in case the submodules are not cloned/update when cloning 
# git 'dotfiles'
##########################################################
echo -e "\n${BLUE_LINE}"
echo -e "${WHITEB}3. Submodules checkout and/or update${NC}"

# TODO:
# All submodules are synced to the latest commit instead of branch
# Adding 'branch' in '.gitmodules' seems not working
# However stuffs work but just not pretty when running 'git status'
# Print out the message for now
cd $_DOTFILES_PATH
echo -e "${GREY}"
git submodule update --init --recursive
echo -e "${NC}"

_descriptionPrint "○ 'git submodule update --init --recursive' to checkout/update submodules"
if [ $? != 0 ]; then
  _rmessagePrint 1 "'git' command fails, quit the configuration process"
  exit 1
else 
  _rmessagePrint 2 "Notice: 'git' command follows the latest commit instead of branch. \
User needs to adjust to expected branch manually" 
fi

##########################################################
# 4. Symbolic link creation
# - dot links in '.dotfiles'
# - dot links from '.zprezto/runcoms'
##########################################################
echo -e "\n${BLUE_LINE}"
echo -e "${WHITEB}4. Symbolic links creation and update${NC}\n"

# Create symbolic link dot-z* from runcoms/z*
cd $_DOTFILES_PATH/dot-config/zsh 
for _f in ./.zprezto/runcoms/*; do 
  _zf=$(echo "$(basename "${_f}")")
  if [[ ${_zf} =~ ^z.* ]]; then ln -sf ${_f} .${_zf}; fi 
done

_descriptionPrint "○ Create softlinks from '.zprezto/runcoms' to 'zsh' in '~/.dotfiles/dot-config'"
_rmessagePrint 0

# 1. Enumerate "dot-$D" directories in $_DOTFILES_PATH 
# 2. if ".$D" exists in $HOME, rsync -av --ignore-existing .$D dot-$D
#    (preserve files only in .$D to dot-$D, and ignore files existing in both directories)
# 3. Delete .$D and create softlinks from $_DOTFILES_PATH
#
# 'stow' doesn't work in current '.dotfiles' folder structure:
# 1. Directory '$DIR' pointed by '-t' and '-d' cannot be the same
# 2. Parameter '$PACKAGE', which is the directory containing files/directories to be stowed,
# is required
# Write a simple function to replace 'stow'
#stow --dotfiles -v --restow --target=$HOME --dir=$DOTFILES_PATH zsh 2>&1 | grep -v "BUG in find_stowed_path"

function _myStow () {
  local _target=$1
  local _dest=$2 
  
  if [ ! -d ${_target} ] && [ ! -d ${_dest} ]; then 
    echo -e "Only accept directories as the parameters"
    return 1

  fi

  for _f in ${_target}/*; do 
    _tdotf=$(echo "$(basename "${_f}")")

    if [[ "${_tdotf}" =~ ^dot\-.* ]]; then
      _ddotf=".$(echo ${_tdotf} | sed 's/^dot\-\(.*\)/\1/')"

      if [ -e ${_dest}/${_ddotf} ]; then
        if [ -d ${_dest}/${_ddotf} ]; then 
          if [ -L ${_dest}/${_ddotf} ]; then
            _link_target=$(readlink -f "${_dest}/${_ddotf}")

            if [ "${_link_target}" != "${_target}/${_tdotf}" ]; then
              #echo -e "${_link_target} : ${_target}/${_tdotf}"
              rsync -av --ignore-existing ${_dest}/${_ddotf}/ ${_target}/${_tdotf}/

            fi
          else
            rsync -av --ignore-existing ${_dest}/${_ddotf}/ ${_target}/${_tdotf}/
            
          fi
        fi
        rm -rf ${_dest}/${_ddotf}

      fi
      ln -sf ${_target}/${_tdotf} ${_dest}/${_ddotf}

    fi
  done
  return 0
}

echo -e "${GREY}"
_myStow ${_DOTFILES_PATH} ${HOME}
_status=$?
echo -e "${NC}"

_descriptionPrint "○ Save (if applicable), delete then create softlinks to '~/' from '~/.dotfiles"
if [ ${_status} -eq 0 ]; then
  _rmessagePrint 0

else
  _rmessagePrint 1 "Something wrong when creating softlinks in '~/.', quit the process"
  exit 1
fi

##########################################################
# 5. Untracked repositories clone
# - Install and configure 'cht.sh'
##########################################################
echo -e "\n${BLUE_LINE}"
echo -e "${WHITEB}5. Handle other untracked repositories${NC}\n"

if ! command -v ~/.bin/cht.sh > /dev/null 2>&1; then
  curl -s https://cht.sh/:cht.sh | tee ~/.bin/cht.sh > /dev/null 2>&1
  chmod +x ~/.bin/cht.sh
fi

_descriptionPrint "○ Install 'cht.sh' from original remote repository"
if command -v ~/.bin/cht.sh > /dev/null 2>&1; then
  _rmessagePrint 0 

else # 'cht.sh' is not there
  _rmessagePrint 1 "'cht.sh' is not there, quit the process"

fi

##########################################################
# 6. Perl modules configuration
#
# TODO:
# Might have other module configuration from other languages (ruby, e.g.)
# in the future
#
##########################################################
echo -e "\n${BLUE_LINE}"
echo -e "${WHITEB}6. Install Perl module (local::lib) for local Perl module management${NC}\n"

echo -e "${GREY}"
cpanm local::lib
# This would fail since perl path is not set yet
# Ignore the check for now
#_status=$(perl -Mlocal::lib -e 'print "local::lib is installed"')
echo -e "${NC}"

# Remove ~/perl5 created during module installation 
# The path has been configured in .zshrc (~/.perl5lib)
if [ -d ~/perl5 ]; then rm -rf ~/perl5; fi

_descriptionPrint "○ Install Perl module (local::lib) by using 'cpanm'"
_rmessagePrint 0 

##########################################################
# Notice after successful configuration
# 1. Switch to brew 'zsh' and restart the session
#    ('chsh -s /opt/homebrew/bin/zsh')
# 2. Download 'iTerms' and configure location of 'Preferences'
#    (/Users/nshiu/.dotfiles/dot-config/iterm2)
##########################################################
echo -e "\n${BLUE_LINE}"
echo -e "${BLUE}\
┌───────────────────────────────────────────────────────────────────────────────────┐
│                 ${BLUEB}Actions after configuration is done successfully${BLUE}                  │
│                                                                                   │
│ Following actions need to be run manually after configuration:                    │
│ 1. Switch to brew 'zsh after configuration is done successfully                   │
│    ('chsh -s /opt/homebrew/bin/zsh')                                              │
│ 2. Setup 'ssh' public/private keys if not there yet                               │
│ 3. Install 'iTerm2' and setup the location of 'Preferences' as below              │
│    - Setup 'Preferences' location to '/Users/nshiu/.config/iterm2'                │
│    - Import 'Profiles' backup from the same place                                 │
└───────────────────────────────────────────────────────────────────────────────────┘
${NC}"



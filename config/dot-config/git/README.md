# Git configuration
Repository of git configuration files:

1. config for current user
2. ignore as global git ignore filetypes
3. stCommitMsg as glboal commit message template

## Update history

#### 2024/0312
1. Change structure/location of folders and names of files to cooperate the adoption of $XDG_CONFIG_HOME ($XDG_CONFIG_HOME/git as home directory of git configurations)
2. No 'stow' required, move '.stow-local-ignore' and 'install.sh' to '_obsolete'

#### 2022/1128
1. Refactor install.sh to ditch redundant code
2. Revise README.md 

## TODO

#### 2024/0312
'git-config' doesn't accept/expand environment variable ($XDG_CONFIG_HOME, e.g.) to path, but has to specify the path explicitly.
Need to fix it for more flexibility.

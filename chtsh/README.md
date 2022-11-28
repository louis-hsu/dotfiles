# Cheatsheet 'cht.sh' installation
Cheatsheet 'cht.sh' installation which would occupy one tmux pane in default tmuxinator template. The reason to use 'cht.sh' instead of 'cheatsheets':

1. Don't want to install too many gits (included as submodule?)
2. Networking should not be the issue now

although the theme still has some issues (the gray background of comment, but it seems happen to all themes).

As for configuration file 'cht.sh.conf', decide to put it in the default path (~/.cht.sh) instead of other place by declaring environment variable 'CHTSH_CONF'

Github: [https://github.com/chubin/cheat.sh](https://github.com/chubin/cheat.sh) 

## Update history

#### 11/25/2022
1. Create README.md 
2. Remove 'history' from git and by editing .gitignore
3. Install cht.sh in ~/.bin instead of /usr/local/bin to avoid 'sudo' requirement

## TODO

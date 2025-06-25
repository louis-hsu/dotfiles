1. Based on terminfo 'screen-256color' to create new terminfo to support italic
   font type

```
vim screen-256color-italic.terminfo;
screen-256color-italic|tmux with 256 colors and italic,
  use=screen-256color,
  sitm=\E[3m,
  ritm=\E[23m,
```

2. Use ’tic’ to recompile the new terminfo file, save to specific place and install to system terminfo database

```
tic -o $XDG_CONFIG_HOME/terminfo ~/screen-256color-italic.terminfo
```

3. Update .zprofile with $TERMINFO_DIRS as:

```
export TERMINFO_DIRS="$XDG_CONFIG_HOME/terminfo:/opt/homebrew/Cellar/ncurses/6.5/share/terminfo:/usr/share/terminfo"
```

4. Run ‘infocmp $TERM’ to ensure new terminfo is set


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
tic -x -o ~/.terminfo ~/screen-256color-italic.terminfo
```

3. Run ‘infocmp -v2 $TERM’ to ensure new terminfo is set


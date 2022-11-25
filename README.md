# Dotfiles
My shell (zsh) and applications configuration dotfiles managed by shell scripts and stow

Github URL: https://github.com/louis-hsu/dotfiles

## Update History

#### Nov 09, 200
Change the whole structure of dotfiles management
1. Introduce 'stow' with corresponding shell scripts 
2. Focus on macOS first
3. Different platforms are handled by different branches

TODO
1. Applications installation via homebrew (macOS) and nala (Ubuntu)
2. Handle .config directory

#### Aug 22, 2022
Haven't transferred to 'stow' yet, need to confirm:
1. If new stow still cannot handle symbolic links in the stow directory
2. Need to use Ubuntu box for experiment first

#### Feb 20, 2022
Use stow to manage dotfiles management and symlink
1. Rename dotfile file name with 'dot-' prefix, e.g .zshrc -> dot-zshrc
2. Use command 'stow --dotfiles' to preprocess 'dot-' files
3. However, currently stow cannot handle symlink files with warning "source is an absolute symlink". So have to create symlinks separately for .zprezto/runcoms

#### June 26, 2015 
1. Reinstall MacVim via Homebrew to get more active version update, and updae .zshrc accordingly
2. Move unused Vim plugin to new folder "unbundle" 
3. Update .vimrc:
  * Change email configuration for vim-template
  * Update configuration of vim-ctrlp
  * Remove vim-expand-region
  * Update configuration of vim-NERDTree

Next step is to clean .vimrc and update vimscript

#### May 28, 2015 09:21
Install VIM plugin "vim-expand-region" to enhance V selection behavior. Update .vimrc accordingly

#### May 27, 2015 16:46
Initial record of current status (10.10.3)


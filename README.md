# dotfiles
My dotfiles for shell and application configuration (except dotfile for zsh, which are included in prezto git)

## MacBook update History
<br />
MacBook update/installation history in case system reset/reinstallation in the future
######Aug 22, 2022
Haven't transferred to 'stow' yet, need to confirm:
1. If new stow still cannot handle symbolic links in the stow directory
2. Need to use Ubuntu box for experiment first

######Feb 20, 2022
Use stow to manage dotfiles management and symlink
1. Rename dotfile file name with 'dot-' prefix, e.g .zshrc -> dot-zshrc
2. Use command 'stow --dotfiles' to preprocess 'dot-' files
3. However, currently stow cannot handle symlink files with warning "source is an absolute symlink". So have to create symlinks separately for .zprezto/runcoms

######June 26, 2015 
1. Reinstall MacVim via Homebrew to get more active version update, and updae .zshrc accordingly
2. Move unused Vim plugin to new folder "unbundle" 
3. Update .vimrc:
  * Change email configuration for vim-template
  * Update configuration of vim-ctrlp
  * Remove vim-expand-region
  * Update configuration of vim-NERDTree

Next step is to clean .vimrc and update vimscript

######May 28, 2015 09:21
Install VIM plugin "vim-expand-region" to enhance V selection behavior. Update .vimrc accordingly

######May 27, 2015 16:46
Initial record of current status (10.10.3)


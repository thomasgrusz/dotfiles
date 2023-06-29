# dotfiles
These dotfiles are written for Unix compatible systems.
Copy the ones you would like to use into your home directory.

Enable aliases in **.bash_aliases**
- add the following line to your .bashrc file: **source ~/.bash_aliases**
- copy the **.bash_aliases** file to your home directory

Enable git support for your bash session
- add the following line to your .bashrc file: **source ~/.bash_git_setup**
- copy **.bash_git_setup**, **.git-completion.bash**, **.git-prompt.sh**, and **.gitconfig** to your home directory

Enable vim customizations
- copy the **.vim/** folder, **.vimrc**, and **.vimrc.plug** files to you home directory
- start vim and run the command :PlugInstall
- to updated the plugins, regularly run :PlugUpdate
- to update the plugin-manager run :PlugUpgrade

All files can be used for Linux and Mac, except for the ones in the mac_workstations folder, which are for my Apple workstation.

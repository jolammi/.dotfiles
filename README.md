# .dotfiles
The dotfiles and also some notes to set up a new system from scratch with less work.

## Important files and folders for machine-specific stuff
`.local_confs`: set machine-specific settings, env variables etc here  
`bin/`: put machine-specific scripts here  
`.tmux.conf.local`: set machine-specific keybindings here  
`.zprofile.local`: set machine-specific profile stuff here  
  

## Initialization
### Checklist of other tools
- Docker and Docker Compose, if they can be used in the organization. Otherwise install the required alternative  
- Install zsh if it is not already installed.  
  - https://askubuntu.com/a/131838/1195630: `chsh -s $(which zsh)` (should also work on macOS)  
- VS Code  
- A good terminal emulator  

### Before cloning to a new machine
- Install a nerd font for ligatures and p10k to work, e.g. Fira Code Nerd Font https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode  
- `fd` is needed for some of the stuff. Install by hand from package manager.  
### After cloning
- `fzf` needs manual installation with ~/.fzf/install in order to work  
### Basic setup
When cloning onto a new machine:  
```
git clone --bare git@github.com:jolammi/.dotfiles.git .dotfiles
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
git --git-dir=$HOME/.dotfiles --work-tree=$HOME submodule init
git --git-dir=$HOME/.dotfiles --work-tree=$HOME submodule update --remote --merge
```

After the basic setup, the `gitdf` command should be available in the home folder, to use git with dotfiles effectively.
### Git 
Set Git identity to new machine for the dotfiles repo:  
```
gitdf config --local user.name "Jouni Lammi"
gitdf config --local user.email "..."

```
For other repos, there is a function in `.custom_zsh/aliases.zsh` to set up the identity. Different identities may be needed
for different emails and remotes (work, personal github, ...):  
```bash
setlocalgitidentity () {
        git config --local user.name ${1}
        git config --local user.email ${2}
}
```  
Usage: `setlocalgitidentity "Jouni Lammi" "email"`  
ZSH autocompletion will likely keep this handy so it doesn't need to be typed out every time.

You can also create specific commands to e.g. `.local_confs` to set the identity without parameters, e.g.  
```
setlocalgitidentity_personal () {
        git config --local user.name "Jouni Lammi"
        git config --local user.email "email"
}
```  
## Disclaimer
The basic layout and some of the scripts are borrowed from Sami Harju's dotfiles, https://github.com/samharju/.dotfiles.

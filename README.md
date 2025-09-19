# .dotfiles
The dotfiles and also some notes to set up a new system from scratch with less work.  
They are made for Ubuntu. Mileage may vary in other systems, especially non-Debian.  
These exist primarily for my own sanity. However, if they are useful to you, feel free to use!  

## Important files and folders for machine-specific stuff
`.local_confs`: set machine-specific settings, env variables etc here  
`bin/`: put machine-specific scripts here  
`.tmux.conf.local`: set machine-specific keybindings here  
`.zprofile.local`: set machine-specific profile stuff here  
  

## Initialization
### Checklist of other tools
- Docker and Docker Compose, if they can be used in the organization. Otherwise install the required alternative  
  - Remember to do any custom docker configuration if needed (mirrors, logging defaults, authentication tokens etc.) 
- Install zsh if it is not already installed
  - https://askubuntu.com/a/131838/1195630: `chsh -s $(which zsh)` (should also work on macOS)  
- VS Code  
- A good terminal emulator, wezterm is nice and cross-platform

### Before cloning to a new machine
- Install a nerd font for ligatures and p10k to work, e.g. Fira Code Nerd Font https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode  
- `fd` and `tree` are needed for some of the stuff. Install by hand from package manager.
- Ensure that system proxies are set to shell, if behind a proxy.
- If needed, set `git config --global http.proxy <proxy>`

### Cloning
Run the following commands. `dotfiles` command is persisted in the dotfiles setup.
```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare git@github.com:jolammi/.dotfiles.git .dotfiles
dotfiles checkout
dotfiles submodule update --init --recursive
```

### After cloning
- `fzf` needs manual installation with ~/.fzf/install in order to work  
- Create the symlink to `~/.local/bin` like instructed in https://github.com/sharkdp/fd?tab=readme-ov-file#on-ubuntu
- Install taskfile with `utils/install-taskfile-linux.sh`
- Build tmux with `task tmux`
  - When not doing this, I noticed that the `tmux_sessionizer` script could not use `fd` due to `fd` missing from path.
  - One fix was to symlink fd to `/usr/local/bin` but building with `task tmux` and refreshing shell session worked so I did not end up doing that.
- Lazygit is included as a submodule, ensure go is installed and run go install 
  - Install Lazygit from https://github.com/jesseduffield/lazygit/tree/master?tab=readme-ov-file#go

- create a .dotfileconfig file to use the tmux-sessionizer properly, e.g.:
`export DOTFILES_GIT_REPOS_DIR=$HOME/repos/`


### Git 
No global git user email exists in this repo because I use this repo on multiple machines, work and personal.
After cloning a repo, set the correct name and email with the helper functions in `.custom_zsh/aliases.zsh`.

Set Git identity to new machine for the dotfiles repo:  
```
setlocalgitidentity_dotfiles "Name" "email"
```

For other repos, use
```
setlocalgitidentity "Name" "email"
```

ZSH autocompletion is enabled in the config, and will keep this handy so it doesn't need to be typed out every time.

Of course you can also create specific commands to e.g. `.local_confs` to set the identity without parameters, e.g.  
```
setlocalgitidentity_personal () {
        git config --local user.name "Jouni Lammi"
        git config --local user.email "myworkemail"
}
```  
## Thanks
The basic layout and some of the scripts are borrowed from Sami Harju's dotfiles, https://github.com/samharju/.dotfiles.

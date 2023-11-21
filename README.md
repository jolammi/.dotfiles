# .dotfiles

## Important files
`.local_confs`: set machine-specific settings, env variables etc here  
`bin`: put machine-specific scripts here  
`.tmux.conf.local`: set machine-specific keybindings here  
`.zprofile.local`: set machine-specific profile stuff here  
  
## Initialization
When cloning onto a new machine:
```
git clone --bare git@github.com:jolammi/.dotfiles.git .dotfiles
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
git --git-dir=$HOME/.dotfiles --work-tree=$HOME submodule init
git --git-dir=$HOME/.dotfiles --work-tree=$HOME submodule update --remote --merge
```

## Notes
- `fd` is needed for some of the stuff. Install by hand from package manager.
- `fzf` needs manual installation with ~/.fzf/install in order to work

## Disclaimer
The basic layout and some of the scripts are borrowed from Sami Harju's dotfiles, https://github.com/samharju/.dotfiles.

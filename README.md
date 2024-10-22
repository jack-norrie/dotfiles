# dotfiles

## Description
The purpose of this repository is to serve as a record of my development environment, i.e. programs I use for development alongside their configurations. This will allow me to move between my various computers, while maintaining a relatively consistent workflow. The main piece of software which makes this possible is GNU Stow, which allows me to symlink the dotfiles in this repository to the their corresponding counterparts in my home directory.

## System Settings
### American Keyboard Layout
For the purpose of programming, having the hash symbol # be displaced by the pound sign £ is inconvenient. I find the american layout much easier for the purpose of typing commonly encountered symbols when programming.

### CAPS-LOCK to ESCAPE
When using proper typing technique, the CAPS-LOCK key is a redundant key. Which is a shame since by default it takes a position in the keyboard which is very accessible, i.e. close to the home row. For this reason I rebind it to a more useful and frequently used key. For me, escape is the best candidate for this remapping, since this is a key I frequently use when performing vim motions.

## Software Config
### Using GNU Stow to Setup Symlinks 
clone this repository into your home directory. Then install GNU stow and use it to create a symlink between the dotfiles in this repository and their counterparts in your homedirectory. This can be achieved by changing into the dotfiles directory and running stow on the directory:
```
cd dotfiles
stow .
```

If this has been sucesful then you will be able to run `ls -lah` on your home directory and there should be symlinks (indicated with ->) in your home directory pointing at the config dotiles in the dotfiles directory. 

Finally, if there are any files you do not want to be symlinked to your home directory you should specify them in a `.stow-local-ignore` file. There are some sensible file types, like `.git` and `README.md`, that are exluded by deafault. However, if you make your own ignore file you will have to add these back in. 

### Adding New Confgis 
The preeding has downloaded all the software config files from this repo and added links in your system home directory to them. However, what if you want to add a config you have been using locally into the repo. In this case if we copy the file into our dotfiles repo and try to run `stow .` we will get an error. This is because a file already exists in the location where a symlink is trying to be established. This can be fixed by either removing this file or adding the following flag to the stow command. 
```
stow --adopt .
```
The adopt flag will overwrite any existing files that might already exist in your home directory with a symlink to their counterpart in the dotfiles repo.

## Software
The following software are roughly listed in the order in which they should be installed. 

### Terminal Emulator - WezTerm
I use wezterm as my terminal eumlator. It uses true colour and by default comes with a nerd-font installed and used by default (jetbrains-mono), meaning that it can immediately benefit from terminal cosmetic upgrades. Furthermore, it has good compatability across different operating system and is configured with lua, meaning it is easily extendable.

### Shell - Zsh
This environemnt is setup with a `zsh` shell in mind. You can check if this is your default shell using `echo $SHELL`. If this is not the default shell of your operating system use the following commands:
```
sudo apt install zsh
chsh -s $(which zsh)
```
Then restart your system. After which, if you do not already have a `zshrc` dotfile in your homedirectory, you will be prompted to configure one.

If you have already stowed this repo into your home directory then you will have a `.zshrc` config file in your homedirectory. Your zsh shell should now be using a powerlevel10k configured prompt.

### Basic Terminal Utilities
* neofetch - retrieves system information.
* tree - visualisation of a directory.
* fzf - fuzzy finding - use the github insall for newest version.

### Version Control - Git
I use git for version control. With git installed you can clone this repository and follow the steps in the previous main heading regarding getting software configs.


### Text Editor - Neovim (LazyVim)
My choice of text editor is neovim. I currently use the LazyVim distribution, rather than configuring the whole thing from scratch.

### Terminal Multiplexer
[placeholder]

### Tiling Window Manager
[placeholder]


## Further-Work
At some point I would like to experiment with nix-os (for linux) and nix-darwin (for mac), this would automate the system settings and software versioning portition of this development environment setup.


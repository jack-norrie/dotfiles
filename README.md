# dotfiles

## Description

The purpose of this repository is to serve as a record of my development environment, i.e. programs I use for development alongside their configurations. This will allow me to move between various machines, while maintaining a relatively consistent workflow. The main piece of software which makes this possible is GNU Stow, which allows me to symlink the dotfiles in this repository to the their corresponding counterparts in my home directory.

## Operating System

I mainly program for applications in machine learning, and as such I need an operating system and development environment with good support for Nvidia GPUs. Furthermore, I make use of a lot of FOSS and as such prefer a UNIX based OS. Hence, the most suitable OS for me is Linux when using a GPU and potentially MacOS otherwise. My goto for a Linux OS is Pop!_OS, due to its out of the box Nvidia driver support. However, this being an Ubuntu based distro means the package managed software is often out of date. For this reason it is highly recommended to install the following packages such that you can build some packages from source, although beware that when doing this you are trading cutting edge features for system stability in some cases:

```
sudo apt-get install ninja-build gettext cmake unzip curl build-essential
```

Conversely the MacOS package manager homebrew typically has relatively upto date software and as such the above should not be necessary. Furthermore, there exist more bleeding edge Linux distributions like Arch based distros which have more up to date packages. However, building a handful of packages from source is not laborious for me to take on the increased instability risks when using such a distro. I might consider it when Wayland gets better Nvidia support, as this would allow me to try out Hyprland, which is a good looking tiling window manager that works particularly well on Arch based distros.

## System Settings

### American Keyboard Layout

For the purpose of programming, having the hash symbol # be displaced by the pound sign £ is inconvenient. I find the American layout much easier for the purpose of typing commonly encountered symbols when programming.

### CAPS-LOCK to ESCAPE

When using proper typing technique, the CAPS-LOCK key is a redundant key. Which is a shame since by default it takes a position in the keyboard which is very accessible, i.e. close to the home row. For this reason I rebind it to a more useful and frequently used key. For me, escape is the best candidate for this remapping, since this is a key I frequently use when performing vim motions. This can easily be done with gnome-tweaks on Linux and in the system settings on MacOS

### Single-Display

When using a laptop I often plug it into a monitor and use this monitor as a single display. However, you can easily set this up in the desktop settings. However, in the Linux the log-in screen is a different piece of software to the desktop. You need to copy these settings over to the sign-in manager.

```
sudo cp ~/.config/monitors.xml ~gdm/.config/
```

## Software Configuration

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

### Version Control - Git

Git is one of the first things you should install given that it is a dependancy for many of the software packages that follow.

With Git installed you will be able to clone this repository into your home directory and follow the steps in the software config section to stow your config files in your home directory.

Another piece of software that I like to use is lazygit. This is a higher level wrapper that sits on top of git. It provides a really nice interface which has good integration with neovim.

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
* fzf - fuzzy finding (build from source recommended)

### Text Editor - Neovim (LazyVim) (build from source recommended)

My choice of text editor is neovim. I currently use the LazyVim distribution, rather than configuring the whole thing from scratch. Fortunately, if you have have been following along so far you will have all the pre-requisites to run this distro, i.e. a true colour terminal and nerd font. Don't worry about going to the LazyVim site, the config file contined in this repostiroy points to this distro and all the relevant files will be downloaded. Simply use a pakcage manager to download neovim, the lazyvim package manager will handle the rest when you fisrt launch neovim.

### Password Manager

I use [pass](https://www.passwordstore.org/) for password management. This uses `gpg` encrypted files to store passwords. You will need to make sure this is properly configured if you want to use neovim coding assistant plugins, since my neovim setup gets its API keys via `pass`.

```
sudo apt-get install pass
```

Although the encrypted passwords are stored in this repo the private key is not, for obvious reasons. This will have to be manually transferred from a machine that has this key. This can be done by exporting the public and private keys held by `gpg`:

```
gpg --output public.pgp --armor --export jacknorrie6785@gmail.com
gpg --output private.pgp --armor --export-secret-key jacknorrie6785@gmail.com
```

this will output the files `public.pgp` and `private.pgp` into your current working directory. You can now transfer these over to your new machine and use the following command to load them into that machines `gpg`.

```
gpg --import private.pgp
gpg --import public.pgp
```

Finally, to encrypt new passwords on the new machine you will have to increase the machine's trust level for the key.

```
gpg --edit-key jacknorrie6785@gmail.com
```

Then type `trust` followed by `5`.

### Terminal Multiplexer - TMUX

Despite wezterm having a built in terminal multiplexer, I use tmux since this has a rich plugin ecosystem and is a standard tool. However, in order to take advantage of the plug-in ecosystem you will need to first install the tmux plugin manager (TPM) from GitHub. Then you will have to source the `.tmux.conf` file that should be in your home directory. Finally, you should enter TMUX and enter `prefix+I` to install the plugins using TPM.

### Tiling Window Manager

[placeholder]

### Browser

I like to use LibreWolf, which is a privacy-first fork of firefox that for the most part removes the need to "harden" your Firefox. The only modifications I make to this browser is the addition of the `vimium` and `passff` plugins.

## Further-Work

At some point I would like to experiment with nix-os (for linux) and nix-darwin (for mac), this would automate the system settings and software versioning portion of this development environment setup.

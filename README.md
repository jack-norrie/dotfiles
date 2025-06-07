# dotfiles

## Description

The purpose of this repository is to serve as a record of my development environment, i.e., programs I use for development alongside their configurations. This will allow me to move between various machines while maintaining a relatively consistent workflow. The main piece of software which makes this possible is GNU Stow, which allows me to symlink the dotfiles in this repository to their corresponding counterparts in my home directory.

## Operating System

I mainly program machine learning applications, and as such, I need an operating system and development environment with good support for Nvidia GPUs. Furthermore, I make use of a lot of FOSS and therefore prefer a UNIX-based OS. Nonetheless, I am not always in full control of the operating system I am using, so below are some tips for the 3 main types of operating system.

### Linux

My go-to Linux OS is Pop!_OS due to its out-of-the-box Nvidia driver support. However, this being an Ubuntu-based distro means the package-managed software is often out of date. For this reason, it is highly recommended to install the following packages so that you can build some packages from source:

```
sudo apt-get install ninja-build gettext cmake unzip curl build-essential
```

I am aware that there exist more bleeding-edge Linux distributions like Arch-based distros which have more up-to-date packages. However, building a handful of packages from source is not laborious enough for me to take on the increased instability risks when using such a distro. I might consider it when Wayland gets better Nvidia support, as this would allow me to try out Hyprland, which is a good-looking tiling window manager that works particularly well on Arch-based distros.

### MacOS

MacOS provides a stable unix based environment with up-to-date software via the Homebrew package manager. The only downside is that it is less customisable and as far as I am aware has limited tilling window management software.

### Windows

### VirtualBox

Occasionally I have to work on a windows machine. In such circumstances I would typically set up a Linux virtual machine using VirtualBox for the sake of development. If you do go down this route, then it is recommended to install the "VirtualBox Guest Additions", which is a set of device drivers and system applications that optimize the virtual machine for better performance and usability. You can install these by mounting the Guest Additions CD image (from the VirtualBox "Devices" menu) while your virtual machine is running, then running the installer from the mounted CD. This enables important features like shared clipboard, drag-and-drop file sharing, better video performance, and automatic display resizing.

```
sudo cvt 3840 2160
```

This will output a string that defines a resolution profile. Now type, `xrandr` to find the name of your display, likely something like `Virtual1`. Then simply create a file `.xprofile` in your home directory and add this display profile for your display of choice. For example:

```
#!/bin/sh
xrandr --newmode "3840x2160_60.00" 712.75 3840 4160 4576 5312 2160 2163 2168 2237 -hsync +vsync
xrandr --addmode Virtual1 "3840x2160_60.00"
```

Finally, virtual box uses the right control key as the `HOST` key by default, which is used in combination with other keys to perform VM shortcuts. I would recommend rebinding this, given that right control is a modifer key that is used by many programs within your virtual machine.

### Windows Subsystem for Linux

If using a traditional virtual machine feels a bit too heavy, then WSL provides an alternative option. It offers a compatibility layer that allows you to run a lightweight Linux environment directly within Windows, enabling seamless use of Linux tools and applications on your Windows machine.

## System Settings

### American Keyboard Layout

For the purpose of programming, having the hash symbol # be displaced by the pound sign £ is inconvenient. I find the American layout much easier for the purpose of typing commonly encountered symbols when programming.

### CAPS-LOCK to ESCAPE

When using proper typing technique, the CAPS-LOCK key is a redundant key, which is a shame since by default it takes a position on the keyboard which is very accessible, i.e., close to the home row. For this reason, I rebind it to a more useful and frequently used key. For me, escape is the best candidate for this remapping, since this is a key I frequently use when performing Vim motions. This can easily be done with gnome-tweaks on Linux and in the system settings on macOS.

### Single-Display

When using a laptop, I often plug it into a monitor and use this monitor as a single display. You can easily set this up in the desktop settings. However, in Linux, the log-in screen is a different piece of software from the desktop. You need to copy these settings over to the sign-in manager.

```
sudo cp ~/.config/monitors.xml ~gdm/.config/
```

### Work Space Shortcuts

I like to set shortcuts to move between my various workspaces. This functionality becomes redundant when using a tiling window manager, however sometimes you end up in a more vanilla desktop environment, and it can be useful to have this functionality. Use the following command on a Linux OS to add `<Control> + x` shortcuts to move to workspace `x`.

```
for i in {1..9}; do gsettings set "org.gnome.desktop.wm.keybindings" "switch-to-workspace-$i" "['<Control>$i']" ; done
```

## Software Configuration

### Using GNU Stow to Setup Symlinks

Clone this repository into your home directory. Then install GNU Stow and use it to create symlinks between the dotfiles in this repository and their counterparts in your home directory. This can be achieved by changing into the dotfiles directory and running stow on the directory:

```
cd dotfiles
stow .
```

If this has been successful, then you will be able to run `ls -lah` on your home directory and there should be symlinks (indicated with ->) in your home directory pointing at the config dotfiles in the dotfiles directory.

Finally, if there are any files you do not want to be symlinked to your home directory, you should specify them in a `.stow-local-ignore` file. There are some sensible file types, like `.git` and `README.md`, that are excluded by default. However, if you make your own ignore file, you will have to add these back in.

### Adding New Configs

The preceding steps have downloaded all the software config files from this repo and added links in your system home directory to them. However, what if you want to add a config you have been using locally into the repo? In this case, if we copy the file into our dotfiles repo and try to run `stow .`, we will get an error. This is because a file already exists in the location where a symlink is trying to be established. This can be fixed by either removing this file or adding the following flag to the stow command.

```
stow --adopt .
```

The adopt flag will overwrite any existing files that might already exist in your home directory with a symlink to their counterpart in the dotfiles repo.

## Software

The following software are roughly listed in the order in which they should be installed.

### Version Control - Git

Git is one of the first things you should install, given that it is a dependency for many of the software packages that follow.

With Git installed you will be able to clone this repository into your home directory and follow the steps in the software config section to stow your config files in your home directory.

Another piece of software that I like to use is [lazygit](https://github.com/jesseduffield/lazygit), which is git TUI that has nice integrations with my NeoVim config.

### Terminal Emulator - Ghostty

I have moved to [Ghostty](https://ghostty.org/) from WezTerm. I made this change due to the significant performance improvements for Ghostty on MacOS. Both are great options, and if you exclusively use Linux then WezTerm may have the upper hand in terms of extendability using lua. Meanwhile, Ghostty takes a different philosophy, preferring limited configurations and instead opting for sensible defaults.

### Shell - Zsh

This environment is setup with a `zsh` shell in mind. You can check if this is your default shell using `echo $SHELL`. If this is not the default shell of your operating system use the following commands:

```
sudo apt install zsh
chsh -s $(which zsh)
```

Then restart your system. After which, if you do not already have a `zshrc` dotfile in your home directory, you will be prompted to configure one.

If you have already stowed this repo into your home directory then you will have a `.zshrc` config file in your home directory. Your zsh shell should now be using a powerlevel10k configured prompt.

### Basic Terminal Utilities

* neofetch - retrieves system information.
* tree - visualisation of a directory.
* fzf - fuzzy finding (build from source recommended)
* htop - A useful utility to see processes and resource consumption.
* ripgrep - Used be the lazyvim search and replace tool.

### Text Editor - Neovim (LazyVim) (build from source recommended)

My choice of text editor is [Neovim](https://neovim.io/). I currently use the LazyVim distribution, rather than configuring the whole thing from scratch. Fortunately, if you have been following along so far, you will have all the prerequisites to run this distro, i.e., a true color terminal and nerd font. Don't worry about going to the LazyVim site, the config file contained in this repository points to this distro and all the relevant files will be downloaded. All that remains to be done is to install neovim, which can either be done via a package manager or by building neovim from source. I would recommend the latter, since package manager's neovim version is often out of date relative to the dependencies required for many of the Neovim plugins I use. With an install of neovim, the LazyVim package manager should then handle the rest in terms of installing plugins. However, it should be noted that some plugins will require `npm` as a dependency.

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

this will output the files `public.pgp` and `private.pgp` into your current working directory. You can now transfer these over to your new machine and use the following command to load them into that machine's `gpg`.

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

Despite WezTerm having a built-in terminal multiplexer, I use [tmux](https://github.com/tmux/tmux/wiki/Installing) since this has a rich plugin ecosystem and is a standard tool. However, in order to take advantage of the plugin ecosystem, you will need to first install the tmux plugin manager [(TPM)](https://github.com/tmux-plugins/tpm) from GitHub. Then you will have to source the `.tmux.conf` file that should be in your home directory. Finally, you should enter tmux and enter `prefix+I` to install the plugins using TPM.

### Tiling Window Manager

Due to my cross platform development environment I have been hesitant to invest learning a tiling window manager. So far I have found it relatively seamless moving between Linux and MacOS by mapping workspaces/desktops to `ctrl+<num>` keyboard shortcuts. Although this being said, I have heard that [i3](https://i3wm.org/) for Linux and [AeroSpace](https://github.com/nikitabobko/AeroSpace) for MacOS can be configured in a compatible fashion - Maybe I will look into this later.

### Browser

My browser of choice is Firefox.

## Further-Work

At some point, I would like to experiment with NixOS (for Linux) and nix-darwin (for macOS); this would automate the system settings and software versioning portion of this development environment setup.

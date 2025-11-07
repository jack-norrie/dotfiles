# dotfiles

## Description

The purpose of this repository is to serve as a record of my development environment, i.e., programs I use for development alongside their configurations. This will allow me to move between various machines while maintaining a relatively consistent workflow. The main piece of software which makes this possible is GNU Stow, which allows me to symlink the dotfiles in this repository to their corresponding counterparts in my home directory.

## Operating System - macOS

I primarily program machine learning applications, therefore my operating system of choice needs to have good support for the modern machine learning ecosystem. Additionally, I also make use of a lot of FOSS and as such I prefer a UNIX based operating system. Furthermore, I enjoy tinkering with computers and experimenting with GPU accelerated training on local hardware. Therefore, with no other constraints, my go to operating system would be a Linux based OS. However, professionally I use macOS, and I have found the mental overhead of switching between the different shortcuts associated with these different OSs to be cumbersome. As such, I have virtualised my local workstation using Proxmox and I ssh into virtual machines hosted on this workstation from my Mac when I want to use my GPU. This mirrors how I would use my Mac in a professional setting in combination with a cloud provider, and as such I have found this to be the lowest friction solution.

> [!NOTE]
> I have also experimented with Windows Subsystem for Linux (WSL). This worked well and I would certainly use this if forced to use Windows.

## System Settings

### American Keyboard Layout

For the purpose of programming, having the hash symbol # be displaced by the pound sign £ is inconvenient. I find the American layout much easier for the purpose of typing commonly encountered symbols when programming.

### CAPS-LOCK to ESCAPE

When using proper typing technique, the CAPS-LOCK key is a redundant key. This is a shame since by default it takes a position on the keyboard which is very accessible, i.e., close to the home row. For this reason, I rebind it to a more useful and frequently used key. For me, escape is the best candidate for this remapping, since this is a key I frequently use when performing Vim motions. This can easily be done in the system settings on macOS.

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

The following software are roughly listed in the order in which they should be installed. On macOS most of these pieces of software are available via the [brew](https://brew.sh/) package manager.

### Version Control - Git

Git is one of the first things you should install, given that it is a dependency for many of the software packages that follow.

With Git installed you will be able to clone this repository into your home directory and follow the steps in the software config section to stow your config files in your home directory.

Another piece of software that I like to use is [lazygit](https://github.com/jesseduffield/lazygit), which is git TUI that has nice integrations with my NeoVim config.

### Terminal Emulator - Ghostty

I have moved to [Ghostty](https://ghostty.org/) from WezTerm. I made this change due to the significant performance improvements for Ghostty on macOS. Both are great options, and if you exclusively use Linux then WezTerm may have the upper hand in terms of extendability using lua. Meanwhile, Ghostty takes a different philosophy, preferring limited configurations and instead opting for sensible defaults.

### Shell - Zsh

This environment is setup with a `zsh` shell in mind, which is the default shell on macOS. If you have already stowed this repo into your home directory then you will have a `.zshrc` config file in your home directory. Your zsh shell should now be using a powerlevel10k configured prompt.

### Basic Terminal Utilities

- neofetch - retrieves system information.
- tree - visualisation of a directory.
- fzf - fuzzy finding
- htop - A useful utility to see processes and resource consumption.
- ripgrep - Used by the lazyvim search and replace tool.
- tldr - An example driven version of the man pages for common usages of unix tools.

### Text Editor - Neovim (LazyVim)

My choice of text editor is [Neovim](https://neovim.io/). I currently use the LazyVim distribution, rather than configuring the whole thing from scratch. Fortunately, if you have been following along so far, you will have all the prerequisites to run this distro, i.e., a true color terminal and nerd font. Don't worry about going to the LazyVim site, the config file contained in this repository points to this distro and all the relevant files will be downloaded. All that remains to be done is to install neovim via a package manager. With an install of neovim, the LazyVim package manager should then handle the rest in terms of installing plugins. However, it should be noted that some plugins will require `npm` as a dependency.

### AI Coding Assistant

I use [OpenCode](https://opencode.ai/) as an AI coding assistant. This is a provider agnostic TUI based coding assistant. It integrates well with my terminal based setup, and one of my favorite features is that you can use `!` and enter a command into the chat box, which will then use this in the model's context. Another one of my favorite features is that it lets you use `<TAB>` to switch between `PLAN` and `BUILD` mode, where the former cannot make code changes and is for discussion. I have found the best way to use these agentic models is to first agree on a well thought out plan before giving the model the ability to change your code.

I primarily use this model with a Claude Pro subscription. However, if I get rate limited on this I will switch to Gemini flash, which allows 250 free requests per day. This is another feature I like about OpenCode. You can quickly switch between different models using `/models`.

Finally, I make use of the [windsurf](https://windsurf.com/) neovim extension for inline tab completions.

### Terminal Multiplexer - TMUX

Despite WezTerm having a built-in terminal multiplexer, I use [tmux](https://github.com/tmux/tmux/wiki/Installing) since this has a rich plugin ecosystem and is a standard tool. However, in order to take advantage of the plugin ecosystem, you will need to first install the tmux plugin manager [(TPM)](https://github.com/tmux-plugins/tpm) from GitHub. Then you will have to source the `.tmux.conf` file that should be in your home directory. Finally, you should enter tmux and enter `prefix+I` to install the plugins using TPM.

### Tiling Window Manager

I have designed my workflow around a large single monitor display in combination with a tiling window manager. I believe this is optimal since it allows me to focus on one thing at a time and I do not have to commit mental overhead to organising and finding my windows, I simply press a key combination and I will be brought to the application of my choosing in full screen. I personally arrange my workspaces as follows:

1. Files
2. Terminal
3. Web: Firefox + Postman (Accordion)
4. Communication: Outlook + Teams / Proton Mail + Discord (Accordion)
5. Learning: Obsidian + Anki (Accordion)

Unfortunately, the options for tiling window managers on macOS are limited. This is one of my biggest pain points with using this operating system. Nonetheless, I have found [aerospace](https://github.com/nikitabobko/AeroSpace) to be an acceptable option, even if it is a little buggy at times. It uses i3 like shortcuts, so if you are familiar with this Linux tiling window manager then you will feel right at home.

### Browser

My browser of choice is Firefox.

## Further-Work

At some point, I would like to experiment with NixOS (for Linux) and nix-darwin (for macOS); this would automate the system settings and software setup/versioning portion of this development environment setup.

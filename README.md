# neanias's rough dotfiles

I had an [old dotfile repo](https://github.com/neanias/dotfiles), but they didn't really reflect
the working dotfiles I have on my work machine (my most frequent development environment). This is
an attempt to consolidate my `.config` directory into a portable version.

## Installation

0. Install [`homebrew`](https://brew.sh)
1. Clone this repo to `$HOME/.config`
2. Install the [`Hack` patched nerd font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack)
3. If using iTerm2, import `Default.json` as a profilethe 
4. `cd` in and run `brew bundle` to install dependencies on macOS or Linux with Linuxbrew
5. Run the [`packer.nvim` quickstart steps](https://github.com/wbthomason/packer.nvim#quickstart) to install a local copy of `packer.nvim`
6. Open nvim and install packages using `:PackerInstall`
	1. This may require a reboot of nvim afterwards
7. Set any personal git config overrides in `~/.gitconfig.user`

## To investigate

- [ ] Making this more configurable per machine (i.e. having local configs that override general
			config)
- [ ] Supporting non-config files (like ZSH)
- [ ] Automatic install script (maybe Make?)

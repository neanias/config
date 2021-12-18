# neanias's Neovim config

After much toil, I've rewritten my config to be all in native Lua. [This is my
original vimscript Neovim
configuration.](https://gist.github.com/neanias/6d8a1f695b6246d1fbd7)

## Requirements

This requires Neovim 0.5.x to work properly since it has built-in support for
LSPs and Treesitter, as well as first-class Lua support.

_Optional_: This uses [`stylua`](https://github.com/johnnymorganz/stylua) to
format the Lua files.

## Installation

To install, clone this repo (except the `.git` directory) as `~/.config/nvim`
(or `$XDG_CONFIG_PATH/nvim` if different) and open nvim. It _should_ download
and install Packer automatically and then install the plugins. If not, use
`:PackerInstall` and `:PackerCompile` to install and compile the plugins.

## Configuration

All advanced configuration has been moved into [`lua/settings/`](lua/settings/)
and can be changed in there, before being reloaded. Some configuration has been
left as `config` functions in [`plugins.lua`](lua/plugins.lua). This may change
in the future.

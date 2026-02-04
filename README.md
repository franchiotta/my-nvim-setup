# Setup for neovim editor

Personal setup for neovim.

Installation steps:

- git clone git@github.com:franchiotta/my-nvim-setup.git ~/.config/nvim
- Install dependencies using Packer plugin management.

## pre-requisites
- [neovim](https://neovim.io/)
- [Packer Plugin Management](https://github.com/wbthomason/packer.nvim)
- Python 3+
- jq
- [NerdFonts](https://www.nerdfonts.com/)

### How to install Nerd Fonts

Install the [font-symbols-only-nerd-font](https://formulae.brew.sh/cask/font-symbols-only-nerd-font) using homebrew, then configure the preferred terminal emulation with the respective font. For iterm2, for example, Preferences -> Profiles -> Text -> mark "Use a different font for non-ASCII text -> Select from the dropdown the recently downloaded font.

### How to install LSP server

There are some configuration to set up different Language Server Protocol (LSP) servers in `lua/mappings/lsp.lua`. Use `mason` for that purpose, which comes listed in `plugins.lua` as a plugin to be installed. For `jdtls` LPS server, there's a specific file for custom confiuration located at `ftplugin/java.lua`.

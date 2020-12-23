#!/usr/bin/env bash

# Check whether neovim is installed or not
type nvim >/dev/null 2>&1 \
    && type curl >/dev/null 2>&1 \
    && type git >/dev/null 2>&1 \
    && type pip >/dev/null 2>&1 \
    || {
    (>&2 echo "You need to install: neovim, curl, git and pip.");
        exit 1;
    }

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
NVIM_CONFIG="$CONFIG_HOME/nvim/init.vim"

# Some bundles require if_python3
pip install --user pynvim

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

rm -rf "$CONFIG_HOME/nvim"
mkdir -p "$CONFIG_HOME/nvim"

# Download the latest vim init plugins
curl -LSso "$NVIM_CONFIG" \
    "https://raw.githubusercontent.com/merajsahebdar/setup-vim/master/vimrc-plugins"

# Install Plugins
nvim +PlugInstall +qall

# Download the latest vim init configurations
echo -e "" >> "$NVIM_CONFIG"
curl -LSs \
    "https://raw.githubusercontent.com/merajsahebdar/setup-vim/master/vimrc-configs" | tee -a "$NVIM_CONFIG"

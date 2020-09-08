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

function link_nvim_configs() {
    rm -rf "$1"
    mkdir -p "$1"
    ln -sf "$HOME/.vim/autoload" "$1/autoload"
    ln -sf "$HOME/.vim/bundle" "$1/bundle"
    ln -sf "$HOME/.vimrc" "$1/init.vim"
}

# Some of these bundles require if_python3
pip install --user pynvim

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Download the latest .vimrc plugins
curl -LSso "$HOME/.vimrc" \
    "https://raw.githubusercontent.com/itsdrewstiles/setup-vim/master/vimrc-plugins"

# Install Plugins
vim +PlugInstall +qall

# Download the latest .vimrc configurations
echo -e "\n\n" > "$HOME/.vimrc"
curl -LSs \
    "https://raw.githubusercontent.com/merajsahebdar/setup-vim/master/vimrc-configs" | tee -a "$HOME/.vimrc"

# Link neovim configs to vim configs
if [[ -n "${XDG_CONFIG_HOME+x}" ]]; then
    link_nvim "$XDG_CONFIG_HOME/nvim"
else
    link_nvim_configs "$HOME/.config/nvim"
fi

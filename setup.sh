#!/usr/bin/env bash

# Check whether neovim is installed or not
type nvim >/dev/null 2>&1 \
    && type curl >/dev/null 2>&1 \
    && type git >/dev/null 2>&1 \
    || {
    (>&2 echo "You need to install: neovim, curl, git.");
        exit 1;
    }

function dl_bundle() {
    if [[ -d "$HOME/.vim/bundle/$1" ]]; then
        pushd "$HOME/.vim/bundle/$1"
        git pull
        popd
    else
        git clone --depth=1 "$2" "$HOME/.vim/bundle/$1"
    fi
}

function link_nvim_configs() {
    rm -rf "$1"
    mkdir -p "$1"
    ln -sf "$HOME/.vim/autoload" "$1/autoload"
    ln -sf "$HOME/.vim/bundle" "$1/bundle"
    ln -sf "$HOME/.vimrc" "$1/init.vim"
}

# Install vim-pathogen
mkdir -p "$HOME/.vim/autoload" "$HOME/.vim/bundle"
curl -LSso "$HOME/.vim/autoload/pathogen.vim" "https://tpo.pe/pathogen.vim"

# Install plugins
dl_bundle "deoplete.nvim" \
    "https://github.com/Shougo/deoplete.nvim.git"
dl_bundle "delimitMate" \
    "https://github.com/Raimondi/delimitMate.git"
dl_bundle "Dockerfile.vim" \
    "https://github.com/ekalinin/Dockerfile.vim.git"
dl_bundle "kotlin-vim" \
    "https://github.com/udalov/kotlin-vim"
dl_bundle "neomake" \
    "https://github.com/neomake/neomake.git"
dl_bundle "nerdtree" \
    "https://github.com/scrooloose/nerdtree.git"
dl_bundle "nerdtree-git-plugin" \
    "https://github.com/Xuyuanp/nerdtree-git-plugin.git"
dl_bundle "swift.vim" \
    "https://github.com/keith/swift.vim.git"
dl_bundle "tsuquyomi" \
    "https://github.com/Quramy/tsuquyomi.git"
dl_bundle "typescript-vim" \
    "https://github.com/leafgarland/typescript-vim.git"
dl_bundle "vim-acpi-asl" \
    "https://github.com/martinlroth/vim-acpi-asl.git"
dl_bundle "vim-airline" \
    "https://github.com/vim-airline/vim-airline.git"
dl_bundle "vim-better-whitespace" \
    "https://github.com/ntpeters/vim-better-whitespace.git"
dl_bundle "vim-colorschemes" \
    "https://github.com/flazz/vim-colorschemes.git"
dl_bundle "vim-editorconfig" \
    "https://github.com/sgur/vim-editorconfig.git"
dl_bundle "vim-gitgutter" \
    "https://github.com/airblade/vim-gitgutter.git"
dl_bundle "vim-javascript" \
    "https://github.com/pangloss/vim-javascript.git"
dl_bundle "vim-localvimrc" \
    "https://github.com/embear/vim-localvimrc.git"
dl_bundle "vim-markdown" \
    "https://github.com/plasticboy/vim-markdown.git"
dl_bundle "vim-wildgitignore" \
    "https://github.com/jason0x43/vim-wildgitignore.git"

# Download the latest .vimrc
curl -LSso "$HOME/.vimrc" \
    "https://raw.githubusercontent.com/itsdrewstiles/setup-vim/master/vimrc"

# Link neovim configs to vim configs
if [[ -n "${XDG_CONFIG_HOME+x}" ]]; then
    link_nvim "$XDG_CONFIG_HOME/nvim"
else
    link_nvim_configs "$HOME/.config/nvim"
fi

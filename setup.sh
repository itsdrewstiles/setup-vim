#!/usr/bin/env bash

# Check whether vim is installed or not
type vim >/dev/null 2>&1 \
    && type curl >/dev/null 2>&1 \
    && type git >/dev/null 2>&1 \
    || {
        echo >&2 "You need to install: vim, curl, git.";
        exit 1;
    }

dl_bundle() {
    if [[ -d "$HOME/.vim/bundle/$1" ]]; then
        pushd "$HOME/.vim/bundle/$1"
        git pull
        popd
    else
        git clone --depth=1 "$2" "$HOME/.vim/bundle/$1"
    fi
}

# Install vim-pathogen
mkdir -p "$HOME/.vim/autoload" "$HOME/.vim/bundle"
curl -LSso "$HOME/.vim/autoload/pathogen.vim" "https://tpo.pe/pathogen.vim"

# Install plugins
dl_bundle "delimitMate" \
    "https://github.com/Raimondi/delimitMate.git"
dl_bundle "Dockerfile.vim" \
    "https://github.com/ekalinin/Dockerfile.vim.git"
dl_bundle "nerdtree" \
    "https://github.com/scrooloose/nerdtree.git"
dl_bundle "nerdtree-git-plugin" \
    "https://github.com/Xuyuanp/nerdtree-git-plugin.git"
dl_bundle "syntastic" \
    "https://github.com/vim-syntastic/syntastic.git"
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
dl_bundle "vim-markdown" \
    "https://github.com/plasticboy/vim-markdown.git"

# Download the latest .vimrc
curl -LSso "$HOME/.vimrc" \
    "https://raw.githubusercontent.com/itsdrewstiles/setup-vim/master/vimrc"

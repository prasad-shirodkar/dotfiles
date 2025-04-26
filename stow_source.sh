#!/usr/bin/env bash

# Uncomment below for troubleshooting purposes
#set -x

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

pushd $SCRIPT_DIR > /dev/null

mkdir -p $HOME/.config

stow --target=$HOME bash
stow --target=$HOME vim
stow --target=$HOME tmux
stow --target=$HOME screen
stow --target=$HOME/.config config

source ~/.bashrc

popd > /dev/null

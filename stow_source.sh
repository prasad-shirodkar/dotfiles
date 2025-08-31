#!/usr/bin/env bash

# Uncomment below for troubleshooting purposes
#set -x

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
source $SCRIPT_DIR/bash/.exports

pushd $SCRIPT_DIR > /dev/null

mkdir -p $XDG_CONFIG_HOME

stow --target=$HOME bash
stow --target=$HOME vim
stow --target=$HOME tmux
stow --target=$HOME screen
stow --target=$XDG_CONFIG_HOME config

source ~/.bashrc

popd > /dev/null

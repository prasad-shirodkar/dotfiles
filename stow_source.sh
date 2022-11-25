#!/usr/bin/env bash

# Uncomment below for troubleshooting purposes
#set -x

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)

pushd $SCRIPT_DIR > /dev/null

stow --target=$HOME bash
stow --target=$HOME vim
stow --target=$HOME tmux

source ~/.bashrc

popd > /dev/null

#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)

pushd $SCRIPT_DIR

stow --target=$HOME bash
stow --target=$HOME vim
stow --target=$HOME tmux

source ~/.bashrc

popd

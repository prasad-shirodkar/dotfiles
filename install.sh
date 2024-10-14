#!/usr/bin/env bash

# On mac, first time install: ./install.sh INSTALL_BREW=1
# On linux, first time install: ./install.sh

INSTALL_BREW=${INSTALL_BREW:-0}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
source $SCRIPT_DIR/bash/.functions

pushd $SCRIPT_DIR > /dev/null

# make temporary directory in directory
mkdir -p $HOME/tmp -m 700

if exists apt; then
  install_via_apt
elif exists brew; then
  brew update && brew upgrade
  brew bundle check
  if [[ $? -ne 0 ]]; then
    brew bundle install --file=$SCRIPT_DIR/Brewfile
  fi
elif [[ "$INSTALL_BREW" -eq 1 ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # https://docs.brew.sh/Homebrew-on-Linux
  if is_linux; then
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    if exists yum; then
      sudo yum groupinstall 'Development Tools'
      sudo yum -y install procps-ng curl file git
    fi
  fi
  brew bundle install --file=$SCRIPT_DIR/Brewfile
fi

# generic software installed on linux without package manager
if is_linux; then
  install_rupa_z
  install_kind
fi

# Run all scripts in programs directory. Installing via apt for now.
if exists apt; then
  for f in $SCRIPT_DIR/programs/*.sh; do bash "$f" -H; done
fi

stow --target=$HOME bash
stow --target=$HOME vim
stow --target=$HOME tmux
stow --target=$HOME screen

# https://github.com/golang/tools/tree/master/gopls#installation
exists go && go install golang.org/x/tools/gopls@latest

if [[ ! -f $HOME/.bashrc ]]; then
  sudo touch $HOME/.bashrc
fi
grep --fixed-strings '. ~/.bashrc.me' $HOME/.bashrc
if [[ $? -ne 0 ]]; then
  echo '[[ -f ~/.bashrc.me ]] && . ~/.bashrc.me' >> $HOME/.bashrc
fi

if [[ ! -f $HOME/.bash_profile ]]; then
  sudo touch $HOME/.bash_profile
fi
grep --fixed-strings '. ~/.bashrc' ~/.bash_profile
if [[ $? -ne 0 ]]; then
  echo '[[ -f ~/.bashrc ]] && . ~/.bashrc' >> $HOME/.bash_profile
fi

popd > /dev/null 

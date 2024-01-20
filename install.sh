#!/usr/bin/env bash

# On mac, first time install: ./install.sh INSTALL_BREW=1
# On linux, first time install: ./install.sh

INSTALL_BREW=${INSTALL_BREW:-0}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
source $SCRIPT_DIR/bash/.functions

pushd $SCRIPT_DIR > /dev/null

if exists apt; then
  aptinstall
elif exists brew; then
  brew update && brew upgrade
  brew bundle check
  if [[ $? -ne 0 ]]; then
    brew bundle install --file=$SCRIPT_DIR/Brewfile
  fi
elif [[ "$INSTALL_BREW" -eq 1 ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # https://docs.brew.sh/Homebrew-on-Linux
  if [[ is_linux ]]; then
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    if exists yum; then
      sudo yum groupinstall 'Development Tools'
      sudo yum -y install procps-ng curl file git
    fi
  fi
  brew bundle install --file=$SCRIPT_DIR/Brewfile
fi

# Run all scripts in programs directory. Installing via apt for now.
if exists apt; then
  for f in $SCRIPT_DIR/programs/*.sh; do bash "$f" -H; done
fi

stow --target=$HOME bash
stow --target=$HOME vim
stow --target=$HOME tmux
stow --target=$HOME screen

# To install useful key bindings and fuzzy completion:
if exists brew; then
  $(brew --prefix)/opt/fzf/install
else
  [[ -x "/usr/local/opt/fzf/install" ]] && . "/usr/local/opt/fzf/install"
fi

# https://github.com/golang/tools/tree/master/gopls#installation
exists go && go install golang.org/x/tools/gopls@latest

if [[ ! -f $HOME/.bashrc ]]; then
  sudo touch $HOME/.bashrc
fi
echo "[ -f ~/.bashrc.me ] && source ~/.bashrc.me" >> $HOME/.bashrc

popd > /dev/null 

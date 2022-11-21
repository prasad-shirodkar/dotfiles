#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)
source $SCRIPT_DIR/bash/.functions

pushd $SCRIPT_DIR

if exists brew; then
  brew update && brew upgrade
  brew bundle check
  if [[ $? -ne 0 ]]; then
    brew dump install --file=$SCRIPT_DIR/Brewfile
  fi
else
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
  brew dump install --file=$SCRIPT_DIR/Brewfile
fi

stow --target=$HOME bash
stow --target=$HOME vim
stow --target=$HOME tmux

# Git completion
wget -O ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
chmod +x ~/.git-completion.bash
. ~/.git-completion.bash

# Git prompt
wget -O ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
chmod +x ~/.git-prompt.sh
. ~/.git-prompt.bash

# z utility
git clone https://github.com/rupa/z.git ~/tmp/z
chmod +x ~/tmp/z/z.sh
mv ~/tmp/z/z.sh /usr/local/bin/
mv ~/tmp/z/z.1 /usr/local/share/man/man1
rm -rf ~/tmp/z

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install

# https://github.com/golang/tools/tree/master/gopls#installation
exists go && go install golang.org/x/tools/gopls@latest

popd $SCRIPT_DIR

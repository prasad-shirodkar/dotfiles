#!/usr/bin/env bash

# Git completion
wget -O ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
chmod +x ~/.git-completion.bash
. ~/.git-completion.bash

# Git prompt
wget -O ~/.git-prompt.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.bash
chmod +x ~/.git-prompt.bash
. ~/.git-prompt.bash

# z utility
git clone https://github.com/rupa/z.git ~/tmp/z
chmod +x ~/tmp/z/z.sh
mv ~/tmp/z/z.sh /usr/local/bin/
mv ~/tmp/z/z.1 /usr/local/share/man/man1
rm -rf ~/tmp/z

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install

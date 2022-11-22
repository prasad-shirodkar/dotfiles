# Source global definitions
[ -f /etc/bashrc ] && . /etc/bashrc

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,exports,functions,completions,aliases,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

[ -f /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# https://docs.brew.sh/Homebrew-on-Linux
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

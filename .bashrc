# Source global definitions
[ -f /etc/bashrc ] && . /etc/bashrc

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,functions,completions,aliases,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# source kubectl bash completion
if hash kubectl 2>/dev/null; then
	# shellcheck source=/dev/null
	source <(kubectl completion bash)
	# shorthand alias for kubectl that also works with completion:
	alias k=kubectl
    complete -o default -F __start_kubectl k
fi

# source helm bash completion
if hash helm 2>/dev/null; then
	# shellcheck source=/dev/null
	source <(helm completion bash)
fi

# source kind bash completion
if hash kind 2>/dev/null; then
	# shellcheck source=/dev/null
    source <(kind completion bash)
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

if [[ -n "$(which z)" ]]; then
   . /usr/local/bin/z.sh
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

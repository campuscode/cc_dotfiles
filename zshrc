setopt promptsubst

# load our own completion functions
fpath=(~/.zsh/completion /usr/local/share/zsh/site-functions $fpath)

# completion
autoload -U compinit
compinit -u

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=50000
SAVEHIST=50000

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

set -o nobeep # no annoying beeps

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Zsh syntax highlight
[[ -f ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ "$(uname)" == "Linux" ]]; then
  TERM=screen-256color
fi

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Peepcode theme to make your terminal simple and beautiful
source ~/.zsh/themes/peepcode.theme

# Your secrets env var
[[ -f ~/.secrets ]] && source ~/.secrets

setopt interactivecomments

# Load mise (Ruby, Node.js version manager)
[[ -f ~/.local/bin/mise ]] && eval "$(~/.local/bin/mise activate zsh)"

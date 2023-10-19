typeset -U path cdpath fpath manpath

path+="$HOME/.zsh/plugins/cmdtime"
fpath+="$HOME/.zsh/plugins/cmdtime"

plugins=(dirhistory git screen)
ZSH_CUSTOM="$HOME/.oh-my-zsh"
ZSH_THEME="tdpeuter"
# source $ZSH/oh-my-zsh.sh

if [[ -f "$HOME/.zsh/plugins/cmdtime/cmdtime.plugin.zsh" ]]; then
    source "$HOME/.zsh/plugins/cmdtime/cmdtime.plugin.zsh"
fi
if [[ -f "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [[ -f "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 
fi

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# Add direnv
if [ -x "$(command -v direnv)" ]; then
  eval "$(direnv hook zsh)"
fi

# Add fzf
if [ -x "$(command -v fzf-share)" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

# Aliases
alias cp='cp -i'
alias df='df -h'
alias free='free -m'
alias gs='git status'
alias hgrep='history | grep'
alias ll='ls -la'
alias more='less'
alias np='nano -w PKGBUILD'
alias update='pushd ~/projects/sisyphus/nixos
nix flake update
sudo nixos-rebuild switch --flake .# --show-trace
popd
'

# -- Barrier --

for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done


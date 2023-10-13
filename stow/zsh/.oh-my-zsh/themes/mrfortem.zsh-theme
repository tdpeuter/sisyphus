# 
# ~/.oh-my-zsh/themes/mrfortem.zsh-theme
# Stolen from gentoo-theme and gianni
#

autoload -Uz colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{red}*'   # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr '%F{yellow}+'  # display this when there are staged changes
zstyle ':vcs_info:*' actionformats '%F{5}(%F{2}%b%F{3}|%F{1}%a%c%u%m%F{5})%f '
zstyle ':vcs_info:*' formats "%f(%F{cyan} %b%c%u%m%f)%f "
zstyle ':vcs_info:svn:*' branchformat '%b'
zstyle ':vcs_info:svn:*' actionformats '%F{5}(%F{2}%b%F{1}:%{3}%i%F{3}|%F{1}%a%c%u%m%F{5})%f '
zstyle ':vcs_info:svn:*' formats '%F{5}(%F{2}%b%F{1}:%F{3}%i%c%u%m%F{5})%f '
zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:git*+set-message:*' hooks untracked-git

+vi-untracked-git() {
        if command git status --porcelain 2>/dev/null | command grep -q '??'; then
                hook_com[misc]='%F{red}?'
        else
                hook_com[misc]=''
        fi
}

loadgit() {
        vcs_info
}

autoload -U add-zsh-hook
add-zsh-hook precmd loadgit

# Backup line(s)
# PROMPT='%(!.%B%F{red}.%B%F{green}%n@)%m %F{blue}%(!.%1~.%~) ${vcs_info_msg_0_}%F{blue}%(!.#.$)%k%b%f '
# PROMPT='%(!.%B%F{red}.%B%F{green}%n@)%m %{$reset_color%}%F{cyan}%c %B${vcs_info_msg_0_}%F{green}%(!.#.$)%k%b%f '
PROMPT='%(!.%B%F{red}%m .)%{$reset_color%}%F{cyan}%c %B${vcs_info_msg_0_}%F{green}%(!.#.$)%k%b%f '

# PROMPT='%{$fg_bold[green]%}[%n@%m%{$reset_color%} %{$fg[cyan]%}%c%{$reset_color%}$(git_prompt_info)%{$fg_bold[green]%}]%{$reset_color%}$ '

# ZSH_THEME_GIT_PROMPT_PREFIX=" (%{$fg_bold[cyan]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX=")"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%} %{$fg[yellow]%}X%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}"

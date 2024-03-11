source ~/.zplug/init.zsh

# Let zplug manage itself
zplug "zplug/zplug", hook-build:"zplug --self-manage"

# Carry over Oh My ZSH plugins
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/gpg-agent", from:oh-my-zsh

# Needs to be set _before_ we source the SSH agent plugin
# zstyle :omz:plugins:ssh-agent agent-forwarding on
# zplug "plugins/ssh-agent", from:oh-my-zsh

zplug "lib/completion", from:oh-my-zsh

zplug "Aloxaf/fzf-tab"

# zsh-user plugins
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "z-shell/F-Sy-H" #, defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

###########
# OPTIONS #
###########

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHDMINUS

setopt RM_STAR_WAIT
setopt CORRECT # Command autocorrection
setopt AUTO_PARAM_SLASH

#############
#  ALIASES  #
#############

alias be="bundle exec"
alias ls="eza"
alias la="eza -a"
alias ll="eza -alh"
alias ga="git add"
alias gf="git fetch"
alias gpl="git pull"
alias grv="git remote -v"
alias gst="git status"

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias tree="eza --tree"
# Switches Bat themes based on dark/light mode
alias cat="bat --theme=\"\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'Everforest Dark' || echo 'Everforest Light')\""

#############
#  HISTORY  #
#############

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt EXTENDED_HISTORY        # record timestamp of command in HISTFILE
setopt HIST_EXPIRE_DUPS_FIRST  # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS        # ignore duplicated commands history list
setopt HIST_IGNORE_SPACE       # ignore commands that start with space
setopt HIST_VERIFY             # show command with history expansion to user before running it
setopt APPEND_HISTORY          # zsh sessions will append their history list to the history file, rather than replace it
setopt SHARE_HISTORY           # share command history data

#############
# FUNCTIONS #
#############


# Use fd and fzf to get the args to a command.
# Works only with zsh
# Examples:
# f mv # To move files. You can write the destination after selecting the files.
# f 'echo Selected:'
# f 'echo Selected music:' --extension mp3
# fm rm # To rm files in current directory
f() {
    sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
    test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}

# Like f, but not recursive.
fm() f "$@" --max-depth 1

# Deps
alias fz="fzf-noempty --bind 'tab:toggle,shift-tab:toggle+beginning-of-line+kill-line,ctrl-j:toggle+beginning-of-line+kill-line,ctrl-t:top' --color=light -1 -m"
fzf-noempty () {
  local in="$(</dev/stdin)"
  test -z "$in" && (
    exit 130
  ) || {
    ec "$in" | fzf "$@"
  }
}
ec () {
  if [[ -n $ZSH_VERSION ]]
  then
    print -r -- "$@"
  else
    echo -E -- "$@"
  fi
}

# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-80 | fzf --nth=1,2
  ) && ${EDITOR:-nvim} $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}


###################
#  Other imports  #
###################

# Add locally installed binaries to PATH
export PATH="$HOME/.local/bin:$PATH"

export EDITOR='nvim'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export XDG_CONFIG_PATH="$HOME/.config"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_PATH/ripgrep/config"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Load rbenv automatically by appending
# the following to ~/.zshrc:

# Rbenv
eval "$(rbenv init -)"

function set_win_title() {
    echo -ne "\033]0; $(basename "$PWD") \007"
}
starship_precmd_user_func="set_win_title"

eval "$(starship init zsh)"

# HSTR configuration - add this to ~/.zshrc
alias hh=hstr                             # hh to be alias for hstr
setopt histignorespace                    # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor                # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)

# Initialise direnv
eval "$(direnv hook zsh)"

# fzf-tab config
enable-fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

export NVM_DIR="$HOME/.nvm"
test -e "$NVM_DIR/nvm.sh" && source "$NVM_DIR/nvm.sh"  # This loads nvm
test -e "$NVM_DIR/bash_completion" && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.cargo/env" && source $HOME/.cargo/env

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

################################################
#                   Exports                    #
################################################

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export NVM_DIR="$HOME/.nvm"
export REACT_EDITOR=vscode
export TERM=xterm-256color

# Keep PATH free of duplicates (e.g. after `reload`)
typeset -U path

# Android SDK for React Native (installed by Android Studio): macOS, then Ubuntu
for sdk in "$HOME/Library/Android/sdk" "$HOME/Android/Sdk"; do
  if [[ -d "$sdk" ]]; then
    export ANDROID_HOME="$sdk"
    path+=("$sdk/emulator" "$sdk/platform-tools")
    break
  fi
done
unset sdk

[[ -d "$HOME/.composer/vendor/bin" ]] && path=("$HOME/.composer/vendor/bin" $path)
[[ -d "$HOME/.pyenv/versions/3.7.2/bin" ]] && path=("$HOME/.pyenv/versions/3.7.2/bin" $path)
[[ -d "$HOME/.cargo/bin" ]] && path=("$HOME/.cargo/bin" $path)

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="dracula"


# Add wisely, as too many plugins slow down shell startup.
plugins=(git history zsh-autosuggestions last-working-dir vi-mode)
# git: The git plugin provides many aliases and a few useful functions.
# history: Provides a couple of convenient aliases for using the history
# last-working-dir: Keeps track of the last used working directory and automatically jumps into it for new shells
# vi-mode: This plugin increase vi-like zsh functionality.
# tmux: This plugin provides aliases for tmux, the terminal multiplexer.


source $ZSH/oh-my-zsh.sh

################################################
#            CUSTOM FUNCTIONS                  #
################################################

# Create a directory and move into it
mkcd(){
  mkdir "$1"
  cd "$1"
}

function gbfo(){
  origin_branch=$1
  local_branch=$2
  git checkout -b $local_branch origin/$origin_branch
}

function gbfm(){
  branch_name=$1
  git checkout -b $branch_name origin/master
}

function gbfs(){
  branch_name=$1
  git checkout -b $branch_name origin/staging
}

function gbfd(){
  branch_name=$1
  git checkout -b $branch_name origin/develop
}
function csv_viewer() {
  file=$1
  column -s, -t < $file | less -#2 -N -S
}

function kill_by_port() {
  port=$1
  sudo kill -9 `sudo lsof -t -i:$port`
}

browsersync(){
 browser-sync start --server --directory --files "**/*"
}

################################################
#            CUSTOM ALIAS                      #
################################################
alias mv="mv -i"
alias lsdot='ls -pah | grep -v / | grep "^\."'
alias ll="ls -lah"
alias ..="cd .."
# macOS ships `open`; on Linux map it to xdg-open
[[ "$OSTYPE" == linux* ]] && (( $+commands[xdg-open] )) && alias open="xdg-open"
alias reload="exec zsh"
alias config="vi ~/.zshrc"
alias cat-config="cat ~/.zshrc"
alias d="adb shell input keyevent 82"
alias grlc="git reset --soft HEAD~1"
alias android="react-native run-android"
alias reverse="adb reverse tcp:8081 tcp:8081"
alias check-update="ncu -g"
alias weather="curl https://v2.wttr.in"
alias pr="pnpm run"
alias pst="pnpm start"
alias pt="pnpm t"
alias pd="pnpm run dev"
alias yd="yarn dev"
alias yb="yarn build"
alias y="yarn"
alias yt="yarn test"


#################################################
#               PLUGIN SETTINGS                 #
#################################################
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

##############
# Other Stuff #
##############
[ -f ~/.z ] || touch ~/.z # z expects its data file to exist
source "${${(%):-%x}:A:h}/z.sh" # Sourcing z from the dotfiles repo

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f "$HOME/.config/broot/launcher/bash/br" ] && source "$HOME/.config/broot/launcher/bash/br"
[[ -d "$HOME/.rbenv/bin" ]] && path=("$HOME/.rbenv/bin" $path)
command -v rbenv >/dev/null && eval "$(rbenv init - zsh)"
path=("$HOME/.local/bin" $path)

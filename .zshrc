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
export ZSH="/home/hugo/.oh-my-zsh"
export NVM_DIR="$HOME/.nvm"

export STUDIO="/home/hugo/android-studio/bin"
export REACT_EDITOR=vscode

export ANDROID_HOME="/mnt/a0cae30c-c710-4db8-a518-dc06e08341bf/Android/SDK"
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$HOME/.composer/vendor/bin:$PATH
export ANDROID_AVD_HOME=$ANDROID_HOME/.android/avd
export ANDROID_SDK_HOME=$ANDROID_HOME/
export TERM=xterm-256color
export PATH=/home/hugo/.pyenv/versions/3.7.2/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="dracula"


# Add wisely, as too many plugins slow down shell startup.
plugins=(git history zsh-autosuggestions last-working-dir vi-mode tmux)
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
alias lsdot="ls -pah | grep -v / | grep "^\.""
alias ll="ls -lah"
alias ..="cd .."
alias open="xdg-open"
alias start-dashboard="cd /home/hugo/Documents/Prixz/Avus-dashboard && npm start"
alias start-api-dev="/home/hugo/Documents/Prixz/GraphQL-API && nrd"
alias start-api-prod="/home/hugo/Documents/Prixz/GraphQL-API && ns"
alias reload="exec zsh"
alias dev="cd ~/Documents/dev"
alias config="vi ~/.zshrc"
alias cat-config="cat ~/.zshrc"
alias d="adb shell input keyevent 82"
alias grlc="git reset --soft HEAD~1"
alias android="react-native run-android"
alias reverse="adb reverse tcp:8081 tcp:8081"
alias check-update="ncu -g"
alias release="./gradlew app:assembleRelease"
alias flipper="/home/hugo/Downloads/Flipper-linux/flipper"
alias ioe="adb -s emulator-5554 install app/build/outputs/apk/release/app-release.apk"
alias iod="adb -s 98892a4335444f4b39 install app/build/outputs/apk/release/app-release.apk"
alias iodd="adb -s 98892a4335444f4b39 install app/build/outputs/apk/debug/app-debug.apk"
alias open-emulator="emulator -avd Pixel_3_API_28"
alias open-apk="open /Users/Hugo/Desktop/prixz/prixz-marketplace-native/android/app/build/outputs/apk"
alias weather="curl https://v2.wttr.in"
alias nr="npm run"
alias ns="npm start"
alias nt="npm t"
alias nrd="npm run dev"
alias yd="yarn dev"
alias yb="yarn build"
alias y="yarn"
alias yt="yarn test"
alias gpt="prisma token --copy"


#################################################
#                   POWERLEVEL                  #
#################################################
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status dir_writable ip ram )

# DEFAULT_FOREGROUND=006 DEFAULT_BACKGROUND=235
# DEFAULT_COLOR=$DEFAULT_FOREGROUND
# POWERLEVEL9K_MODE="nerdfont-complete"
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=false
# POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
# POWERLEVEL9K_ALWAYS_SHOW_USER=false
# POWERLEVEL9K_CONTEXT_TEMPLATE='%n'

# POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='white'
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="❱ "
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{014}\u2570%F{cyan}\uF460%F{073}\uF460%F{109}\uF460%f "


# POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="$DEFAULT_BACKGROUND"
# POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND="$DEFAULT_BACKGROUND"

# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\uE0B4"
# POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR="%F{$(( $DEFAULT_BACKGROUND - 2 ))}|%f"
# POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR="\uE0B6"
# POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR="%F{$(( $DEFAULT_BACKGROUND - 2 ))}|%f"

# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
# POWERLEVEL9K_STATUS_VERBOSE=true
# PWERLEVEL9K_STATUS_CROSS=true
# PWERLEVEL9K_PROMPT_ADD_NEWLINE=true
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭"
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰\uF460 "

# POWERLEVEL9K_VCS_CLEAN_BACKGROUND="green"
# POWERLEVEL9K_VCS_CLEAN_FOREGROUND="$DEFAULT_BACKGROUND"
# POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="yellow"
# POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="$DEFAULT_BACKGROUND"

# POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
# POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

# POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="$DEFAULT_BACKGROUND"

# POWERLEVEL9K_IP_INTERFACE="wlo1"

# POWERLEVEL9K_DIR_HOME_BACKGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_DIR_HOME_FOREGROUND="$DEFAULT_BACKGROUND"
# POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="$DEFAULT_BACKGROUND"

# POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="$DEFAULT_BACKGROUND"
# POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="$DEFAULT_BACKGROUND"

# POWERLEVEL9K_STATUS_OK_FOREGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
# POWERLEVEL9K_STATUS_OK_BACKGROUND="$DEFAULT_BACKGROUND"
# POWERLEVEL9K_STATUS_OK_BACKGROUND="$(( $DEFAULT_BACKGROUND + 2 ))"
# POWERLEVEL9K_STATUS_ERROR_FOREGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
# POWERLEVEL9K_STATUS_ERROR_BACKGROUND="$DEFAULT_BACKGROUND"
# POWERLEVEL9K_STATUS_ERROR_BACKGROUND="$(( $DEFAULT_BACKGROUND + 2 ))"

# POWERLEVEL9K_HISTORY_FOREGROUND="$DEFAULT_FOREGROUND"


# POWERLEVEL9K_USER_ICON="\uF415" # 
# POWERLEVEL9K_USER_DEFAULT_FOREGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_USER_DEFAULT_BACKGROUND="$DEFAULT_BACKGROUND"
# POWERLEVEL9K_USER_ROOT_FOREGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_USER_ROOT_BACKGROUND="$DEFAULT_BACKGROUND"
# POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="magenta"
# POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="$DEFAULT_BACKGROUND"
# POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="$(( $DEFAULT_BACKGROUND + 2 ))"
# POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="$(( $DEFAULT_BACKGROUND - 2 ))"
# POWERLEVEL9K_ROOT_ICON=$'\uF198'  #
# POWERLEVEL9K_SSH_FOREGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_SSH_FOREGROUND="yellow"
# POWERLEVEL9K_SSH_BACKGROUND="$DEFAULT_BACKGROUND"
# POWERLEVEL9K_SSH_BACKGROUND="$(( $DEFAULT_BACKGROUND + 2 ))"
# POWERLEVEL9K_SSH_BACKGROUND="$(( $DEFAULT_BACKGROUND - 2 ))"
# POWERLEVEL9K_SSH_ICON="\uF489"  # 
# POWERLEVEL9K_HOST_LOCAL_FOREGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_HOST_LOCAL_BACKGROUND="$DEFAULT_BACKGROUND"
# POWERLEVEL9K_HOST_REMOTE_FOREGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_HOST_REMOTE_BACKGROUND="$DEFAULT_BACKGROUND"
# POWERLEVEL9K_HOST_ICON_FOREGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_HOST_ICON_BACKGROUND="$DEFAULT_BACKGROUND"
# POWERLEVEL9K_HOST_ICON="\uF109" # 
# POWERLEVEL9K_OS_ICON_FOREGROUND="$DEFAULT_FOREGROUND"
# POWERLEVEL9K_OS_ICON_BACKGROUND="$DEFAULT_BACKGROUND"


# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
# POWERLEVEL9K_RAM_BACKGROUND='yellow'
# POWERLEVEL9K_HOME_ICON=''
# POWERLEVEL9K_HOME_SUB_ICON=''
# POWERLEVEL9K_FOLDER_ICON=''
# POWERLEVEL9K_STATUS_CROSS=true

##############
# Other Stuff #
##############
source ~/z.sh # Sourcing z 

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /home/hugo/.config/broot/launcher/bash/br
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

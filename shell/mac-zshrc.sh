# Default Mac Path
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=$PATH:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin

# Home Brew
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH

# Editors
export EDITOR=vim
export VISUAL=vim

# Add Visual Studio Code (code)
export PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin

# Standard Shell Tool Aliases
alias ll='ls -AlhF --color=always'

# To see if a command is aliased, a file, or a built-in command
alias checkcommand="type -t"

# Change Directory Aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Git Aliases
alias g='git status'
alias gfp='git fetch && git pull'
alias gp='git push'
alias ga='git add'
alias gc='git commit -m'
alias gco='git checkout'
alias gl='git lg'
alias glo='git log --oneline'

branch=$(git symbolic-ref --short HEAD)
alias gr='git reset --hard origin/$branch'
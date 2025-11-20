# ~/.bashrc

[[ $- != *i* ]] && return

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth
shopt -s histappend

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export PATH="/opt/nvim/bin:$PATH"
export PATH="/opt/nvim-linux-x86_64/bin:/opt/nvim/bin:$PATH"

eval "$(starship init bash)"

alias ll='ls -alF'
alias yeet-up='git push --set-upstream origin'

echo -e "\033[1;36m"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                                                           ║"
echo "║        █████╗ ██╗██████╗  █████╗ ███╗   ██╗               ║"
echo "║       ██╔══██╗██║██╔══██╗██╔══██╗████╗  ██║               ║"
echo "║       ███████║██║██║  ██║███████║██╔██╗ ██║               ║"
echo "║       ██╔══██║██║██║  ██║██╔══██║██║╚██╗██║               ║"
echo "║       ██║  ██║██║██████╔╝██║  ██║██║ ╚████║               ║"
echo "║       ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝               ║"
echo "║                                                           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "\033[0m"
echo -e "\033[1;33m👤 User:\033[0m $(whoami)"
echo -e "\033[1;33m📅 Date:\033[0m $(date '+%A, %B %d, %Y - %I:%M %p')"
echo -e "\033[1;33m💻 Host:\033[0m $(hostname)"
echo -e "\033[1;32m🚩 Wired In Dawggg\033[0m"
echo ""

tmux

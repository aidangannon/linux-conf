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

export PATH="/usr/local/bin/tmux:$PATH"

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$HOME/.dotnet:$PATH

eval "$(starship init bash)"

alias ll='ls -alF'
alias git-up='git push --set-upstream origin'
alias git-rollback='git reset --hard'
alias netdbg='netcoredbg --interpreter=cli --attach'
alias nettest='dotnet test --filter '
alias nettest-dbg='VSTEST_HOST_DEBUG=1 dotnet test --filter '

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

if [ -z "$TMUX" ]; then
    tmux kill-session -t dev 2>/dev/null
    tmux new-session -s dev
fi

ydle()
{
    tmux split-window -h -p 20 -c "$current_dir" \; \
        split-window -v -p 35 \; \
        select-pane -t 0 \; \
        split-window -v -p 15 -c "$current_dir" \; \
        select-pane -t 0 \; \
        send-keys -t 0 "nvim" C-m \; \
        send-keys -t 2 "cd $(pwd) && clear" C-m \; \
        send-keys -t 3 "cd ~ && clear" C-m \; \
        send-keys -t 1 "cd $(pwd) && claude --permission-mode plan" C-m
}

alias netcoredbg="/usr/local/bin/netcoredbg/netcoredbg"

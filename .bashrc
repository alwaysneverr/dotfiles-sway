#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

fastfetch

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -la --color=auto'
alias update='sudo emerge -avuD --keep-going @world'
alias clean='sudo emerge -a --depclean && sudo eclean-dist -d'
alias fetch='clear && fastfetch'
alias poweroff='sudo poweroff'
alias reboot='sudo reboot'
alias suspend='loginctl suspend'
alias ..='cd ..'
alias ...='cd ../..'
alias config-i3='nano ~/.config/sway/config'
alias config-bar='nano ~/.config/waybar/config.jsonc'
alias config-bash='nano ~/.bashrc'
alias config-kitty='nano ~/.config/kitty/kitty.conf'
alias mem='free -h'
alias jc='sudo dmesg -l emerg,alert,crit,err'
alias ping-test='ping -c 4 1.1.1.1'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias fastfetch='clear && fastfetch'
alias psync='sudo emerge --sync'
alias rs='rc-status'
alias svc='sudo rc-service'

PS1='\[\033[38;2;236;197;135m\]\u\[\033[0m\]@\[\033[38;2;224;62;62m\]\h\[\033[0m\]:\[\033[38;2;238;222;200m\]\w\[\033[0m\]\$ '

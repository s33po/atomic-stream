#!/usr/bin/env bash

set -xeuo pipefail

# Set some bash aliases
cat << 'EOF' > /etc/profile.d/bash_aliases.sh
alias ls='ls --color=auto'
alias ll='ls -la'
alias ..='cd ..'                 
alias ...='cd ../..'             
alias grep='grep --color=auto'  
alias myip='curl ifconfig.me'              
alias fixperms='sudo chown -R $USER:$USER'
alias please='sudo $(fc -ln -1)'
alias defpaks='xargs -a /etc/flatpaks/defpaks.list -r flatpak install -y --noninteractive flathub && echo "Flatpak installation complete!"'
EOF

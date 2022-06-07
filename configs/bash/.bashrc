# LOCALS HERE
echo -ne "\033[1;33mWARNING: it is your real system shell, be careful!\033[0m\n"

alias on="source venv/bin/activate"
alias off="deactivate"
alias vm="mv"
export PODMAN_USERNS="keep-id"
export GID="`id -g $USER`"
export GROUP_ID="$GID"
export USER_ID="`id -g $USER`"

export HISTSIZE=20000
export HISTFILESIZE=20000
export PATH="$USER/.local/bin:$PATH"
# LOCALS END

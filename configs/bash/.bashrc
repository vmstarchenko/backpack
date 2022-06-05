# LOCALS HERE
echo -ne "[1;33mWARNING: it is your real system shell, be careful![0m
"

alias on="source venv/bin/activate"
alias off="deactivate"
alias vm="mv"

export HISTSIZE=20000
export HISTFILESIZE=20000
export PATH="$USER/.local/bin:$PATH"
# LOCALS END
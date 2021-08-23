# aliasees
alias g='git'
alias repos='cd /var/git/'
alias vim='nvim'
alias vi='nvim'


getCurrentBranch() {
    if [ -z "$(git branch 2>/dev/null)" ]; then
        echo ""
    else
        if [ "$(git status --porcelain)" ]; then
            printf ' [*]'
        fi
            echo " (on: $(git branch 2>/dev/null | command grep '^*' | colrm 1 2 ))"
    fi
}

setopt prompt_subst

#⚡

PS1="%F{red}%n%f %F{yellow}%d%f\$(getCurrentBranch) ⚡ "

# Envvars
export NVM_DIR="$HOME/.nvm"
export PYTHONDONTWRITEBYTECODE=1

[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

export PNPM_HOME="/Users/pino/.nvm/versions/node/v14.17.2/pnpm-global/5/node_modules/.pnpm/pnpm@6.11.0/node_modules/pnpm/bin"
export PATH="$PNPM_HOME:$PATH"

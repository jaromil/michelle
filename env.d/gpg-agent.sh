# gnupg agent
GPG_TTY=$(tty)
export GPG_TTY
SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
export SSH_AUTH_SOCK


[[ -f "${HOME}/.gpg-agent-info" ]] && {
    source "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    #    export SSH_AUTH_SOCK
    #    export SSH_AGENT_PID
}

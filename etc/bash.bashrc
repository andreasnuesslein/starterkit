# this file is sourced by all bash shells on startup

# test for interactive shell
[[ $- != *i* ]] && return

source "/etc/bash_color.sh"
source "/etc/bash_prompt.sh"

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

#######################
## setup environment ##
#######################

# find a usable locale
eval unset ${!LC_*} LANG
export LANG="en_US.UTF-8"
export LC_ALL="en_US.utf8"
export LC_COLLATE="C"

# force a sane editor
export EDITOR=/usr/bin/vim

# pager options
if hash less; then
	export PAGER=less
	export MANPAGER=less
	export LESS="-R --ignore-case --long-prompt"
fi


########################
## bash configuration ##
########################

# keep size of history small ...
export HISTCONTROL="ignoreboth:erasedups"

# ... but keep a lot of history
export HISTFILESIZE=20000
export HISTSIZE=20000

# save timestamp in history
export HISTTIMEFORMAT="%Y-%m-%d [%T] "

# check window size after each command
shopt -s checkwinsize

# save multi-line command as one line
shopt -s cmdhist

# append history
shopt -s histappend

# PgUp PgDn Hack
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

# stty - turn off that @!#$&!@# ctrl-s/q sheel-freeze-stuff
stty -ixon -ixoff

# Ctrl-Q does a Ctrl-W w/ slashes
bind -r "\C-q"
bind '"\C-q": unix-filename-rubout'



#####################
## command aliases ##
#####################

# ls helpers
alias ll="ls -l"
alias la="ls -la"
alias l="ls -lh"
alias l.="l -d .*"
alias lt="ls -lhtr"

# cd helpers
# dirty hack since you cannot define a function called '..'
dotdot() {
	local cdpath=""
	local num=${1:-1}

	while [[ ${num} -gt 0 ]]; do
		cdpath="${cdpath}../"
		num=$((num - 1))
	done

	cdpath="${cdpath}${2}"
	cd ${cdpath}
}

alias ..="dotdot 1"
alias ...="dotdot 2"
alias ....="dotdot 3"

# make default what should be default
alias sudo="sudo -H"
alias root="sudo -i"


# ssh helper
alias sshlive='ssh -l root -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null" -o "GlobalKnownHostsFile /dev/null"'

# pydf has nicer output
if hash pydf &>/dev/null; then
	alias df=pydf
fi

# mkdir + chdir
mkcd() {
	mkdir -p "$1" && cd "$1"
}

# tmux helper
T() {
	TERM=screen-256color-bce tmux attach -t ${1:-default} || TERM=screen-256color-bce tmux new -s ${1:-default}
}


# load local bashrc if it exists
if [[ -e ${HOME}/.bashrc.local ]]; then
	source ${HOME}/.bashrc.local
fi

# bash-complete sc and jf. for some reason this needs to happen pretty late
# (i.e. here).
_completion_loader systemctl
complete -F _systemctl sc
_completion_loader journalctl
complete -F _journalctl jf


export PATH="${PATH}:/sbin:/usr/sbin:~/.bin"
#
#~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
#
#
#
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
		PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPTCOMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

		;;
	screen*)
		PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
		;;
esac

[ -r /usr/share/bash-completion/bash_completion  ] && . /usr/share/bash-completion/bash_completion

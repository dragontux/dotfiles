# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' expand prefix
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' max-errors 10 numeric
zstyle ':completion:*' original true
zstyle :compinstall filename '/home/daem0n/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
# Mah custom stuff
autoload -U colors && colors

alias ls="ls --color=auto"
alias l="ls"
alias ll="ls -l"
alias la="ls -a"
alias td="todo.sh"

alias c="cd"

CCACHE_TOOLS="/usr/lib/ccache/bin"
DISTCC_TOOLS="/usr/lib/distcc/bin"

USER_TOOLS="$HOME/bin"
CORE_TOOLS="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/core_perl:/usr/bin/vendor_perl"

STDTOOLS="$USER_TOOLS:$CORE_TOOLS"
export PATH="$STDTOOLS"
export PS2="  │ "
export EDITOR=vim
USERCOLOR="green"
export ABSROOT=$HOME/abs

stackthing=()
stackptr=1
stackcur=0

distcc_enabled=0

function push {
	if [[ $1 != "" ]]; then
		pushvar=$1
	else
		pushvar=$stackcur
	fi

	stackthing[$((stackptr++))]=$pushvar
	stackcur=$pushvar
}

function pop {
	if [[ $stackptr > 1 ]]; then
		echo $stackthing[$((--stackptr))]
		stackcur=$stackthing[$stackptr]
	fi
}

function dumpstack {
	for (( i=1; i < stackptr; i++ )); do
		echo $stackthing[$((i))];
	done
}

function chpwd { 
	ls
}

function preexec {
	USERSTRING="%{$fg_bold[$USERCOLOR]%}%n%{$reset_color%}"
	HOSTSTRING="%{$fg_bold[black]%}%m%{$reset_color%}"
	PROMPT=\
"┆ %~ | $USERSTRING@$HOSTSTRING | %*
└─┤ "
}
function unused {

	PROMPT="$fg_bold[black][$reset_color%~$fg_bold[black]]$reset_color "
	PROMPT="[$USERSTRING] @ [$HOSTSTRING] %~ $ "
}

function forkp {
	if [ -z "$1" ]; then return 1; fi

	if which $1 > /dev/null; then
		cmdline="$@"
		$SHELL -c "$cmdline & exit"
	fi
}

function privatezsh {
	HISTFILE=/dev/null
	HISTSIZE=0
	SAVEHIST=0
}

function unprivatezsh { 
	HISTFILE=~/.histfile
	HISTSIZE=1000
	SAVEHIST=1000
}

function safeexit {
	privatezsh
	exit
}

function enable_distcc {
	distcc_enabled=1;

	export PATH="$DISTCC_TOOLS:$STDTOOLS"
}

function disable_distcc {
	distcc_enabled=0;
	export PATH="$STDTOOLS"
}

# Small function to read a file into command buffer for editing
function zsrc {
	if [ $# -eq 1 ]; then
		print -z "`cat $1`"
	fi
}

# stylin'
echo -n $fg[$USERCOLOR]
cat ~/misc/welcome_graphic.txt
echo $reset_color
preexec

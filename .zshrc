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

# Various paths
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

# global variables for some functions below
stackthing=()
stackptr=1
stackcur=0

distcc_enabled=0

# push something onto the stack
function push {
	if [[ $1 != "" ]]; then
		pushvar=$1
	else
		pushvar=$stackcur
	fi

	stackthing[$((stackptr++))]=$pushvar
	stackcur=$pushvar
}

# pop something off the stack
function pop {
	if [[ $stackptr > 1 ]]; then
		echo $stackthing[$((--stackptr))]
		stackcur=$stackthing[$stackptr]
	fi
}

# dump the current stack
function dumpstack {
	for (( i=1; i < stackptr; i++ )); do
		echo $stackthing[$((i))];
	done
}

# Commands to be executed after changing directory
function chpwd { 
	ls
}

# Commands to be executed before displaying the prompt
function preexec {
	USERSTRING="%{$fg_bold[$USERCOLOR]%}%n%{$reset_color%}"
	HOSTSTRING="%{$fg_bold[black]%}%m%{$reset_color%}"
	PROMPT=\
"┆ %~ | $USERSTRING@$HOSTSTRING | %*
└─┤ "
}

# old preexec function
function unused {

	PROMPT="$fg_bold[black][$reset_color%~$fg_bold[black]]$reset_color "
	PROMPT="[$USERSTRING] @ [$HOSTSTRING] %~ $ "
}

# fork to the background, under the init process
function forkp {
	if [ -z "$1" ]; then return 1; fi

	if which $1 > /dev/null; then
		cmdline="$@"
		$SHELL -c "$cmdline & exit"
	fi
}

# disable saving any history
function privatezsh {
	HISTFILE=/dev/null
	HISTSIZE=0
	SAVEHIST=0
}

# re-enable saving history
function unprivatezsh { 
	HISTFILE=~/.histfile
	HISTSIZE=1000
	SAVEHIST=1000
}

# exit without saving any history
function safeexit {
	privatezsh
	exit
}

# insert the path of distcc utils into $PATH
function enable_distcc {
	distcc_enabled=1;

	export PATH="$DISTCC_TOOLS:$STDTOOLS"
}

# remove distcc utils from $PATH
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

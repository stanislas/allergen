
export M2_REPO=~/.m2/repository
export ANT_OPTS="-Xmx2048m -Xms2048m -Djava.awt.headless=true"

setjdk() {
  export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}

if [[ `uname` == 'Darwin' ]]; then
    setjdk 1.7
fi

export PATH=~/Library/soft/bin:/usr/local/bin:~/Library/PackageManager/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:~/engineering/tools/crsh/target/bin:/usr/texbin

export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

### VBox

alias vbox-oracle-start="VBoxManage startvm 8bb8b96c-2536-4705-acd5-e5bf46756775 --type headless"
alias vbox-oracle-stop="VBoxManage controlvm 8bb8b96c-2536-4705-acd5-e5bf46756775 poweroff"

### Gradle

alias gcd='./gradlew --rerun-tasks clean assemble'
alias gcdt='./gradlew --rerun-tasks clean assemble test'

## Mercurial
alias hg-pull-merge-push-pull='hg pull && hg merge && hg ci -m "merge" && hg push && hg pull -u'


## GPG
export LEIN_GPG=gpg2
alias gpg=gpg2
#envfile="$HOME/.gnupg/gpg-agent.env"
#if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
#    eval "$(cat "$envfile")"
#else
#    eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "$envfile")"
#fi
#export GPG_AGENT_INFO  # the env file does not contain the export statement
# export SSH_AUTH_SOCK   # enable gpg-agent for ssh
#GPG_TTY=`tty`
#export GPG_TTY


# Completion
autoload -U compinit
compinit

# Colors
autoload -U colors
colors

# Globbing
setopt extendedglob

# Prompt substitution
setopt prompt_subst

# autocd
setopt autocd

# Correction
#setopt correctall

# Advanced prompt support
autoload -U promptinit
promptinit

# autocd
setopt autocd

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
#setopt hist_ignore_all_dups
setopt hist_ignore_space

# Complete aliases
setopt completealiases

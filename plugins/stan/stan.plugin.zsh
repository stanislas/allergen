
export M2_REPO=~/.m2/repository
export ANT_OPTS="-Xmx2048m -Xms2048m -Djava.awt.headless=true"

setjdk() {
  export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}

if [[ `uname` == 'Darwin' ]]; then
    setjdk 1.8
fi

export PATH=~/Library/soft/bin:/usr/local/bin:~/Library/PackageManager/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:~/engineering/tools/crsh/target/bin:/Users/stan/Library/soft/context/tex/texmf-osx-64/bin:/usr/texbin:/Users/stan/.cargo/bin

#export GOPATH=$HOME/engineering/go
#export PATH=$PATH:/usr/local/go/bin

#export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -Xmx2048m -XX:+UseConcMarkSweepGC -d64"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export BOOT_JVM_OPTIONS="-Djava.awt.headless=true"

### localhost80

alias localhost80-enable="sudo pfctl -ef ~/Library/port-forwarding/pf-localeighty.conf"
alias localhost80-disable="sudo pfctl -df ~/Library/port-forwarding/pf-localeighty.conf"

### VBox

#alias vbox-oracle-start="VBoxManage startvm 8bb8b96c-2536-4705-acd5-e5bf46756775 --type headless"
#alias vbox-oracle-stop="VBoxManage controlvm 8bb8b96c-2536-4705-acd5-e5bf46756775 poweroff"

### Gradle

#alias gcd='./gradlew --rerun-tasks clean assemble'
#alias gcdt='./gradlew --rerun-tasks clean assemble test'

### git
alias git='noglob git'

## Mercurial
alias hg-pull-merge-push-pull='hg pull && hg merge && hg ci -m "merge" && hg push && hg pull -u'

## Postgresql
alias pgstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pgstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

##tvdxtat
alias tvdxtat="/Users/stan/Library/soft/tvdxtat/tvdxtat.sh"

##spectralogs
alias skylogs="envdir ${HOME}/.sky awslogs"
alias spectradevlogs="envdir ${HOME}/.spectradev awslogs"

## GPG
export LEIN_GPG=gpg
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

#sqlplus
#export DYLD_LIBRARY_PATH='/Users/stan/Library/soft/instantclient_11_2'
#export TNS_ADMIN=$DYLD_LIBRARY_PATH
#export PATH=$PATH:$DYLD_LIBRARY_PATH

#local runit
export SVDIR=/Users/stan/Library/service

#node
export PATH="/usr/local/opt/node@6/bin:$PATH"

#bellboy
alias tunnel-bellboy-qa="ssh -i ~/.ssh/aws-sky.pem -L4406:bef8-cluster.cluster-cz7wjvhcrwgr.eu-west-1.rds.amazonaws.com:3306  ec2-user@ec2-54-77-218-248.eu-west-1.compute.amazonaws.com"

#nix
#if [ -f /Users/stan/.nix-profile/etc/profile.d/nix.sh ]; then
#	. /Users/stan/.nix-profile/etc/profile.d/nix.sh
#fi

# Emacs

export EDITOR="vim"
alias e="emacsclient -t"
alias ec="emacsclient -c"
alias e-kill="emacsclient -e '(kill-emacs)'"

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

# Import secrets if they exists
if [ -s ~/.secrets ]
then
	source ~/.secrets
fi

if [ -s ~/.opam/opam-init/init.zsh ]
then
	 . ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
fi

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# leda
alias leda-repl="docker exec -it leda-dev2 /root/work/leda/tools/repl-dev-docker.sh"
alias leda-bash="docker exec -it leda-dev2 /bin/bash"

# neutron core
alias nc-repl="docker exec -it neutron-core-dev /root/work/neutron-core/tools/repl-dev-docker.sh"
alias nc-bash="docker exec -it neutron-core-dev /bin/bash"

# monolith 
alias mono-repl="docker exec -it monolith-dev /root/work/monolith/tools/repl-dev-docker.sh"
alias mono-bash="docker exec -it monolith-dev /bin/bash"

# timeflow 
alias tf-repl="docker exec -it timeflow-dev /root/work/timeflow/tools/repl-dev-docker.sh"
alias tf-bash="docker exec -it timeflow-dev /bin/bash"

# anaconda
export PATH="/Users/stan/anaconda/bin:$PATH"
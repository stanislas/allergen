setjdk() {
  export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}

if [[ `uname` == 'Darwin' ]]; then
    setjdk 17
fi

#export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -Xmx2048m -XX:+UseConcMarkSweepGC -d64"

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
alias git-codesmith-clone='git clone -c credential.useHttpPath=true -c credential.helper='"'"'!/usr/local/bin/aws codecommit --profile=codesmith credential-helper $@'"'"

## Mercurial
alias hg-pull-merge-push-pull='hg pull && hg merge && hg ci -m "merge" && hg push && hg pull -u'

## Postgresql
alias pgstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pgstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

##tvdxtat
alias tvdxtat="/Users/stan/Library/soft/tvdxtat/tvdxtat.sh"

##
alias brewery="brew update && brew upgrade && brew cleanup"

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

#nix
#if [ -f /Users/stan/.nix-profile/etc/profile.d/nix.sh ]; then
#	. /Users/stan/.nix-profile/etc/profile.d/nix.sh
#fi

# pyenv
#if command -v pyenv 1>/dev/null 2>&1; then
#  eval "$(pyenv init -)"
#fi

# poetry
alias pact='source "$( poetry env info --path )/bin/activate"'

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

# git svn on mac os Catalina
export PERL5LIB=/usr/local/opt/subversion/lib/perl5/site_perl/5.30.2/darwin-thread-multi-2level

# graalvm on mac
export GRAALVM_HOME=/Users/stan/Library/soft/graalvm-ce-java17-22.2.0-dev/Contents/Home

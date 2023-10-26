# Filename: git-back-to.plugin.zsh
#compdef git-back-to

_git-back-to() {
 local branches
  branches=($(git for-each-ref --format='%(refname:short)' refs/heads/))

  _arguments \
    '1:branches:->branches' \
    '*:: :->args'

  case $state in
    (branches)
      _describe 'branches' branches && ret=0
      ;;
    (args)
      # Your custom arguments and options for the mycommand subcommand
      # ...
      ;;
  esac
}

_git-back-to "$@"
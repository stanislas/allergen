# Filename: git-back-to.plugin.zsh
#compdef git-back-to

_git-back-to() {
  local branches
  branches=($(git for-each-ref --format='%(refname:short)' refs/heads/))
  _describe 'branches' branches && ret=0
}

_git-back-to "$@"
#
# Load Antigen
#
source /usr/local/share/antigen/antigen.zsh

#
# Load the oh-my-zsh's library.
#
antigen use oh-my-zsh

#
# Antigen Bundles
#
antigen bundle git
#antigen bundle gpg-agent
antigen bundle stanislas/allergen plugins/stan
#antigen bundle stanislas/allergen plugins/lvri

#
# Antigen Theme
#
antigen theme stanislas/allergen themes/stan

#
# Tell antigen that you're done.
#
antigen apply

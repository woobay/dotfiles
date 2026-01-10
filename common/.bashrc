#!/bin/bash

# Load common configs
[ -f ~/.bash_exports ] && source ~/.bash_exports
[ -f ~/.bash_inits ] && source ~/.bash_inits
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bash_functions ] && source ~/.bash_functions

#Job
[ -f ~/.bash_functions ] && source ~/.bash_bell

# opencode
export PATH=/home/woobay/.opencode/bin:$PATH

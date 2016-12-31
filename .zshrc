setopt appendhistory autocd extendedglob notify
unsetopt beep nomatch

autoload -Uz promptinit
promptinit

# Keep history
setopt inc_append_history
setopt share_history
HISTSIZE=10000
if (( ! EUID )); then
  HISTFILE=~/.history_root
else
  HISTFILE=~/.history
fi
SAVEHIST=10000

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
autoload -U colors zsh/terminfo
colors

LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

setopt promptsubst

# Completion.
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

# Aliases
alias cp='cp -i'
alias rcp='rsync -v --progress'
alias rmv='rsync -v --progress --remove-source-files'
alias mv='mv -i'
alias rm='rm -i'
alias chmod="chmod -c"
alias chown="chown -c"
alias ls='ls --color=auto'


bindkey -v
bindkey "^R" history-incremental-pattern-search-backward 
bindkey "^S" history-incremental-pattern-search-forward
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Prompt
setprompt() {
  setopt prompt_subst

  if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then 
    p_host='%F{yellow}%M%f'
  else
    p_host='%F{green}%M%f'
  fi

#  PS1=${(j::Q)${(Z:Cn:):-$'
#    %F{cyan}%f
#    %(!.%F{red}%n%f.%F{green}%n%f)
#    %F{cyan}@%f
#    ${p_host}
#    %F{cyan}[%f
#    %F{green}%~%f
#    %F{cyan}]%f
#    %(!.%F{red}%#%f.%F{green}>#%f)
#    " "
#  '}}
  PS1=${(j::Q)${(Z:Cn:):-$'
    %F{cyan}%f
    %(!.%F{red}%n%f.%F{green}%n%f)
    %F{cyan}@%f
    ${p_host}
    %F{cyan}[%f
    %F{green}%~%f
    %F{cyan}]%f
    %(!.%F{red}%#%f.>#%f)
    " "
  '}}

  PS2=$'%_>'
  RPROMPT=$'${vcs_info_msg_0_}'
}
setprompt

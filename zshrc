# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep extendedglob nomatch
bindkey -v

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/roridev/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall

bindkey  "^[[3~"  delete-char

autoload -U +X bashcompinit && bashcompinit
eval "$(stack --bash-completion-script stack)"

source /usr/share/zsh/share/antigen.zsh

antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle xPMo/zsh-ls-colors

antigen theme romkatv/powerlevel10k

antigen apply

alias glog="git log --oneline --graph"
alias gloga="glog --all"
alias gss="git status --short"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

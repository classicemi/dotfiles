# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Ghostty's shell integration overrides cursor style to bar (beam) via zle-line-init.
# Remove 'cursor' from GHOSTTY_SHELL_FEATURES so the integration skips cursor handling,
# preserving the block cursor set in ghostty config.
GHOSTTY_SHELL_FEATURES="${GHOSTTY_SHELL_FEATURES/cursor,/}"
GHOSTTY_SHELL_FEATURES="${GHOSTTY_SHELL_FEATURES/,cursor/}"
GHOSTTY_SHELL_FEATURES="${GHOSTTY_SHELL_FEATURES/cursor/}"

# If you come from bash you might have to change your $PATH.
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH=/opt/homebrew/opt/fzf/bin:$PATH

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone git@github.com:zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "$ZINIT_HOME/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins (using turbo mode for faster startup)
zinit wait lucid for \
  atinit"zicompinit; zicdreplay" \
    zsh-users/zsh-syntax-highlighting \
  blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab

# Load oh-my-zsh libs and plugins
zinit snippet OMZL::directories.zsh  # .. ... .... cd shortcuts
zinit snippet OMZP::common-aliases   # ll la l etc.

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls="ls --color"
alias vi="nvim"
alias hs="httpstat"

alias rp="cd ~/workspace/play/react-playground"

# Shell integrations
eval "$(fzf --zsh)"

# Set Proxy
function proxy() {
    export {http,https,ftp}_proxy="127.0.0.1:7890"
    export {HTTP,HTTPS,FTP}_PROXY="127.0.0.1:7890"
    export GO111MODULE=on
    export GOPROXY=https://goproxy.cn
    export ELECTRON_GET_USE_PROXY=true
    export GLOBAL_AGENT_HTTP_PROXY=http://127.0.0.1:7890
    export GLOBAL_AGENT_HTTPS_PROXY=http://127.0.0.1:7890
}

# Unset Proxy
function noproxy() {
    unset {http,https,ftp}_proxy
    unset {HTTP,HTTPS,FTP}_PROXY
    unset GO111MODULE
    unset GOPROXY
    export ELECTRON_GET_USE_PROXY
    export GLOBAL_AGENT_HTTP_PROXY
    export GLOBAL_AGENT_HTTPS_PROXY
}

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm use default --silent
# nvm end

export PATH=$HOME/.local/bin:$PATH

NVIM_BEGINNER=~/.config/nvim-beginner
export NVIM_BEGINNER
alias nvb='XDG_DATA_HOME=$NVIM_BEGINNER/share XDG_CONFIG_HOME=$NVIM_BEGINNER nvim'

# pnpm
export PNPM_HOME="/Users/bytedance/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Added by Windsurf
export PATH="/Users/bytedance/.codeium/windsurf/bin:$PATH"

# cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Added by Antigravity
export PATH="/Users/bytedance/.antigravity/antigravity/bin:$PATH"

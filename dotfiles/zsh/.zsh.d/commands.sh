command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
NVM_SCRIPT="$NVM_DIR/nvm.sh"
if command -v brew >/dev/null; then
  BREW_NVM_SCRIPT="$(brew --prefix nvm 2>/dev/null)/nvm.sh"
  [[ -s "$BREW_NVM_SCRIPT" ]] && NVM_SCRIPT="$BREW_NVM_SCRIPT"
fi
[[ -s "$NVM_SCRIPT" ]] && source "$NVM_SCRIPT"
unset NVM_SCRIPT BREW_NVM_SCRIPT

if command -v starship >/dev/null && [[ "${TERM:-dumb}" != "dumb" ]]; then
  eval "$(starship init zsh)"
else
  PROMPT='%F{cyan}%n%f@%F{green}%m%f %F{blue}%~%f %# '
fi

# Optional; enable together with the commented direnv entry in the Brewfile.
# command -v direnv >/dev/null && eval "$(direnv hook zsh)"

if command -v fzf >/dev/null; then
  source <(fzf --zsh)
fi

install_hint() {
  local package="$1"
  if command -v brew >/dev/null; then
    print "brew install $package"
  elif [[ "$IS_LINUX" == true ]]; then
    print "Installiere '$package' mit dem Paketmanager deiner Distribution."
  fi
}

check_missing_tools() {
  [[ -o interactive ]] || return
  local tool package
  local -A wanted=(
    rg ripgrep fd fd fzf fzf zoxide zoxide eza eza bat bat
    gh gh lazygit lazygit jq jq stow stow starship starship
  )
  for tool package in ${(kv)wanted}; do
    if ! (( $+commands[$tool] )); then
      print -P "%F{yellow}Hinweis:%f $tool fehlt — $(install_hint "$package")"
    fi
  done
}

check_missing_tools

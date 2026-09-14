export GIT_EDITOR=vim
export EDITOR=vim
export VISUAL="$EDITOR"

# Persistent history shared by concurrent Zsh sessions.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS SHARE_HISTORY EXTENDED_HISTORY NO_NOMATCH

# Shared macOS/Linux detection for the remaining shell configuration.
export IS_MAC=false IS_LINUX=false IS_WSL=false
[[ "$OSTYPE" == darwin* ]] && export IS_MAC=true
[[ "$OSTYPE" == linux* ]] && export IS_LINUX=true
[[ -n "${WSL_DISTRO_NAME:-}" ]] && export IS_WSL=true

# Homebrew can live on Apple Silicon, Intel macOS, or Linux.
for brew_path in \
  /opt/homebrew/bin/brew \
  /usr/local/bin/brew \
  /home/linuxbrew/.linuxbrew/bin/brew; do
  if [[ -x "$brew_path" ]]; then
    eval "$($brew_path shellenv)"
    break
  fi
done

# Bitwarden exposes this socket after its SSH agent is enabled in the app.
[[ -S "$HOME/.bitwarden-ssh-agent.sock" ]] && \
  export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Prefer GNU utilities when their Homebrew packages are installed.
if command -v brew >/dev/null; then
  COREUTILS_GNUBIN="$(brew --prefix coreutils 2>/dev/null)/libexec/gnubin"
  FINDUTILS_GNUBIN="$(brew --prefix findutils 2>/dev/null)/libexec/gnubin"
  RUSTUP_BIN="$(brew --prefix rustup 2>/dev/null)/bin"
  [[ -d "$COREUTILS_GNUBIN" ]] && path=("$COREUTILS_GNUBIN" $path)
  [[ -d "$FINDUTILS_GNUBIN" ]] && path=("$FINDUTILS_GNUBIN" $path)
  [[ -d "$RUSTUP_BIN" ]] && path=("$RUSTUP_BIN" $path)
fi

typeset -U path PATH
path=("$HOME/.local/bin" "$HOME/bin" $path)

if command -v qwen >/dev/null; then
  QWEN_SYSTEM_MD=1
fi
# Prefer GNU tools over BSD ones
command -v gsed >/dev/null && alias sed='gsed'
command -v gawk >/dev/null && alias awk='gawk'

# Use bat's syntax highlighting when cat is entered interactively.
command -v bat >/dev/null && alias cat='bat'

if command -v eza >/dev/null; then
  alias ll='eza -lh --icons --git'
  alias la='eza -lah --icons --git'
  alias tree='eza --tree --icons --level=2'
fi


if command -v zed >/dev/null; then
  alias db='cd ~/DB && zed ~/DB/index.md'
  alias te='zed ~/DB/todo.txt'
else
  alias db='cd ~/DB && "$EDITOR" ~/DB/index.md'
  alias te='"$EDITOR" ~/DB/todo.txt'
fi

if command -v todo.sh >/dev/null; then
  alias todo='todo.sh'
  alias t='todo.sh'
  alias td='todo.sh done'
  alias ta='todo.sh add'
  alias tl='todo.sh list'
  alias tp='todo.sh pri'
fi

if command -v colima >/dev/null; then
  alias cst='colima start'
  alias csp='colima stop'
  alias cstt='colima status'
fi

# Use a project prompt when present, otherwise use the global Qwen prompt.
# An explicitly supplied QWEN_SYSTEM_MD always takes precedence.
qwen() {
  if [[ -n "${QWEN_SYSTEM_MD:-}" ]]; then
    command qwen "$@"
  elif [[ -f "$PWD/.qwen/system.md" ]]; then
    QWEN_SYSTEM_MD="$PWD/.qwen/system.md" command qwen "$@"
  else
    QWEN_SYSTEM_MD="$HOME/.qwen/system.md" command qwen "$@"
  fi
}

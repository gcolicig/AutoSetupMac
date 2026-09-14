# Antidote compiles the declarative plugin list into one fast source file.
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$ZSH_CACHE_DIR/completions"
zstyle ':omz:plugins:docker' completion-file "$ZSH_CACHE_DIR/completions/_docker"

autoload -Uz compinit
compinit

ANTIDOTE_SCRIPT=""
if command -v brew >/dev/null; then
  ANTIDOTE_SCRIPT="$(brew --prefix antidote 2>/dev/null)/share/antidote/antidote.zsh"
fi
[[ -r "$ANTIDOTE_SCRIPT" ]] || ANTIDOTE_SCRIPT="$HOME/.antidote/antidote.zsh"

if [[ -r "$ANTIDOTE_SCRIPT" ]]; then
    source "$ANTIDOTE_SCRIPT"

    # Build a platform-aware list without changing the tracked base file.
    # Tool- and OS-specific Oh My Zsh plugins are added only when applicable.
    ANTIDOTE_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
    ANTIDOTE_PLUGIN_FILE="$ANTIDOTE_CACHE_DIR/plugins.txt"
    mkdir -p "$ANTIDOTE_CACHE_DIR"
    command cat "$HOME/.zsh_plugins.txt" >| "$ANTIDOTE_PLUGIN_FILE"
    (( $+commands[git] )) && print 'ohmyzsh/ohmyzsh path:plugins/git' >> "$ANTIDOTE_PLUGIN_FILE"
    (( $+commands[sudo] )) && print 'ohmyzsh/ohmyzsh path:plugins/sudo' >> "$ANTIDOTE_PLUGIN_FILE"
    (( $+commands[brew] )) && print 'ohmyzsh/ohmyzsh path:plugins/brew' >> "$ANTIDOTE_PLUGIN_FILE"
    (( $+commands[docker] )) && print 'ohmyzsh/ohmyzsh path:plugins/docker' >> "$ANTIDOTE_PLUGIN_FILE"
    [[ "$IS_MAC" == true ]] && print 'ohmyzsh/ohmyzsh path:plugins/macos' >> "$ANTIDOTE_PLUGIN_FILE"
    antidote load "$ANTIDOTE_PLUGIN_FILE"
fi

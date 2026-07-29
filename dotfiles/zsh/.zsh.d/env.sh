export GIT_EDITOR=vim
export EDITOR=vim

# GNU coreutils (ls, cat, etc.)
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
# GNU findutils (find, xargs, etc.)
export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
# Rust toolchain installed by rustup (cargo, rustc, clippy, rust-analyzer)
export PATH="$HOME/.cargo/bin:$PATH"

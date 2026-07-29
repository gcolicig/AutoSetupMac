#!/usr/bin/env bash

set -euo pipefail

# Install Xcode Command Line Tools if not already installed
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  until xcode-select -p &>/dev/null; do
    sleep 5
  done
fi

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install applications via Brewfile
if [[ -f ./Brewfile ]]; then
  echo "Installing applications from Brewfile..."
  brew bundle --file=./Brewfile
else
  echo "Warning: Brewfile not found in current directory"
fi

# Set up the Rust toolchain. Homebrew's rustup is keg-only and ships no toolchain,
# so it has to be initialised explicitly before cargo, rustc or clippy exist.
if ! command -v rustup &>/dev/null && [[ -x "$(brew --prefix rustup)/bin/rustup-init" ]]; then
  echo "Initialising Rust toolchain..."
  "$(brew --prefix rustup)/bin/rustup-init" -y --no-modify-path
fi
if [[ -x "$HOME/.cargo/bin/rustup" ]]; then
  "$HOME/.cargo/bin/rustup" component add clippy rust-analyzer
fi

# Install Zap ZSH plugin manager
if [[ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}/zap" ]]; then
  echo "Installing Zap ZSH plugin manager..."
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
  echo "Removing .zshrc so stow can manage it..."
  rm -f ~/.zshrc
fi

# Re-source Homebrew env just in case
eval "$(/opt/homebrew/bin/brew shellenv)"

# Use GNU Stow to symlink dotfiles
echo "Setting up dotfiles with GNU Stow..."
stow --target="$HOME" --dir=./dotfiles zsh vim nvim aerospace

# Optionally restart the shell
exec zsh -l

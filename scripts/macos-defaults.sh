#!/usr/bin/env bash

set -euo pipefail

# Keep the Dock compact and responsive for a keyboard-first macOS workflow.
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.15
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock show-recents -bool false

killall Dock 2>/dev/null || true

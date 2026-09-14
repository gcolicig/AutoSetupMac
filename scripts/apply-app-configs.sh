#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

install_if_missing() {
	local source="$1"
	local target="$2"

	if [[ -e "$target" ]]; then
		echo "Keeping existing configuration: $target"
		return
	fi

	mkdir -p "$(dirname -- "$target")"
	install -m 600 "$source" "$target"
	echo "Installed configuration: $target"
}

install_if_missing "$REPO_DIR/config/omlx/settings.json" "$HOME/.omlx/settings.json"
install_if_missing "$REPO_DIR/config/orbstack/docker.json" "$HOME/.orbstack/config/docker.json"
install_if_missing "$REPO_DIR/config/orbstack/vmconfig.json" "$HOME/.orbstack/vmconfig.json"

# Ice preferences intentionally omit window positions, status-item positions,
# migration flags and update metadata from the local export.
defaults write com.jordanbaird.Ice AutoRehide -bool true
defaults write com.jordanbaird.Ice CanToggleAlwaysHiddenSection -bool true
defaults write com.jordanbaird.Ice EnableAlwaysHiddenSection -bool true
defaults write com.jordanbaird.Ice EnableSecondaryContextMenu -bool false
defaults write com.jordanbaird.Ice HideApplicationMenus -bool true
defaults write com.jordanbaird.Ice IceBarLocation -int 2
defaults write com.jordanbaird.Ice ItemSpacingOffset -int 0
defaults write com.jordanbaird.Ice RehideInterval -int 30
defaults write com.jordanbaird.Ice RehideStrategy -int 1
defaults write com.jordanbaird.Ice SectionDividerStyle -int 1
defaults write com.jordanbaird.Ice ShowAllSectionsOnUserDrag -bool true
defaults write com.jordanbaird.Ice ShowIceIcon -bool true
defaults write com.jordanbaird.Ice ShowOnClick -bool false
defaults write com.jordanbaird.Ice ShowOnHover -bool false
defaults write com.jordanbaird.Ice ShowOnHoverDelay -float 0.2
defaults write com.jordanbaird.Ice ShowOnScroll -bool true
defaults write com.jordanbaird.Ice TempShowInterval -int 30
defaults write com.jordanbaird.Ice UseIceBar -bool true

echo "Restart Ice to apply its preferences."

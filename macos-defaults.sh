#!/usr/bin/env bash

set -euo pipefail

echo "Configuring macOS defaults..."

# Dock and Mission Control
defaults write com.apple.dock orientation -string "bottom"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.15
defaults write com.apple.dock tilesize -int 32
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock launchanim -bool false

# Disable all Hot Corners.
defaults write com.apple.dock wvous-tl-corner -int 1
defaults write com.apple.dock wvous-tr-corner -int 1
defaults write com.apple.dock wvous-bl-corner -int 1
defaults write com.apple.dock wvous-br-corner -int 1

# Optional: keep the Dock effectively hidden. This supersedes the normal reveal
# delay above, so enable both lines together only if that behavior is wanted.
# defaults write com.apple.dock autohide -bool true
# defaults write com.apple.dock autohide-delay -float 100000

# Finder
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder CreateDesktop -bool false
defaults write com.apple.finder ShowRecentTags -bool false
defaults write com.apple.finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder ShowTabView -bool true
defaults write com.apple.finder FinderSpawnTab -bool true
defaults write com.apple.finder FXRemoveOldTrashItems -bool true
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# Optional: allow Finder to be quit like a regular application.
# defaults write com.apple.finder QuitMenuItem -bool true

# Showing hidden files is deliberately omitted: it makes everyday Finder views noisy.
# Screenshots
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location "$HOME/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture show-thumbnail -bool false
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture include-date -bool true

# Keyboard and text input
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false
defaults write NSGlobalDomain WebAutomaticTextCompletionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticTextReplacementEnabled -bool false

# Pre-Tahoe/AppKit-style window corner radius. Restart apps to apply it.
defaults write NSGlobalDomain NSConvolutionOverride1 -float 10

# Trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# General UI
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Maximize"
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0
defaults write NSGlobalDomain NSWindowShouldDragOnGesture -bool true
defaults write NSGlobalDomain AppleScrollerPagingBehavior -bool true
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Window tiling / snapping
defaults write com.apple.WindowManager EnableTilingByEdgeDrag -bool true
defaults write com.apple.WindowManager EnableTopTilingByEdgeDrag -bool true
defaults write com.apple.WindowManager EnableTilingOptionAccelerator -bool true
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool true

# Optional clean-session behavior. Enable individually if apps and login
# sessions should not restore their previous windows automatically.
# defaults write com.apple.loginwindow TALLogoutSavesState -bool false
# defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Discover services advertised on all active network interfaces.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Built-in applications
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false 2>/dev/null ||
	echo "Warning: Mail preferences are protected; see docs/MANUAL_STEPS.md#protected-app-preferences."
defaults write com.apple.Terminal SecureKeyboardEntry -bool true
defaults write com.apple.Terminal ShowLineMarks -int 0

# Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true 2>/dev/null ||
	echo "Warning: Safari preferences are protected; configure Safari manually as described in docs/MANUAL_STEPS.md."
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true 2>/dev/null || true
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true 2>/dev/null || true
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false 2>/dev/null || true

# Developer tools and Activity Monitor
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool true
defaults write com.apple.dt.Xcode DVTTextShowLineNumbers -bool true
defaults write com.apple.dt.Xcode DVTTextShowPageGuide -bool true
defaults write com.apple.dt.Xcode DVTTextPageGuideLocation -int 120
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
defaults write com.apple.ActivityMonitor ShowCategory -int 0
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
defaults write com.apple.ActivityMonitor IconType -int 5

# Disk Utility developer and disk-image options.
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

# Show detailed crash reports suitable for development and debugging.
defaults write com.apple.CrashReporter DialogType -string "developer"

# Archive Utility: move successfully extracted source archives to the Trash.
defaults write com.apple.archiveutility dearchive-move-after -string "$HOME/.Trash" 2>/dev/null ||
	echo "Warning: Archive Utility preferences are protected; configure it manually as described in docs/MANUAL_STEPS.md."

# Optional: do not reveal extracted items automatically after unpacking.
# defaults write com.apple.archiveutility dearchive-open-after -bool false

# Software updates. Gatekeeper/quarantine deliberately remains enabled.
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

# Not recommended: disabling download quarantine weakens Gatekeeper protection.
# Kept as documentation only; do not enable without a specific reason.
# defaults write com.apple.LaunchServices LSQuarantine -bool false

killall Dock Finder SystemUIServer WindowManager cfprefsd 2>/dev/null || true

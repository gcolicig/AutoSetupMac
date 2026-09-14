# Manual macOS settings

These settings are not automated because their UI or preference keys can change
between macOS releases.

## Window management

The bootstrap enables the known macOS window tiling / snapping defaults. In
**System Settings → Desktop & Dock**, review after running it:

- Tile by dragging windows to screen edges: enabled
- Drag windows to the menu bar to fill the screen: enabled
- Hold Option while dragging windows to tile: enabled
- Hold the pointer over the green button to show tiling options: enabled
- Move tiled windows by dragging: enabled
- Tiled windows have margins: enabled
- Stage Manager: disabled

## Keyboard navigation

In **System Settings → Keyboard → Keyboard Shortcuts**, verify full keyboard
access. Tab and Shift-Tab should move focus, Space should activate a focused
control, and Enter should keep its normal dialog/text-entry behavior.

## Suggested window shortcuts

In **System Settings → Keyboard → Keyboard Shortcuts → Window**, optionally set:

| Action | Shortcut |
| --- | --- |
| Tile Left | Control Option Command Left |
| Tile Right | Control Option Command Right |
| Tile Top | Control Option Command Up |
| Tile Bottom | Control Option Command Down |
| Center | Control Option Command C |
| Fill | Control Option Command F |

## Appearance

Consider a fixed Light or Dark appearance, Graphite accent color, and small
sidebar icons. These remain personal choices and are not forced by the script.

## Documented optional automation

Further commented examples are kept next to the active configuration:

- `macos-defaults.sh`: effectively hidden Dock, quitting Finder, and the
  deliberately discouraged Gatekeeper-quarantine override
- `bootstrap.sh`: deterministic Dock layout using `dockutil`
- `Brewfile`: optional `mas`, `dockutil`, `mise`, Visual Studio Code and Obsidian
- `scripts/setup-work-colima-incus.sh`: Work Mac Colima/Incus profile for the
  later Agent/COI setup; review CPU, memory, disk and mount settings before use

## Colima/Incus work profile

The work profile uses Colima's Incus runtime and mounts `~/Code` into the Linux
VM. Before running it, verify that this broad mount is acceptable for the work
machine.

```sh
./scripts/setup-work-colima-incus.sh
```

For smaller machines:

```sh
COLIMA_INCUS_CPU=4 COLIMA_INCUS_MEMORY=8 COLIMA_INCUS_DISK=80 ./scripts/setup-work-colima-incus.sh
```

## Protected app preferences

Modern macOS releases protect preferences stored in application containers. If
the bootstrap prints a warning for Mail, Safari or Archive Utility, use the
following manual steps.

### Safari

Open **Safari → Settings → Advanced** and enable or verify:

- **Show features for web developers**
- **Show full website address**

Then ensure Safari does not automatically open downloaded files that it
considers safe. The wording and location of this option can vary by Safari
version.

### Archive Utility

Open **Archive Utility** through Spotlight, then choose **Archive Utility →
Settings**. Under the options for expanding archives:

- Set the action after expanding to **move archive to Trash**.
- Optionally disable revealing/opening expanded items in Finder.

### Mail

The `AddressesIncludeNameOnPasteboard` preference makes copied email addresses
omit their display names. Current Mail versions do not expose this preference
consistently in their settings UI. To apply it, temporarily grant the terminal
application used to run the bootstrap **Full Disk Access** in **System Settings
→ Privacy & Security → Full Disk Access**, fully restart that terminal, and run:

```sh
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
```

Remove Full Disk Access again afterward if it is not otherwise required. Do not
run the command with `sudo`, because that would target root's preferences.

The same temporary Full Disk Access method can be used to retry all protected
defaults:

```sh
cd ~/Code/AutoSetupMac
./macos-defaults.sh
```

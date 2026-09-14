# 🛠️ MacAutoSetup

A lean, modern and terminal-focused development environment for macOS.

## ✨ Core Features

- 🚀 Zsh with Antidote — plugin manager for a clean, fast shell
- ✨ Starship — portable prompt with Nerd Font symbols
- 🧑‍💻 Zed — fast native editor for macOS
- 🧘 Minimal Vim config — if you want to keep it light
- 🖋️ GNU Stow — simple, modular dotfile management
- 🧰 Essential GNU utilities — sed, coreutils, gawk, etc.


## 🎯 Philosophy

- Terminal-first, keyboard-driven workflow
- Get up and running fast
- Modular, understandable configuration — no hidden magic
- Low configuration for improved portability
- Dotfile hygiene - I yoinked the .zsh.d idea from a youtube video that I have 
forgotten but would LOVE to credit. If someone knows the video on "the dot problem" 
or something like that, please point that out to me and let me know!


## 🔧 Installation

### ✅ If you have Git

```sh
git clone https://github.com/NLaundry/MacAutoSetup.git ~/Projects/MacAutoSetup
cd ~/Projects/MacAutoSetup
./bootstrap.sh
```

### 🌀 If you only have curl (fresh macOS install)

```
bash <(curl -fsSL https://raw.githubusercontent.com/NLaundry/MacAutoSetup/main/bootstrap-nogit.sh)
```

This will:
1. Install Xcode CLI tools (for Git)
2. Install Homebrew
3. Clone this repo
4. Run the full setup


## 📦 What Gets Installed

The Brewfile covers all the essentials:

### 🧰 CLI Tools

git, fzf, ripgrep, bat, htop, lazygit, jq, gh, git-delta, zoxide, eza,
fd, stow, todo-txt, hf, colima, incus, coreutils, gnu-sed, findutils,
gawk, Antidote, Docker, oMLX, pnpm, Rustup, uv, XcodeGen, yq and yt-dlp

### 💻 GUI Apps

Marta, Zed, Ghostty, Discord, Ollama and OrbStack

### 🖥️ Fonts

JetBrains Mono Nerd Font (for beautiful glyphs and coding ligatures)

### 🧪 Dev Environment

python, pipx and Node.js LTS managed through nvm

The setup also applies an opinionated set of macOS preferences covering the
Dock and Mission Control, Finder, screenshots, keyboard and text input,
trackpad, save/print dialogs, TextEdit, Mail, Terminal, Safari, Xcode, Activity
Monitor and automatic security updates. Screenshots are stored in
`~/Screenshots`. Review `macos-defaults.sh` before running the bootstrap if you
prefer different values, and see `docs/MANUAL_STEPS.md` for settings that remain
manual.

If macOS protects Mail, Safari or Archive Utility preferences, the bootstrap
prints a warning and `docs/MANUAL_STEPS.md` provides the corresponding UI path
or safe manual command.
The window corner radius is set to the classic AppKit-style value `10`. To
restore the macOS default, run `defaults delete -g NSConvolutionOverride1` and
restart Finder and any open applications.

Rosetta 2 is installed automatically on Apple Silicon when it is not already
active. Bitwarden's SSH agent is used automatically once it has been enabled in
the Bitwarden desktop app.

`direnv` and its shell hook are included as commented optional settings. Agent
Vault is likewise documented as a commented installer in `bootstrap.sh`; review
and enable it manually if credential brokering for AI agents is required.

Zed settings are managed as dotfiles. The repository also includes portable
oMLX and OrbStack configuration snapshots plus the selected Ice preferences.
Apply the latter after installing the relevant apps with:

```sh
./scripts/apply-app-configs.sh
```

The script never overwrites existing oMLX or OrbStack configuration files.
Its oMLX snapshot deliberately omits API keys, proxy settings and machine-local
host aliases.

Colima with Incus is prepared for work-Mac Agent/COI experiments. After running
the bootstrap, see [docs/COLIMA_INCUS_WORK.md](docs/COLIMA_INCUS_WORK.md) and
run `./scripts/setup-work-colima-incus.sh` when you are ready to create the
`work-incus` Colima profile.


## 📁 Dotfiles & Config

Dotfiles are managed using GNU Stow.

Directory structure:

```
dotfiles/
├── zsh/
├── vim/         # Classic Vim config (present, but not linked by default)
├── ghostty/
└── …
```

Each folder maps to $HOME. For example:

```
stow --target=$HOME zsh ghostty
```

creates symlinks for config files in your home directory.

## ✅ Result

- A compact, keyboard-friendly macOS development environment
- Zed for development
- Clean terminal with Nerd Font and modern CLI tools
- Shell and development tools ready for Python, Node and Hugging Face

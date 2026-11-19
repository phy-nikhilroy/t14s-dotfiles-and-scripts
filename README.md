# t14s-dotfiles-and-scripts

Personal dotfiles, window manager configuration, and system automation scripts for a **Lenovo ThinkPad T14s Gen 1** running **Arch Linux**.

## Desktop Stack

| Component | Role | Details |
|-----------|------|---------|
| [bspwm](https://github.com/baskerville/bspwm) | Tiling window manager | Custom floating rules for utility dialogs and feh, picom compositor integration |
| [sxhkd](https://github.com/baskerville/sxhkd) | Hotkey daemon | Node state query toggles, desktop switching, wallpaper rotation, shortcuts popup |
| [polybar](https://github.com/polybar/polybar) | Status bar | Configured for ThinkPad `AC` power adapter and PipeWire/WirePlumber audio |
| [alacritty](https://github.com/alacritty/alacritty) | Terminal emulator | Primary GPU-accelerated terminal |
| [kitty](https://sw.kovidgoyal.net/kitty/) | Terminal emulator | Secondary terminal with ligatures and kitty graphics protocol support |
| [neovim](https://neovim.io) | Editor | Managed via lazy.nvim, snacks.nvim, conform.nvim, Mason with mason-tool-installer, LSP |

## Setup & Symlinking

### Automated Setup

Run `setup-symlinks.sh` (or `scripts/setup`) to configure symlinks idempotently:

```bash
~/dotfiles/setup-symlinks.sh
```

The script manages:
- Desktop configuration directories linked into `~/.config/` (`bspwm`, `sxhkd`, `polybar`, `kitty`, `alacritty`, `nvim`, `git`).
- Shell and environment files linked into `~/` (`.bashrc`, `.bash_profile`, `.xinitrc`, `.Xresources`, `.gitconfig`).
- System and utility scripts linked into `~/.local/bin/`.
- Global AI profiles linking `ai/system-profile.md` to `~/.claude/CLAUDE.md` and `~/.gemini/config/AGENTS.md`.
- Project assistant rules linking `AGENTS.md` to `CLAUDE.md`.
- Quality enforcement Git hooks linked to `.git/hooks/` (`pre-commit`, `commit-msg`).
- Automatic timestamped backups to `~/.dotfiles_backup/<timestamp>/` if conflicting regular files exist.

### Manual Symlinking

If preferred, symlinks can be created individually:

**Home directory configuration files:**
```bash
ln -s ~/dotfiles/home/.bashrc       ~/.bashrc
ln -s ~/dotfiles/home/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/home/.xinitrc      ~/.xinitrc
ln -s ~/dotfiles/home/.Xresources   ~/.Xresources
ln -s ~/dotfiles/home/.gitconfig    ~/.gitconfig
```

**`~/.config/` application directories:**
```bash
ln -s ~/dotfiles/alacritty   ~/.config/alacritty
ln -s ~/dotfiles/kitty       ~/.config/kitty
ln -s ~/dotfiles/bspwm       ~/.config/bspwm
ln -s ~/dotfiles/sxhkd       ~/.config/sxhkd
ln -s ~/dotfiles/polybar     ~/.config/polybar
ln -s ~/dotfiles/nvim        ~/.config/nvim
ln -s ~/dotfiles/git         ~/.config/git
```

**Scripts (`~/.local/bin/`):**
```bash
mkdir -p ~/.local/bin
ln -s ~/dotfiles/scripts/maintain         ~/.local/bin/maintain
ln -s ~/dotfiles/scripts/claude-usage     ~/.local/bin/claude-usage
ln -s ~/dotfiles/scripts/agyusage         ~/.local/bin/agyusage
ln -s ~/dotfiles/scripts/shortcuts        ~/.local/bin/shortcuts
ln -s ~/dotfiles/scripts/bluetooth        ~/.local/bin/bluetooth
ln -s ~/dotfiles/scripts/wallpaper-cycle  ~/.local/bin/wallpaper-cycle
```

**AI Profiles & Project Guidelines:**
```bash
mkdir -p ~/.claude ~/.gemini/config
ln -s ~/dotfiles/ai/system-profile.md ~/.claude/CLAUDE.md
ln -s ~/dotfiles/ai/system-profile.md ~/.gemini/config/AGENTS.md
ln -s ~/dotfiles/AGENTS.md            ~/dotfiles/CLAUDE.md
```

**Git Quality Hooks:**
```bash
ln -s ~/dotfiles/hooks/pre-commit  ~/dotfiles/.git/hooks/pre-commit
ln -s ~/dotfiles/hooks/commit-msg  ~/dotfiles/.git/hooks/commit-msg
```

## System Scripts & Utilities

Scripts in `scripts/` provide system maintenance and desktop workflow helpers:

| Script | Description |
|--------|-------------|
| `maintain` | Complete system maintenance: updates, pacman and yay cache cleanups, orphan package removal, systemd journal vacuum, reflector mirror refresh, and broken symlink checks |
| `claude-usage` | Token tracking, quota monitoring, and session metrics utility for Claude Code |
| `agyusage` | Token and quota usage monitor for Google Antigravity CLI |
| `shortcuts` | Interactive rofi keybinding search popup (`super + /`) parsed from `shortcuts-data.yaml`. Automatically copies selected shortcut to the clipboard (`xclip`) and triggers a desktop notification. Executed via `uv run --script` with inline PEP 723 dependencies |
| `bluetooth` | Interactive Bluetooth controller for pairing, connecting, and inspecting device status |
| `wallpaper-cycle` | Dual-screen desktop wallpaper rotator utilizing `feh` |
| `setup` | Forwarder script that executes `setup-symlinks.sh` |

## AI Assistant Configuration

This repository defines unified guidelines for AI coding assistants to maintain consistency across Claude Code and Google Antigravity:

- `ai/system-profile.md`: Host environment specification, hardware profile, package management constraints, dotfiles rules, and git standards. Symlinked to `~/.claude/CLAUDE.md` and `~/.gemini/config/AGENTS.md`.
- `ai/review-docs.md`: Comprehensive guidelines and structure for writing post-work review documents.
- `AGENTS.md`: Repository-specific context, testing rules, and architecture notes (symlinked to `CLAUDE.md`).

## Git Quality Enforcement

Repository hooks in `hooks/` enforce code hygiene and commit quality:

- `hooks/pre-commit`:
  - Validates shell script syntax (`bash -n`).
  - Validates Lua files (`luac -p`).
  - Verifies polybar battery adapter configuration (`AC`).
  - Prevents committing `lazy-lock.json` and sensitive files.
- `hooks/commit-msg`:
  - Enforces commit quality standards (imperative mood or Conventional Commits: `feat:`, `fix:`, `refactor:`, `chore:`).
  - Rejects AI attribution trailers (e.g. `Co-authored-by:`), signatures, and assistant watermarks.
  - Rejects emojis in commit messages.
  - Rejects chronological timeline labels (e.g. "Day 1", "Week 2").
- `git/ignore`:
  - Global git ignore template (`~/.config/git/ignore`) for editor noise, OS caches, virtual environments, and secrets.

## Keybindings Quick Reference

Configured in `sxhkd/sxhkdrc`:

| Shortcut | Action |
|----------|--------|
| `super + /` | Fuzzy-search keybinding reference dialog (`shortcuts`) |
| `super + Return` | Launch terminal (`alacritty`) |
| `super + t` | Launch terminal (`kitty`) |
| `super + b` | Launch browser (`firefox`) |
| `super + d` | Application launcher (`rofi -show drun`) |
| `super + space` | Toggle focused window floating state (tiled / floating) |
| `super + f` | Toggle focused window fullscreen state |
| `super + shift + space` | Force window into normal tiled mode |
| `super + m` | Toggle monocle layout |
| `super + q` | Close focused window (`bspc node -c`) |
| `super + w` | Switch to next wallpaper (`wallpaper-cycle next`) |
| `super + shift + w` | Switch to previous wallpaper (`wallpaper-cycle prev`) |
| `super + Escape` | Reload keybindings (`pkill -USR1 -x sxhkd`) |

## Directory Structure

```
dotfiles/
├── AGENTS.md            # Repository guidelines for AI assistants (symlinks to CLAUDE.md)
├── README.md            # Repository documentation
├── setup-symlinks.sh    # Idempotent symlink manager with automated backups
├── ai/
│   ├── review-docs.md   # Guidelines for post-work review documents
│   └── system-profile.md# Unified system profile for Claude Code and Antigravity
├── alacritty/           # Alacritty terminal configuration
├── bspwm/               # bspwm window manager configuration and autostart
├── git/
│   └── ignore           # Global git ignore configuration
├── home/                # Home directory configuration files (~/)
│   ├── .bash_profile    # Login shell profile
│   ├── .bashrc          # Interactive shell configuration, aliases, and paths
│   ├── .gitconfig       # Git author configuration and helpers
│   ├── .xinitrc         # X11 session initialization
│   └── .Xresources      # X11 resource settings and DPI scaling
├── hooks/
│   ├── commit-msg       # Quality hook enforcing commit message rules
│   └── pre-commit       # Quality hook validating scripts and configs
├── kitty/               # Kitty terminal configuration
├── nvim/                # Neovim configuration (lazy.nvim, LSP, Mason, conform)
├── polybar/             # Polybar configuration and launch script
├── scripts/             # System utilities (symlinked to ~/.local/bin/)
│   ├── agyusage         # Antigravity CLI usage monitor
│   ├── bluetooth        # Bluetooth management script
│   ├── claude-usage     # Claude CLI usage monitor
│   ├── maintain         # System update, cache cleanup, and maintenance
│   ├── setup            # Forwarder script executing setup-symlinks.sh
│   ├── shortcuts        # Rofi keybinding search dialog (PEP 723)
│   ├── shortcuts-data.yaml # Keybinding metadata for shortcuts dialog
│   └── wallpaper-cycle  # Wallpaper rotation utility
└── sxhkd/               # sxhkd hotkey daemon configuration
```

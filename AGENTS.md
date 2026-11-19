# Dotfiles Repository Guidelines

## Repository Overview
This repository contains the system dotfiles and desktop configurations for an Arch Linux setup on a Lenovo ThinkPad T14s Gen 1 (bspwm, sxhkd, polybar, alacritty, kitty, nvim, bash).

## Directory Structure
- `bspwm/`: Window manager configuration (`bspwmrc`).
- `sxhkd/`: Keybinding definitions (`sxhkdrc`).
- `polybar/`: Status bar configuration (`config.ini`) and startup script (`launch.sh`).
- `alacritty/`: Terminal configuration (`alacritty.toml`).
- `kitty/`: Terminal configuration (`kitty.conf`).
- `nvim/`: Neovim setup (`init.lua`, `lua/config/`, `lua/plugins/`).
- `home/`: User home files (`.bashrc`, `.bash_profile`, `.xinitrc`, `.Xresources`, `.gitconfig`).
- `git/`: Global git configuration template (`ignore`).
- `hooks/`: Git pre-commit and commit-msg quality enforcement hooks.
- `ai/`: Host system profile (`system-profile.md`) symlinked globally for agent environments (`~/.claude/CLAUDE.md`, `~/.gemini/config/AGENTS.md`), and `review-docs.md`, the instructions for writing review documents, which the profile points to by path.
- `scripts/`: System scripts symlinked into `~/.local/bin/`:
  - `maintain`: System update and package cache cleanup.
  - `claude-usage`: Usage monitoring utility.
  - `agyusage`: Usage monitoring utility.
  - `shortcuts`: Keybind search dialog via rofi and `shortcuts-data.yaml`.
  - `bluetooth`: Bluetooth controller script.
  - `wallpaper-cycle`: Wallpaper rotator.
- `setup-symlinks.sh`: Script to idempotently verify and apply all symlinks with automatic backups.

## Shortcuts (Keybind Lookup)
- `super + slash`: rofi popup listing tool keybinds defined in `scripts/shortcuts-data.yaml`.
- Selecting an entry copies its keybind to the clipboard (`xclip`) and shows a desktop notification.
- `scripts/shortcuts` is executed with `uv run --script` using PEP 723 inline dependencies (`pyyaml`).

## Validation & Testing Rules
- Shell scripts (`bspwmrc`, `launch.sh`, `setup-symlinks.sh`, scripts in `scripts/`, bash files): Always test syntax with `bash -n <file>` before committing.
- Hotkeys: Test `sxhkdrc` before reloading. Reload daemon with `pkill -USR1 -x sxhkd`.
- Neovim: Test Lua syntax with `luac -p <file>`. Do not commit `lazy-lock.json` (kept in `.gitignore`).
- Polybar: Battery adapter identifier is `AC` on this ThinkPad model.

## Git Standards
- Maintainer & Author: `phy-nikhilroy <phy.nikhilroy@gmail.com>`.
- Never include AI co-author attributions or assistant signatures in git commits.
- Never use emojis in commit messages or repository files.
- Never use chronological labels (e.g. Day 1, Week 2).
- Active branch is `main`.

# t14s-dotfiles-and-scripts

Personal dotfiles and scripts for a **ThinkPad T14s** running **Arch Linux**.

## Setup

### Window Manager Stack

| Component | Role |
|-----------|------|
| [bspwm](https://github.com/baskerville/bspwm) | Tiling window manager |
| [sxhkd](https://github.com/baskerville/sxhkd) | Hotkey daemon |
| [polybar](https://github.com/polybar/polybar) | Status bar |
| [alacritty](https://github.com/alacritty/alacritty) | Terminal emulator |
| [kitty](https://sw.kovidgoyal.net/kitty/) | Terminal emulator |
| [neovim](https://neovim.io) | Editor (lazy.nvim plugin manager) |

### Symlinking configs

Each config directory should be symlinked into the appropriate `~/.config/` location:

```bash
ln -s ~/dotfiles/alacritty   ~/.config/alacritty
ln -s ~/dotfiles/kitty       ~/.config/kitty
ln -s ~/dotfiles/bspwm       ~/.config/bspwm
ln -s ~/dotfiles/sxhkd       ~/.config/sxhkd
ln -s ~/dotfiles/polybar     ~/.config/polybar
ln -s ~/dotfiles/nvim        ~/.config/nvim
```

### Scripts

Scripts live in `scripts/` and are symlinked into `~/.local/bin/`:

```bash
ln -s ~/dotfiles/scripts/maintain  ~/.local/bin/maintain
```

| Script | Description |
|--------|-------------|
| `maintain` | Full system maintenance: updates, cache cleanup, orphan removal, journal vacuum, mirror refresh, broken symlink scan |

## Structure

```
dotfiles/
├── alacritty/       # Terminal config
├── kitty/           # Terminal config
├── bspwm/           # Window manager config + autostart
├── nvim/            # Neovim config (lazy.nvim)
├── polybar/         # Bar config + launch script
├── scripts/         # Shell scripts (symlinked to ~/.local/bin)
│   └── maintain
└── sxhkd/           # Keybindings
```

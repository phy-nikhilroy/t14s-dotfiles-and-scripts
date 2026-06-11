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

Run the setup script after cloning — it creates all symlinks automatically:

```bash
~/dotfiles/scripts/setup
```

It skips anything already correctly linked and warns about conflicts instead of overwriting.

Or create them manually:

**Home directory files:**

```bash
ln -s ~/dotfiles/home/.bashrc       ~/.bashrc
ln -s ~/dotfiles/home/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/home/.xinitrc      ~/.xinitrc
ln -s ~/dotfiles/home/.Xresources   ~/.Xresources
ln -s ~/dotfiles/home/.gitconfig    ~/.gitconfig
```

**`~/.config/` directories:**

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
| `setup` | Creates all dotfile symlinks after a fresh clone |

## Structure

```
dotfiles/
├── home/                # Home directory dotfiles (~/)
│   ├── .bashrc          # Shell aliases, PATH, EDITOR, NVM, cargo
│   ├── .bash_profile    # Sources .bashrc on login
│   ├── .gitconfig       # Git identity and gh credential helper
│   ├── .xinitrc         # X session startup: Xresources, picom, dunst, bspwm
│   └── .Xresources      # Xft.dpi for correct font scaling at 158 DPI
├── alacritty/           # Terminal config
├── kitty/               # Terminal config
├── bspwm/               # Window manager config + autostart
├── nvim/                # Neovim config (lazy.nvim)
├── polybar/             # Bar config + launch script
├── scripts/             # Shell scripts (symlinked to ~/.local/bin)
│   ├── maintain
│   └── setup
└── sxhkd/               # Keybindings
```

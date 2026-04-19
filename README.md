<div align="center">

# ✦ dotfiles

**My personal system configuration for EndeavourOS + Hyprland (HyDE)**

![EndeavourOS](https://img.shields.io/badge/OS-EndeavourOS-blueviolet?style=flat-square&logo=endeavouros)
![Hyprland](https://img.shields.io/badge/WM-Hyprland-cyan?style=flat-square)
![HyDE](https://img.shields.io/badge/Framework-HyDE-informational?style=flat-square)
![Shell](https://img.shields.io/badge/Shell-Zsh%20%2B%20p10k-green?style=flat-square)
![Editor](https://img.shields.io/badge/Editor-Neovim%20(NvChad)-red?style=flat-square)

</div>

---

## 🖥 System Overview

| Component | Choice |
|---|---|
| OS | EndeavourOS (Arch-based) |
| Window Manager | Hyprland (via HyDE framework) |
| Terminal | Kitty |
| Shell | Zsh + Powerlevel10k |
| Editor | Neovim (NvChad v2.5+) |
| Bar | Waybar |
| Idle / Lock | hypridle + hyprlock |
| System Info | fastfetch |
| GPU | NVIDIA Quadro T1000 |

---

## 📁 What's Tracked

```
~
├── .config/
│   ├── fastfetch/              # Fastfetch config + custom PNG images
│   │   └── pngs/               # aisaka, arch, hyde, loli, pochita, ryuzaki
│   ├── hypr/
│   │   ├── hyprland.conf       # Main Hyprland config (source of truth)
│   │   ├── keybindings.conf    # All keybinds
│   │   ├── monitors.conf       # Monitor layout (NVIDIA Quadro T1000)
│   │   ├── nvidia.conf         # NVIDIA-specific env vars and fixes
│   │   ├── userprefs.conf      # Personal overrides on top of HyDE defaults
│   │   ├── windowrules.conf    # Per-app window rules
│   │   ├── workspaces.conf     # Workspace definitions
│   │   ├── hypridle.conf       # Idle timeout → dim → lock → sleep chain
│   │   ├── hyprlock.conf       # Lock screen config
│   │   ├── pyprland.toml       # Pyprland scratchpad / plugin config
│   │   ├── shaders.conf        # GPU shader effects
│   │   ├── animations/         # 17 animation presets (classic, dynamic, minimal, etc.)
│   │   ├── hyprlock/           # 8 hyprlock theme variants
│   │   ├── themes/             # Wallbash color integration (colors, theme, wallbash)
│   │   └── workflows/          # 5 workflow presets (default, editing, gaming, powersaver, snappy)
│   ├── kitty/
│   │   ├── kitty.conf          # Main terminal config
│   │   ├── userprefs.conf      # Personal overrides
│   │   ├── hyde.conf           # HyDE-managed kitty settings
│   │   └── theme.conf          # Active color theme (wallbash-synced)
│   ├── nvim/
│   │   └── lua/
│   │       ├── configs/
│   │       │   ├── conform.lua     # Formatter config (conform.nvim)
│   │       │   └── lspconfig.lua   # LSP servers (Mason-managed)
│   │       ├── mappings.lua        # Custom keymaps
│   │       └── plugins/
│   │           └── init.lua        # Plugin declarations
│   └── waybar/
│       ├── config.jsonc        # Bar layout and modules
│       ├── style.css           # Base styles
│       ├── theme.css           # Active theme colors (wallbash-synced)
│       ├── user-style.css      # Personal style overrides
│       └── includes/           # Modular CSS/JSON includes (border-radius, global)
├── .config/zsh/
│   ├── .zshrc                  # Main Zsh config
│   ├── .zshenv                 # Environment variables
│   ├── .p10k.zsh               # Powerlevel10k prompt config
│   ├── plugin.zsh              # Plugin loader
│   ├── prompt.zsh              # Prompt setup
│   ├── user.zsh                # Personal aliases and extras
│   ├── conf.d/                 # Auto-sourced configs (HyDE env, prompt, terminal)
│   ├── completions/            # Custom completions (fzf, hydectl)
│   └── functions/              # Lazy-loaded functions (duf, eza, fzf, error-handlers)
├── .gitconfig                  # Git identity and global settings
├── .zshrc → .config/zsh/.zshrc
└── .zshenv → .config/zsh/.zshenv
```

---

## ⚙️ Hyprland Highlights

- **HyDE framework** — theme management, wallbash color syncing across all apps
- **17 animation presets** — from `minimal-1` to `LimeFrenzy`, switchable at runtime
- **5 workflow presets** — `default`, `editing`, `gaming`, `powersaver`, `snappy`; each tunes gaps, animations, and rules for the task
- **8 hyprlock themes** — including `HyDE`, `IBM Plex`, `SF Pro`, `Anurati`, and wallbash-synced variants
- **NVIDIA config** — dedicated `nvidia.conf` for env vars, DRM, and explicit sync fixes (Quadro T1000, driver 595.x)
- **hypridle chain** — dim → lock (hyprlock) → suspend, all timeout-configurable
- **Pyprland** — scratchpad terminals and floating app management
- **Shader effects** — via `shaders.conf`
- **Wallbash** — auto-generates a color palette from the active wallpaper and applies it to Waybar, Kitty, hyprlock, and more

---

## 🖊 Neovim (NvChad)

Built on **NvChad v2.5+** with a custom layer on top:

- **LSP** — configured via `lspconfig.lua` with Mason-managed servers
- **Formatting** — `conform.nvim` with per-filetype formatter config
- **Custom keymaps** — in `mappings.lua` (VSCode-style bindings where sensible)
- **Plugins** — declared in `plugins/init.lua`
- Theme: Tokyo Night

---

## 🐚 Zsh Setup

- **Powerlevel10k** prompt (`.p10k.zsh`)
- Modular config split across `conf.d/`, `functions/`, and `completions/`
- HyDE-managed env and terminal integration (`conf.d/hyde/`)
- Lazy-loaded utility functions: `eza` (ls replacement), `fzf`, `duf`
- Custom completions for `fzf` and `hydectl`
- `user.zsh` for personal aliases and one-offs

---

## 📊 Fastfetch

Custom `config.jsonc` with a side-by-side ASCII art + system info layout.
Bundled PNG images for logo display: `arch`, `hyde`, `aisaka`, `pochita`, `ryuzaki`, `loli`.

---

## 🚀 Installation (Fresh Machine)

> This uses the **bare git repo** method — no symlinks, no stow, the home directory itself is the worktree.

### 1. Clone as a bare repo

```bash
git clone --bare https://github.com/beshoy-13/dotfiles.git $HOME/.dotfiles
```

### 2. Define the alias

```bash
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

Add this to your `.zshrc` or `.bashrc` to persist it.

### 3. Checkout the files

```bash
dotfiles checkout
```

If git complains about existing files, back them up first:

```bash
mkdir -p ~/.dotfiles-backup
dotfiles checkout 2>&1 | grep "^\s" | awk '{print $1}' | xargs -I{} mv $HOME/{} ~/.dotfiles-backup/{}
dotfiles checkout
```

### 4. Hide untracked files

```bash
dotfiles config --local status.showUntrackedFiles no
```

### 5. Install dependencies

**Hyprland + HyDE:**
```bash
# Install HyDE first — it manages Hyprland, Waybar, hyprlock, hypridle, and theme tooling
git clone --depth 1 https://github.com/HyDE-Project/HyDE ~/HyDE
cd ~/HyDE && bash Scripts/install.sh
```

**Neovim:**
```bash
sudo pacman -S neovim
# NvChad bootstraps automatically on first launch
```

**Zsh + Powerlevel10k:**
```bash
sudo pacman -S zsh
chsh -s /bin/zsh
# p10k installs via the plugin system; run `p10k configure` to reconfigure
```

**fastfetch:**
```bash
sudo pacman -S fastfetch
```

---

## 🔄 Daily Usage

```bash
# Check status
dotfiles status

# Stage a changed config
dotfiles add ~/.config/hypr/userprefs.conf

# Commit
dotfiles commit -m "update userprefs"

# Push
dotfiles push
```

---

## 👤 Author

**Beshoy Fomail Labib**

[![GitHub](https://img.shields.io/badge/GitHub-beshoy--13-181717?style=flat-square&logo=github)](https://github.com/beshoy-13)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Beshoy%20Fomail-0A66C2?style=flat-square&logo=linkedin)](https://www.linkedin.com/in/beshoy-fomail)
[![Email](https://img.shields.io/badge/Email-beshoy.f.labib%40outlook.com-0078D4?style=flat-square&logo=microsoft-outlook)](mailto:beshoy.f.labib@outlook.com)

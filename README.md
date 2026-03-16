# 🌙 dotfiles

> EndeavourOS · Hyprland · NvChad · Tokyo Night · Kitty · Zsh

Personal dotfiles for my Arch-based setup, managed with a bare Git repository — no symlinks, no stow, no magic.

---

## 🖥️ System

| Component       | Choice                          |
|-----------------|---------------------------------|
| **OS**          | EndeavourOS (Arch-based)        |
| **WM**          | Hyprland (HyDE / hyprdots)      |
| **Bar**         | Waybar                          |
| **Terminal**    | Kitty                           |
| **Shell**       | Zsh + Powerlevel10k             |
| **Editor**      | Neovim (NvChad)                 |
| **Theme**       | Tokyo Night                     |
| **Fetch**       | fastfetch                       |

---

## 📁 What's Tracked

```
~/.config/nvim/         → full NvChad config + custom keybindings
~/.config/hypr/         → Hyprland + HyDE window manager
~/.config/waybar/       → status bar
~/.config/kitty/        → terminal
~/.config/zsh/          → shell config (user.zsh, aliases, startup)
~/.config/fastfetch/    → fetch config
~/.zshrc                → zsh entry point
~/.zshenv               → env vars
~/.gitignore_dotfiles   → global git ignore for dotfiles
```

---

## ⚡ Install on a New Machine

> Make sure you have `git` and `zsh` installed first.

```bash
bash <(curl -s https://raw.githubusercontent.com/beshoy-13/dotfiles/main/install.sh)
```

Or manually — see [Manual Install](#manual-install) below.

---

## 🔧 Manual Install

**1. Clone the bare repo**
```bash
git clone --bare git@github.com:beshoy-13/dotfiles.git $HOME/.dotfiles
```

**2. Define the alias**
```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

**3. Checkout the files**
```bash
dotfiles checkout
```

If you get errors about existing files, back them up first:
```bash
mkdir -p ~/.dotfiles-backup
dotfiles checkout 2>&1 | grep "^\s" | awk '{print $1}' | \
  xargs -I{} sh -c 'mkdir -p ~/.dotfiles-backup/$(dirname "{}") && mv "$HOME/{}" ~/.dotfiles-backup/{}'
dotfiles checkout
```

**4. Hide untracked files**
```bash
dotfiles config --local status.showUntrackedFiles no
```

**5. Make the alias permanent**
```bash
echo "alias dotfiles='/usr/bin/git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME'" \
  >> ~/.config/zsh/user.zsh
```

---

## 🔄 Updating Dotfiles

After changing any config:

```bash
dotfiles add ~/.config/nvim/lua/custom/mappings.lua
dotfiles commit -m "feat: update nvim keybindings"
dotfiles push
```

---

## 🧠 How This Works

A **bare Git repo** in `~/.dotfiles` tracks files directly in `$HOME` as the work tree. No symlinks. No extra tooling. The `dotfiles` alias is just Git with custom `--git-dir` and `--work-tree` flags.

Inspired by [this Atlassian guide](https://www.atlassian.com/git/tutorials/dotfiles).

---

## 👤 Author

**Beshoy Fomail Labib**

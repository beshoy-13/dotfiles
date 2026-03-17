curl -s https://raw.githubusercontent.com/beshoy-13/dotfiles/main/README.md -o /tmp/old_readme.md && cat > ~/README.md << 'READMEEOF'

# 🌙 dotfiles

> **EndeavourOS · Hyprland (HyDE) · NvChad · Tokyo Night · Kitty · Zsh**

Personal dotfiles for my Arch-based setup — managed with a **bare Git repository**. No symlinks. No stow. No magic.

---

## 🖥️ System

| Component      | Choice                     |
| -------------- | -------------------------- |
| **OS**         | EndeavourOS (Arch-based)   |
| **WM**         | Hyprland (HyDE / hyprdots) |
| **Bar**        | Waybar                     |
| **Terminal**   | Kitty                      |
| **Shell**      | Zsh + Powerlevel10k        |
| **Editor**     | Neovim (NvChad)            |
| **Theme**      | Tokyo Night                |
| **Fetch**      | fastfetch                  |
| **Launcher**   | Rofi                       |
| **Wallpapers** | swww (managed by HyDE)     |

---

## 📁 What's Tracked

\`\`\`
~/.config/nvim/
│ ├── lua/mappings.lua ← all keybindings
│ ├── lua/plugins/init.lua ← plugins (emmet, autotag, autopairs, prettier, LSP)
│ └── lua/configs/
│ ├── lspconfig.lua ← html, css, ts, eslint, emmet LSP
│ └── conform.lua ← prettier on save
~/.config/hypr/ ← Hyprland + HyDE config
~/.config/waybar/ ← status bar
~/.config/kitty/ ← terminal (Tokyo Night)
~/.config/zsh/ ← user.zsh, aliases, startup (fastfetch)
~/.config/fastfetch/ ← fetch config + ascii art
\`\`\`

---

## ⚡ Install on a New Machine

**One-liner:**
\`\`\`bash
bash <(curl -s https://raw.githubusercontent.com/beshoy-13/dotfiles/main/install.sh)
\`\`\`

> Requires \`git\` and \`zsh\`. Backs up any conflicting files to \`~/.dotfiles-backup\` automatically.

Or go manual — see [Manual Install](#-manual-install) below.

---

## 🔧 Manual Install

**1. Clone the bare repo**
\`\`\`bash
git clone --bare git@github.com:beshoy-13/dotfiles.git \$HOME/.dotfiles
\`\`\`

**2. Define the alias**
\`\`\`bash
alias dotfiles='/usr/bin/git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME'
\`\`\`

**3. Back up conflicts then checkout**
\`\`\`bash
mkdir -p ~/.dotfiles-backup
dotfiles checkout 2>&1 | grep "^\s" | awk '{print \$1}' | \
 xargs -I{} sh -c 'mkdir -p ~/.dotfiles-backup/\$(dirname "{}") && mv "\$HOME/{}" ~/.dotfiles-backup/{}'
dotfiles checkout
\`\`\`

**4. Hide untracked files**
\`\`\`bash
dotfiles config --local status.showUntrackedFiles no
\`\`\`

**5. Make alias permanent**
\`\`\`bash
echo "alias dotfiles='/usr/bin/git --git-dir=\\\$HOME/.dotfiles/ --work-tree=\\\$HOME'" \

> > ~/.config/zsh/user.zsh
> > \`\`\`

**6. Install Neovim plugins + LSP servers**
\`\`\`bash
nvim --headless "+Lazy! sync" +qa
nvim --headless "+MasonInstallAll" +qa
\`\`\`

---

## ⌨️ Hyprland Keybindings

> \`Super\` = Windows / Meta key

### 🪟 Window Management

| Keybind                         | Action               |
| ------------------------------- | -------------------- |
| \`Super + Q\`                   | Close focused window |
| \`Super + W\`                   | Toggle floating      |
| \`Super + G\`                   | Toggle group         |
| \`Super + J\`                   | Toggle split         |
| \`Super + L\`                   | Lock screen          |
| \`Super + F11\`                 | Toggle fullscreen    |
| \`Super + Shift + F\`           | Pin window on top    |
| \`Super + ←↑↓→\`                | Move focus           |
| \`Super + Shift + ←↑↓→\`        | Resize window        |
| \`Super + Shift + Ctrl + ←↑↓→\` | Move window          |
| \`Super + mouse drag\`          | Move window          |
| \`Super + right-click drag\`    | Resize window        |

### 🚀 Launchers

| Keybind                | Action              |
| ---------------------- | ------------------- |
| \`Super + A\`          | App launcher (Rofi) |
| \`Super + Tab\`        | Window switcher     |
| \`Super + T\`          | Terminal (Kitty)    |
| \`Super + B\`          | Browser             |
| \`Super + E\`          | File explorer       |
| \`Super + C\`          | Text editor         |
| \`Super + V\`          | Clipboard           |
| \`Super + /\`          | Keybindings hint    |
| \`Super + ,\`          | Emoji picker        |
| \`Super + .\`          | Glyph picker        |
| \`Ctrl + Shift + Esc\` | System monitor      |

### 🎨 Theming & Wallpapers

| Keybind               | Action                   |
| --------------------- | ------------------------ |
| \`Super + Alt + →\`   | Next wallpaper           |
| \`Super + Alt + ←\`   | Previous wallpaper       |
| \`Super + Shift + W\` | Wallpaper selector       |
| \`Super + Shift + T\` | Theme selector           |
| \`Super + Shift + R\` | Wallbash mode selector   |
| \`Super + Alt + ↑\`   | Next Waybar layout       |
| \`Super + Alt + ↓\`   | Previous Waybar layout   |
| \`Super + Shift + Y\` | Animation selector       |
| \`Super + Shift + U\` | Hyprlock layout selector |

### 📸 Screenshots

| Keybind               | Action                     |
| --------------------- | -------------------------- |
| \`Super + P\`         | Snip screen (area select)  |
| \`Super + Ctrl + P\`  | Freeze & snip              |
| \`Super + Print\`     | Screenshot all monitors    |
| \`Super + Alt + P\`   | Screenshot current monitor |
| \`Super + Shift + P\` | Color picker               |

### 🗂️ Workspaces

| Keybind                 | Action                    |
| ----------------------- | ------------------------- |
| \`Super + 1-9\`         | Go to workspace 1–9       |
| \`Super + Ctrl + →/←\`  | Next / previous workspace |
| \`Super + Shift + 1-9\` | Move window to workspace  |
| \`Super + S\`           | Toggle scratchpad         |
| \`Super + Shift + S\`   | Move window to scratchpad |
| \`Super + scroll\`      | Cycle workspaces          |

### 🔊 Hardware

| Keybind                  | Action                 |
| ------------------------ | ---------------------- |
| \`F10\`                  | Toggle mute            |
| \`F11 / F12\`            | Volume down / up       |
| \`XF86 brightness keys\` | Brightness down / up   |
| \`Super + K\`            | Switch keyboard layout |
| \`Super + Alt + G\`      | Game mode              |

---

## ✏️ Neovim Keybindings

> \`<leader>\` = Space

### 🌐 Web Dev

| Keybind                  | Action                        |
| ------------------------ | ----------------------------- |
| \`!\` + \`Tab\`          | HTML5 boilerplate             |
| \`div.x>p\*3\` + \`Tab\` | Emmet abbreviation expand     |
| Type \`<div>\`           | Auto-closes tag               |
| \`(\` \`"\` \`{\`        | Auto-pairs                    |
| \`:w\` on html/css/js    | Prettier formats on save      |
| \`<leader>wf\`           | Format with Prettier manually |
| \`<leader>we\`           | ESLint fix all                |
| \`<leader>ws\`           | Open file in browser          |
| \`<leader>wt\`           | Wrap word in HTML tag         |

### ⚙️ Compile & Run

| Keybind        | Action               |
| -------------- | -------------------- |
| \`<leader>cc\` | Compile current file |
| \`<leader>cr\` | Run current file     |
| \`<leader>cb\` | Compile + Run        |

Supports: C, C++, Java, Python, JavaScript, TypeScript

### 📝 Editing

| Keybind               | Action                   |
| --------------------- | ------------------------ |
| \`Ctrl + S\`          | Save file                |
| \`Ctrl + A\`          | Select all               |
| \`Alt + ↑/↓\`         | Move line up / down      |
| \`Shift + Alt + ↑/↓\` | Duplicate line up / down |
| \`> / <\` (visual)    | Indent right / left      |
| \`J / K\` (visual)    | Move selection down / up |
| \`jk\`                | Escape insert mode       |
| \`;\`                 | Enter command mode       |

### 🔌 Plugins

| Plugin                        | Purpose                                     |
| ----------------------------- | ------------------------------------------- |
| \`mattn/emmet-vim\`           | Emmet abbreviations + HTML boilerplate      |
| \`windwp/nvim-ts-autotag\`    | Auto-close & rename HTML/JSX tags           |
| \`windwp/nvim-autopairs\`     | Auto-pair brackets and quotes               |
| \`NvChad/nvim-colorizer.lua\` | Inline color swatches (#hex, rgb, tailwind) |
| \`stevearc/conform.nvim\`     | Prettier formatting on save                 |
| \`neovim/nvim-lspconfig\`     | LSP (html, css, ts, eslint, emmet)          |
| \`williamboman/mason.nvim\`   | Auto-install LSP servers & formatters       |

---

## 🔄 Updating Dotfiles

\`\`\`bash
dotfiles add ~/.config/nvim/lua/plugins/init.lua
dotfiles commit -m "feat: describe your change"
dotfiles push

dotfiles status
dotfiles diff
\`\`\`

---

## 🧠 How the Bare Repo Works

A **bare Git repo** in \`~/.dotfiles\` uses \`\$HOME\` as its work tree. The \`dotfiles\` alias is just Git with custom \`--git-dir\` and \`--work-tree\` flags — no symlinks, no extra tooling.

Inspired by [this Atlassian guide](https://www.atlassian.com/git/tutorials/dotfiles).

---

## 👤 Author

**Beshoy Fomail Labib**
[LinkedIn](https://www.linkedin.com/in/beshoy-fomail/) · [GitHub](https://github.com/beshoy-13) · beshoy.f.labib@outlook.com
READMEEOF

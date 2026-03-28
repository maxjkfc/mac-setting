# CLAUDE.md — AI Assistant Guide for mac-setting

This file provides context for AI assistants (Claude, Copilot, etc.) working in this repository.

## Repository Overview

`mac-setting` is a **macOS developer environment dotfiles and setup repository** for backend engineers. It provides:
- A modular zsh configuration (`.zshenv`, `.zprofile`, `.zshrc`, `.zlogin`, `.zshshell`)
- A Neovim config built on [LazyVim](https://www.lazyvim.org/)
- Tmux configuration with TPM plugins
- An automated setup script (`setup.sh`) that installs tools via Homebrew
- Git commit conventions via `commitizen` + `commitlint`

The repository uses **symlinks** to install configs: `setup.sh` links files from this repo into `$HOME`.

---

## Repository Structure

```
mac-setting/
├── setup.sh                   # Main installer script (Bash, strict mode)
├── setup.sh.backup            # Auto-generated backup; do not edit
├── README.md                  # User-facing documentation (Traditional Chinese)
├── CLAUDE.md                  # This file
│
├── zsh/                       # Zsh configuration files
│   ├── .zshenv                # All zsh instances: env vars, PATH
│   ├── .zprofile              # Login shell: Homebrew env, OrbStack
│   ├── .zshrc                 # Interactive shell: theme, aliases, plugins
│   ├── .zlogin                # Post-login: welcome message, system info
│   └── .zshshell              # Custom fzf-enhanced shell functions
│
├── nvim/                      # Neovim config (LazyVim-based)
│   ├── init.lua               # Entry point, loads lazy.lua
│   ├── lazy-lock.json         # Plugin lockfile (commit when updating plugins)
│   ├── lazyvim.json           # LazyVim extras config
│   └── lua/
│       ├── config/
│       │   ├── autocmds.lua   # Auto-commands
│       │   ├── keymaps.lua    # Custom keymaps
│       │   ├── lazy.lua       # Lazy.nvim bootstrap
│       │   └── options.lua    # Vim options
│       └── plugins/
│           ├── editor.lua     # Telescope, Neo-tree, editing tools
│           ├── theme.lua      # Colorscheme
│           ├── ui.lua         # UI enhancements
│           └── vscode.lua     # VSCode-specific overrides
│
├── tmux/
│   └── .tmux.conf             # Tmux config; prefix = Ctrl-a, theme = Catppuccin Mocha
│
├── gitcz/                     # Commitizen configuration
│   ├── .cz-config.js          # Commit types and messages (Traditional Chinese)
│   ├── .commitlintrc.js       # Commitlint rules
│   ├── .czrc                  # Commitizen adapter pointer
│   └── .git-czrc              # Git-cz config
│
└── theme/
    ├── iTerm2/tokyonight/     # iTerm2 color scheme
    └── catppuccin/iterm/      # Git submodule: catppuccin iTerm theme
```

---

## Zsh Configuration Architecture

Understanding the load order is critical when modifying zsh files:

| File | When loaded | Responsible for |
|------|-------------|-----------------|
| `.zshenv` | Every zsh instance (login, interactive, scripts) | `PATH`, env vars, FZF config, Go/Node/tool paths |
| `.zprofile` | Login shells only, before `.zshrc` | `brew shellenv`, OrbStack integration |
| `.zshrc` | Interactive shells | Powerlevel10k theme, aliases, zplug plugins, completions |
| `.zlogin` | Login shells, after `.zshrc` | Welcome banner, system info via `macchina` |
| `.zshshell` | Sourced from `.zshrc` | Custom fzf functions (`ff`, `fcd`, `vg`, `ftm`, etc.) |

**Key convention**: Environment variables and PATH belong in `.zshenv`. Aliases, plugins, and interactive tools belong in `.zshrc`. Never mix these.

### Local overrides
`~/.zshrc.local` is sourced at the end of `.zshrc` if it exists. Use it for machine-specific settings, API keys, and secrets that must not be committed.

---

## setup.sh — The Installer

`setup.sh` runs with `set -euo pipefail` (strict mode). It requires macOS and Homebrew.

### Commands

```bash
./setup.sh all           # Full install (recommended for new machines)
./setup.sh zsh           # Zsh config + dependency tools
./setup.sh tmux          # Tmux + TPM
./setup.sh nvim          # Neovim + symlink ~/.config/nvim
./setup.sh backend       # Docker/k8s, Go, Node.js, cloud tools
./setup.sh golang        # Go language + dev tools only
./setup.sh ai-tools      # Claude CLI, Gemini CLI
./setup.sh gui-tools     # Raycast, Warp, Stats, AppCleaner (Cask)
./setup.sh vim-repeat    # Disable macOS key-hold delay for Vim
./setup.sh health        # Check what is/isn't installed
```

### Important behaviors
- `safe_symlink`: backs up existing files as `<file>.backup.YYYYMMDD_HHMMSS` before linking
- `safe_brew_install`: skips if the binary already exists
- `safe_brew_cask_install`: always attempts install, warns on failure
- Go tools are installed to `$GOPATH/bin` via `go install <pkg>@latest`
- Node.js is managed via `fnm`; the script installs the LTS version and sets it as default

---

## Neovim Configuration

Based on **LazyVim**. Plugin management via `lazy.nvim`.

### Custom plugin files

| File | Contents |
|------|----------|
| `lua/plugins/editor.lua` | Telescope (find files: `<leader>ff`, live grep: `;r`, diagnostics: `;e`), Neo-tree, numb.nvim, multi-cursor, mini.surround, mini.comment, conform.nvim (proto formatting via `buf`), nvim-lint (proto lint via `buf_lint`) |
| `lua/plugins/theme.lua` | Colorscheme setup |
| `lua/plugins/ui.lua` | UI enhancements |
| `lua/plugins/vscode.lua` | VSCode-specific overrides |

### Telescope keymaps
- `<leader>ff` — find files
- `;r` — live grep (includes hidden files)
- `;e` — diagnostics
- `;s` — Treesitter symbols
- In picker: `Ctrl-j/k` navigate, `Ctrl-c` close, `Ctrl-t` open in Trouble

### Mini.surround mappings
`gsa` add, `gsd` delete, `gsf`/`gsF` find, `gsh` highlight, `gsr` replace, `gsn` update n_lines

### mini.comment
`<leader>/` — toggle comment (normal, visual, line)

### Neo-tree
- Always shows `.gitignore`, `.dockerignore`, `.github`, `.env*`
- `v` — open in vertical split
- `<space>` — disabled (reserved for leader)

---

## Tmux Configuration

- **Prefix**: `Ctrl-a` (not the default `Ctrl-b`)
- **Theme**: Catppuccin Mocha
- **Base index**: windows and panes start at 1
- Key bindings:
  - `Prefix + r` — reload config
  - `Prefix + X` — kill window
  - `Ctrl-l` — clear screen + history
  - `Prefix + Ctrl-b` — toggle synchronize panes
  - `Ctrl-f` — open `tmux-fzf`
  - Copy mode: `v` begin selection, `y` copy

### TPM Plugins
`tmux-pain-control`, `tmux-sensible`, `tmux-sessionist`, `tmux-copycat`, `tmux-yank`, `tmux-resurrect`, `tmux-continuum`, `tmux-open`, `tmux-prefix-highlight`, `catppuccin/tmux`, `sainnhe/tmux-fzf`

---

## Custom Shell Functions (`.zshshell`)

All functions check for required tools and print errors if missing.

| Function | Usage | Description |
|----------|-------|-------------|
| `ff [pattern]` | `ff config` | Find file with fd + fzf, open in `$EDITOR` |
| `fcd [pattern]` | `fcd src` | Find directory, `cd` into it |
| `vg <pattern>` | `vg "func"` | ripgrep + fzf, open file at matching line |
| `ftm [session]` | `ftm work` | Create or attach to tmux session |
| `fs [pattern]` | `fs` | Quick tmux session switch |
| `fkill [signal]` | `fkill` | Multi-select processes and kill (default signal 9) |
| `fdim` | `fdim` | Select and remove Docker images |
| `fdc [action]` | `fdc logs` | Manage Docker containers (start/stop/restart/remove/logs/exec) |
| `fgb` | `fgb` | fzf branch switcher (`git checkout`) |
| `fgl` | `fgl` | Browse git log with diff preview |
| `myip` | `myip` | Show local + public IP with geolocation |
| `sysinfo` | `sysinfo` | CPU, RAM, uptime summary |
| `fzf_help` | `fzf_help` | Print all function descriptions |

---

## Git Commit Conventions

This repo uses **commitizen** with a custom config in `gitcz/`. Commit types:

| Type | Meaning |
|------|---------|
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Code restructuring (not a feature or fix) |
| `docs` | Documentation changes |
| `test` | Adding or modifying tests |
| `chore` | Build process, packaging, tooling changes |
| `style` | Formatting only (whitespace, semicolons) |
| `revert` | Reverting a previous commit |
| `WIP` | Work in progress |

Breaking changes are allowed in `feat`, `fix`, and `refactor`. Subject line is uppercased. Related issues go in the footer as `Related issue: #123`.

Commit messages in this repo are primarily written in **Traditional Chinese**.

---

## Key Environment Variables (`.zshenv`)

| Variable | Value | Purpose |
|----------|-------|---------|
| `HOMEBREWOPT` | `/opt/homebrew` | Homebrew prefix (Apple Silicon) |
| `GOROOT` | `$HOMEBREWOPT/opt/go/libexec` | Go installation |
| `GOPATH` | `$HOME/go` | Go workspace |
| `GOPROXY` | `https://proxy.golang.org` | Go module proxy |
| `BUN_INSTALL` | `$HOME/.bun` | Bun runtime |
| `ZPLUG_HOME` | `$HOMEBREWOPT/opt/zplug` | Zplug plugin manager |
| `EDITOR` / `VISUAL` | `nvim` | Default editor |
| `FZF_DEFAULT_COMMAND` | `fd --type file --hidden ...` | fzf file source |
| `FZF_DEFAULT_OPTS` | Catppuccin Mocha colors | fzf appearance |

PATH is built using `typeset -U path` (no duplicates) with `add_to_path()` for conditional additions.

---

## Development Workflow

### Adding a new tool to setup.sh
1. Add to the appropriate array in the relevant `setup_*` function
2. Use `tool_name:description` format for the array entry
3. Use `safe_brew_install` for CLI tools, `safe_brew_cask_install` for GUI apps

### Adding a new zsh function
1. Add to `zsh/.zshshell`
2. Include a dependency check (`command -v <tool>`) at the top
3. Add an entry to the `fzf_help` function at the bottom of the file

### Adding a Neovim plugin
1. Create or edit a file in `nvim/lua/plugins/`
2. Return a table of plugin specs per lazy.nvim format
3. Run `:Lazy sync` in Neovim; commit the updated `lazy-lock.json`

### Updating symlinks
Run the relevant `setup.sh` command again — `safe_symlink` handles re-linking idempotently.

### Secrets and local config
Never commit API keys or personal tokens. Use `~/.zshrc.local` (gitignored by convention) for local overrides.

---

## What NOT to Do

- Do not add aliases, functions, or plugin loading to `.zshenv` — it is loaded in non-interactive contexts (scripts, cron jobs) where those constructs are inappropriate
- Do not hardcode `$HOME/Users/maxjkfc` paths in shared config files — use `$HOME` instead
- Do not commit `*.backup` files or `*.backup.*` files — they are auto-generated by `safe_symlink`
- Do not edit `setup.sh.backup` — it is an auto-generated snapshot
- Do not modify `nvim/plugin/` — it is gitignored and managed by lazy.nvim at runtime
- Do not skip `set -euo pipefail` behavior when extending `setup.sh` — errors should always be surfaced

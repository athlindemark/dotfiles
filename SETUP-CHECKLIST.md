# Dotfiles setup checklist

Check or uncheck items to decide what you want in each profile. Items marked **selected** reflect your earlier choices; items marked **installed here** were found in this Mac's Homebrew inventory. Installed tools are not automatically included in the portable setup.

## Minimal profile

- [x] zsh
- [x] Oh My Zsh
- [x] Current theme: `agnoster`
- [x] Oh My Zsh Git plugin
- [x] Shared shell history settings
- [ ] Git aliases
- [x] Per-computer private config file
- [ ] Install zsh/Oh My Zsh automatically on a new computer

## Extended profile

- [x] Starship prompt **(selected; not installed via Homebrew on this Mac)**
- [x] zoxide **(selected; not installed via Homebrew on this Mac)**
- [x] Git aliases
- [x] `lazygit` / `lg` **(selected; installed here)**
- [x] GitHub CLI + `gh-dash` / `gdh` **(selected; both installed here)**
- [x] Docker completion and aliases **(selected; setup does not install Docker)**
- [x] Private per-computer `.zshrc.local` file **(selected)**
- [ ] `fzf` fuzzy history/file search (**not installed here**)
- [ ] `bat` and `ripgrep` convenience commands (**both installed here**)
- [ ] `eza` replacing `ls` (**not installed here**)
- [ ] Node.js / `fnm` helpers (`fnm` is installed here)
- [x] Python project helpers with `uv` (**uv and Python 3.13–3.15 are installed here**)
- [x] Python version selection with `uv` (recommended)
- [ ] Python virtual-environment shortcuts (`uv venv`, activate/deactivate helpers)
- [x] Python formatting/linting/testing defaults (Ruff and pytest)
- [x] VS Code Python extension and interpreter defaults (**Python/Pylance are installed here; Ruff is not**)
- [ ] Go helpers (Go is installed here)

## Cloud and infrastructure helpers

Choose only the shells/tools you use; these add completions and aliases, not credentials or the tools themselves.

- [x] Azure CLI (`az`) (**installed here**)
- [x] Docker (**configuration selected; Docker is not included in the Homebrew inventory**)
- [ ] Kubernetes (`kubectl`, contexts/namespaces) (**kubectl and kubectx installed here**)
- [x] Terraform (**installed here**)
- [x] Helm (**installed here**)
- [x] Google Cloud CLI (**installed here as a Homebrew cask**)
- [ ] Keep cloud tooling out of the shared defaults

## macOS / Linux behavior

- [x] Same zsh profiles on macOS and Linux
- [x] Homebrew when available; apt, dnf, pacman, or zypper otherwise
- [ ] Add OS-specific aliases (macOS-only `pbcopy`/`open`, Linux clipboard tools, etc.)
- [x] Add a separate macOS defaults script for fast key repeat (opt-in)
- [ ] Add a separate Linux-only setup script

## Applications

- [x] **VS Code:** shared settings, keybindings, and recommendations (works on macOS/Linux; VS Code is installed here)
- [x] VS Code: include a list of recommended extensions only; keep personal settings local
- [x] VS Code: configure terminal profile to use zsh
- [x] **iTerm2:** macOS-only profile, inherited colors, Nerd Font, and Option+Arrow word movement
- [x] Keep iTerm2 settings out of the Linux setup
- [ ] Share terminal colors/fonts with other terminals where possible

## Keyboard and cursor movement

- [x] Faster macOS key repeat / shorter initial delay (macOS-only system preference; opt-in script)
- [ ] Terminal shortcuts to move by word and jump to line start/end (portable zsh/readline bindings)
- [ ] VS Code cursor/navigation keybindings (portable editor settings)
- [x] Keep the macOS system key-repeat change separate and opt-in

Use this checklist to tell me which unchecked options you want enabled, or edit the boxes and share the resulting choices.

# Portable macOS and Linux dotfiles

Two selectable zsh profiles built around Oh My Zsh. The default is **Minimal** and keeps your current `agnoster` theme. **Extended** adds the tools you selected earlier.

## Profiles

### Minimal

- zsh and Oh My Zsh
- Your current Oh My Zsh `agnoster` theme
- Oh My Zsh Git plugin and sensible shared history settings
- No extra prompt framework, aliases, or third-party CLI tools

### Extended

Everything in Minimal, plus:

- Starship prompt (falls back to `agnoster` if Starship is unavailable)
- zoxide directory navigation
- Git shortcuts, `lazygit` (`lg`), and `gh-dash` (`gdh`)
- zsh completion improvements and syntax highlighting retained from your existing dotfiles
- Docker, Azure, Google Cloud, Terraform, and Helm Oh My Zsh plugins/helpers; Docker itself is not installed
- Python project aliases for `uv`, Ruff, and pytest; add Ruff/pytest to each project rather than installing them globally
- Optional installation of `gh`, `lazygit`, `ruff`, `starship`, `uv`, `zsh-completions`, `zsh-syntax-highlighting`, and `zoxide`

Select the profile when installing, for example `./install.sh minimal` or `./install.sh extended`. The selection is saved in `.dotfiles-profile` and can be committed to share the default with your other computers. A `.zshrc.local` override is available for per-computer settings and is git-ignored.

## Install

Clone this repo to a stable path, then select a profile:

```sh
git clone git@github.com:athlindemark/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh minimal
# or: ./install.sh extended
```

The installer supports macOS and Linux. It asks before installing tools, Oh My Zsh, or changing your default login shell. Homebrew is used when available; otherwise it supports apt, dnf, pacman, and zypper. Linux package names/availability vary by distribution; if a selected package is unavailable, install it with your distribution's recommended instructions and rerun the setup. The script does not install Docker or run on your current machine unless you choose to run it.

If `~/.zshrc` already exists, the installer asks before moving it to a timestamped backup. Review that backup for settings to keep before using the new config. Set your terminal font to a Powerline/Nerd Font for the agnoster symbols; you already have Nerd Fonts installed on this Mac.

## App and macOS settings

- [VS Code snippets](vscode/README.md): portable zsh terminal and Python/Ruff settings, extension recommendations, and separate keybinding files. These are intended to be merged—not used to replace your existing settings. Your current User settings contain work-specific configuration, which is intentionally not copied here.
- [iTerm2 profile](iterm2/README.md): optional separate profile with inherited default colors, JetBrains Mono Nerd Font, and Option+Arrow word movement. iTerm2 settings are macOS-only.
- `macos/key-repeat.sh`: opt-in, confirmed fast-key-repeat setting with a reset option. It is not run by the main installer.

## Homebrew inventory checked on this Mac

Relevant items from `brew list` and `gh extension list`:

- **Already installed:** `gh`, `lazygit`, `uv`, `bat`, `ripgrep`, `azure-cli`, `kubernetes-cli`, `kubectx`, `helm`, and `terraform`.
- **Not installed via Homebrew:** `ruff`, `starship`, `zoxide`, `zsh-completions`, and `zsh-syntax-highlighting`.
- **GitHub extension:** `gh-dash` is already installed (`dlvhdr/gh-dash`).
- **Fonts:** Fira Code Nerd Font and JetBrains Mono Nerd Font casks are installed.
- **Shell:** zsh and Oh My Zsh are already present; your current Oh My Zsh theme is `agnoster`.

The inventory is informational and may become stale. The setup does not remove or change any of these existing packages.

## Repository and privacy

This folder is connected to `git@github.com:athlindemark/dotfiles.git`, which is currently public. Keep work-specific values and secrets out of tracked files; `.zshrc.local` and `.DS_Store` are excluded. The shared templates intentionally avoid copying machine- or work-specific VS Code settings.

See [`SETUP-CHECKLIST.md`](SETUP-CHECKLIST.md) to review what belongs in each profile and choose future add-ons.

#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE_FILE="$DOTFILES_DIR/.dotfiles-profile"

confirm() {
  local prompt="$1" answer
  read -r -p "$prompt [y/N] " answer
  [[ "$answer" == [yY] || "$answer" == [yY][eE][sS] ]]
}

profile="${1:-}"
if [[ -z "$profile" && -r "$PROFILE_FILE" ]]; then
  profile="$(<"$PROFILE_FILE")"
fi
profile="${profile:-minimal}"
if [[ "$profile" != "minimal" && "$profile" != "extended" ]]; then
  echo "Usage: $0 [minimal|extended]" >&2
  exit 2
fi
printf '%s\n' "$profile" > "$PROFILE_FILE"

install_with_package_manager() {
  local packages=("$@")
  if command -v brew >/dev/null 2>&1; then
    brew install --formula "${packages[@]}"
  elif command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y "${packages[@]}"
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y "${packages[@]}"
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --needed --noconfirm "${packages[@]}"
  elif command -v zypper >/dev/null 2>&1; then
    sudo zypper --non-interactive install "${packages[@]}"
  else
    echo "No supported package manager found. Install these manually: ${packages[*]}" >&2
    return 1
  fi
}

case "$(uname -s)" in
  Darwin) platform="macOS" ;;
  Linux) platform="Linux" ;;
  *) echo "This setup supports macOS and Linux." >&2; exit 1 ;;
esac

echo "Profile: $profile ($platform)"
if [[ "$profile" == "minimal" ]]; then
  base_packages=()
  for package in zsh git curl; do
    command -v "$package" >/dev/null 2>&1 || base_packages+=("$package")
  done
  if (( ${#base_packages[@]} > 0 )) && confirm "Install missing minimal prerequisites (${base_packages[*]})?"; then
    install_with_package_manager "${base_packages[@]}"
  fi
else
  base_packages=()
  for package in zsh git curl; do
    command -v "$package" >/dev/null 2>&1 || base_packages+=("$package")
  done
  if (( ${#base_packages[@]} > 0 )) && confirm "Install missing prerequisites (${base_packages[*]})?"; then
    install_with_package_manager "${base_packages[@]}"
  fi
  extended_packages=(zsh git curl gh lazygit ruff starship uv zsh-completions zsh-syntax-highlighting zoxide)
  if confirm "Install the Extended profile tools (${extended_packages[*]})?"; then
    if command -v brew >/dev/null 2>&1; then
      brew bundle --file "$DOTFILES_DIR/Brewfile"
    else
      install_with_package_manager "${extended_packages[@]}"
    fi
  else
    echo "Skipping tool installation; the config will use available commands only."
  fi
fi

if ! command -v zsh >/dev/null 2>&1 || ! command -v git >/dev/null 2>&1; then
  echo "Both zsh and Git are required. Install the missing prerequisite(s) and rerun this script." >&2
  exit 1
fi
if [[ ! -s "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]]; then
  if confirm "Install Oh My Zsh from its official GitHub repository?"; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
  else
    echo "Oh My Zsh was skipped; install it before using the full setup."
  fi
fi

if [[ "${SHELL:-}" != */zsh ]] && command -v chsh >/dev/null 2>&1; then
  if confirm "Make zsh your default login shell?"; then
    chsh -s "$(command -v zsh)"
  fi
fi

if [[ "$profile" == "extended" ]] && command -v gh >/dev/null 2>&1 &&
   ! gh extension list 2>/dev/null | grep -q 'dlvhdr/gh-dash'; then
  if confirm "Install the gh-dash GitHub CLI extension (dlvhdr/gh-dash)?"; then
    gh extension install dlvhdr/gh-dash
  else
    echo "Skipping gh-dash."
  fi
fi

target="$HOME/.zshrc"
if [[ -L "$target" && "$(readlink "$target")" == "$DOTFILES_DIR/.zshrc" ]]; then
  echo "$target already points to this dotfiles config."
elif [[ -e "$target" || -L "$target" ]]; then
  stamp="$(date +%Y%m%d-%H%M%S)"
  backup="$target.backup-$stamp"
  if confirm "Back up existing $target to $backup and activate this dotfiles config?"; then
    mv "$target" "$backup"
    ln -s "$DOTFILES_DIR/.zshrc" "$target"
    echo "Existing config backed up to $backup. Review it for machine-specific settings."
  else
    echo "Leaving $target unchanged."
  fi
else
  ln -s "$DOTFILES_DIR/.zshrc" "$target"
  echo "Linked $target to this dotfiles config."
fi

local_config="$DOTFILES_DIR/.zshrc.local"
if [[ ! -e "$local_config" ]]; then
  cp "$DOTFILES_DIR/.zshrc.local.example" "$local_config"
  echo "Created private local settings file: $local_config"
fi

echo "Done. Open a new terminal or run: source ~/.zshrc"

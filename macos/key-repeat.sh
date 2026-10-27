#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Fast key repeat is a macOS-only preference." >&2
  exit 1
fi

read_value() {
  defaults read -g "$1" 2>/dev/null || echo "(system default)"
}

case "${1:-apply}" in
  apply)
    echo "Current KeyRepeat: $(read_value KeyRepeat)"
    echo "Current InitialKeyRepeat: $(read_value InitialKeyRepeat)"
    read -r -p "Set faster key repeat (KeyRepeat=2, InitialKeyRepeat=15)? [y/N] " answer
    if [[ "$answer" == [yY] || "$answer" == [yY][eE][sS] ]]; then
      defaults write -g KeyRepeat -int 2
      defaults write -g InitialKeyRepeat -int 15
      echo "Updated. Some apps may need to be restarted or you may need to log out and back in."
    else
      echo "No changes made."
    fi
    ;;
  reset)
    read -r -p "Remove custom key-repeat values and restore macOS defaults? [y/N] " answer
    if [[ "$answer" == [yY] || "$answer" == [yY][eE][sS] ]]; then
      defaults delete -g KeyRepeat 2>/dev/null || true
      defaults delete -g InitialKeyRepeat 2>/dev/null || true
      echo "Removed custom values. You may need to log out and back in."
    else
      echo "No changes made."
    fi
    ;;
  *)
    echo "Usage: $0 [apply|reset]" >&2
    exit 2
    ;;
esac

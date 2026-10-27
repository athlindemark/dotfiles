# Portable macOS/Linux zsh setup. Keep computer-specific values in .zshrc.local.
DOTFILES_DIR="${${(%):-%x}:A:h}"
PROFILE_FILE="$DOTFILES_DIR/.dotfiles-profile"
DOTFILES_PROFILE="${DOTFILES_PROFILE:-minimal}"
if [[ -r "$PROFILE_FILE" ]]; then
  DOTFILES_PROFILE="$(<"$PROFILE_FILE")"
fi

# A local override can select a profile without changing the shared repo.
if [[ -r "$DOTFILES_DIR/.zshrc.local" ]]; then
  source "$DOTFILES_DIR/.zshrc.local"
fi
DOTFILES_PROFILE="${DOTFILES_PROFILE:-minimal}"

# The old dotfiles repo used zsh-completions and zsh-syntax-highlighting.
# Keep both optional and Extended-only; make completions available before OMZ compinit.
if [[ "$DOTFILES_PROFILE" == "extended" ]]; then
  if command -v brew >/dev/null 2>&1; then
    _brew_prefix="$(brew --prefix 2>/dev/null)"
    [[ -d "$_brew_prefix/share/zsh-completions" ]] && fpath=("$_brew_prefix/share/zsh-completions" $fpath)
  else
    for _completion_dir in /usr/share/zsh-completions /usr/local/share/zsh-completions; do
      [[ -d "$_completion_dir" ]] && fpath=("$_completion_dir" $fpath)
    done
  fi
fi

export HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

export EDITOR="${EDITOR:-vi}"
export VISUAL="${VISUAL:-$EDITOR}"

# Minimal profile preserves the current Oh My Zsh agnoster theme.
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
if [[ -s "$ZSH/oh-my-zsh.sh" ]]; then
  ZSH_THEME="agnoster"
  plugins=(git)
  if [[ "$DOTFILES_PROFILE" == "extended" ]]; then
    plugins=(git docker azure gcloud terraform helm)
    # Starship is the Extended prompt; fall back to agnoster if it is unavailable.
    command -v starship >/dev/null 2>&1 && ZSH_THEME=""
  fi
  source "$ZSH/oh-my-zsh.sh"
fi

# Extended-only prompt and navigation tools.
if [[ "$DOTFILES_PROFILE" == "extended" ]] && command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
if [[ "$DOTFILES_PROFILE" == "extended" ]] && command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if [[ "$DOTFILES_PROFILE" == "extended" ]]; then
  # Git shortcuts and selected terminal tools.
  alias g='git'
  alias gs='git status --short --branch'
  alias ga='git add'
  alias gc='git commit'
  alias gca='git commit --amend'
  alias gsw='git switch'
  alias gsc='git switch -c'
  alias gp='git push'
  alias gl='git log --oneline --decorate -15'
  alias lg='lazygit'
  alias gdh='gh dash'

  # Python project workflow with uv; add ruff/pytest to each project's dev dependencies.
  if command -v uv >/dev/null 2>&1; then
    alias uvi='uv init'
    alias uva='uv add'
    alias uvs='uv sync'
    alias uvr='uv run'
    alias uvp='uv python pin'
    alias uvtest='uv run pytest'
    alias uvlint='uv run ruff check .'
    alias uvfmt='uv run ruff format .'
  fi

  # Convenience aliases only; Docker itself is not installed by this setup.
  alias dps='docker ps'
  alias dcu='docker compose up'
  alias dcd='docker compose down'
fi

# Load the optional syntax highlighter last, as its plugin recommends.
if [[ "$DOTFILES_PROFILE" == "extended" ]]; then
  _highlight_candidates=()
  if command -v brew >/dev/null 2>&1; then
    _brew_prefix="${_brew_prefix:-$(brew --prefix 2>/dev/null)}"
    _highlight_candidates+=("$_brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh")
  fi
  _highlight_candidates+=(
    /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  )
  for _highlight_file in "${_highlight_candidates[@]}"; do
    if [[ -r "$_highlight_file" ]]; then
      source "$_highlight_file"
      break
    fi
  done
fi

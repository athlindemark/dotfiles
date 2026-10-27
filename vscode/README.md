# VS Code

These are portable snippets, not a replacement for your existing VS Code User settings. Merge `settings.json` into the User `settings.json` through **Preferences: Open User Settings (JSON)**; do not replace the whole file. It selects zsh as the Linux terminal default; your current Mac already selects zsh. This intentionally excludes the machine/work-specific settings and database connection entries found in the current User settings.

The `extensions.json` file is a recommendation list. Copy it to a project's `.vscode/extensions.json` if you want VS Code to recommend the extensions for that workspace. It does not install extensions.

`snippets/python.code-snippets` contains a small pytest test-function snippet. Copy it to a project's `.vscode/` folder or to your VS Code User `snippets/python.json` file if you want it globally.

The current Mac keybindings are preserved as a separate platform snippet. For another Mac, merge `keybindings.macos.json` into User `keybindings.json`; on Linux use `keybindings.linux.json`. Review conflicts before merging. The Linux equivalents are suggestions and may conflict with VS Code defaults.

Python settings expect each project to use `.venv` and Ruff/pytest as project development dependencies, for example:

```sh
uv add --dev ruff pytest
```

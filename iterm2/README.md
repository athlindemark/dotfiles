# iTerm2 (macOS only)

`DynamicProfiles/Dotfiles.json` defines a **separate** profile. It inherits colors and other unspecified preferences from iTerm2's `Default` profile, uses JetBrains Mono Nerd Font, and maps Option+Left/Right to backward/forward word movement. It does not replace your existing profile or global iTerm2 preferences.

To load it, copy `DynamicProfiles/Dotfiles.json` into:

```text
~/Library/Application Support/iTerm2/DynamicProfiles/
```

iTerm2 watches that folder and the new profile should appear in Profiles. Select it for a session; choose it as the default only if you want to. You already have the JetBrains Mono Nerd Font cask installed. If the font family name is not recognized, select the installed JetBrains Mono Nerd Font in iTerm2's profile settings.

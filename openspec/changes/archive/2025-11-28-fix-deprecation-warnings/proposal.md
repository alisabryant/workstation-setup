# Change: Fix System Warnings and Update Branding

## Summary
1. Update Zsh configuration to use `initContent` instead of the deprecated `initExtra` option.
2. Update the macOS login window text to "Seventeen Sierra Workstation".
3. Relax Homebrew cleanup mode from `zap` to `uninstall` to avoid permission errors.

## Motivation
1. **Deprecation**: The build output shows a warning about `programs.zsh.initExtra`.
2. **Branding**: The current login text "Rise8 Workstation" is outdated.
3. **Permissions**: The `zap` cleanup mode is causing `Interrupted system call` errors when trying to remove system-protected files (like Recent Documents lists). Switching to `uninstall` is safer and sufficient.

## Impact
- **Configuration**: Modifies `modules/shared/core.nix` and `modules/darwin/default.nix`.
- **DX**: Removes build warnings/errors and updates system branding.

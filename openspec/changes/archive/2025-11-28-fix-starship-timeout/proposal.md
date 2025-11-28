# Change: Fix Starship Timeout Warning

## Summary
Increase the Starship scan timeout to prevent warnings when navigating large directories.

## Motivation
The user is seeing the following warning:
`[WARN] - (starship::context): Scanning current directory timed out.`

This happens when Starship tries to scan a large directory (like the user's home directory or a large repo) to determine the context (git status, package versions, etc.) and takes longer than the default timeout (usually 30ms).

## Impact
- **Configuration**: Modifies `modules/shared/core.nix`.
- **DX**: Eliminates timeout warnings and ensures accurate prompt information.

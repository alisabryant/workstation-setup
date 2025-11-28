# Change: Fix Broken Casks and Dock Icons

## Summary
Disable automated installation of Adobe Acrobat Reader to resolve build failures, and fix broken "question mark" icons in the macOS Dock.

## Motivation
1. **Build Failure**: The automated installer for Adobe Acrobat Reader fails consistently, blocking system updates.
2. **Broken Dock**: Several Dock icons appear as question marks, indicating that the configured paths in `modules/darwin/default.nix` do not match the actual installation locations of the applications.

## Impact
- **Configuration**: Modifies `modules/darwin/default.nix`.
- **DX**: Restores successful builds and ensures a clean, functional Dock.

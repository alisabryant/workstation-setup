# Implementation Plan

- [x] 1. Configuration
  - [x] 1.1 Rename `initExtra` to `initContent` in `core.nix` <!-- id: fix-zsh -->
  - [x] 1.2 Update `loginwindow.LoginwindowText` in `darwin/default.nix` <!-- id: update-branding -->
  - [x] 1.3 Change `homebrew.onActivation.cleanup` to `"uninstall"` in `darwin/default.nix` <!-- id: fix-brew -->

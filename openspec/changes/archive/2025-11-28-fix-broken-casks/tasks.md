# Implementation Plan

- [x] 1. Fix Build Failure
  - [x] 1.1 Comment out `adobe-acrobat-reader` in `darwin/default.nix` <!-- id: disable-adobe -->

- [x] 2. Fix Dock Icons
  - [x] 2.1 Verify actual installation paths of Dock apps <!-- id: verify-paths -->
  - [x] 2.2 Update `persistent-apps` paths in `darwin/default.nix` <!-- id: fix-dock -->

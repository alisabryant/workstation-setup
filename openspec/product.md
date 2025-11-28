# Product: Unified Workstation Configuration

## Vision
A reproducible, identical developer environment across macOS and Linux machines, managed as code.

## Goals
- **Reproducibility**: Ensure the exact same tool versions and configurations on every machine.
- **Portability**: Seamlessly switch between macOS (Laptop, Studio) and Linux.
- **Modularity**: distinct separation between "Core Identity" (Shell, Git) and "Usecases" (Gaming, Streaming, Development).
- **Security**: Safe management of PII and secrets via local-only files.

## Core Capabilities
- **Developer Identity**: Zsh, Starship, Git, Direnv, Mise.
- **IDE Management**: VS Code extensions and settings managed via Nix.
- **System Defaults**: macOS Dock, Finder, and System Preferences.
- **Usecase Profiles**: Composable modules for specific workflows (Dev, Game, Stream).

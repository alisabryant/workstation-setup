# Tech Stack & Conventions

## Technology Stack

### Core
- **Language**: [Nix](https://nixos.org/)
- **Package Manager**: Nix Flakes
- **OS Configuration**:
    - macOS: [nix-darwin](https://github.com/LnL7/nix-darwin)
    - Linux: [home-manager](https://github.com/nix-community/home-manager)

### Shell Environment
- **Shell**: Zsh
- **Prompt**: Starship (Rosé Pine theme)
- **Env Management**: Direnv, Mise
- **CLI Tools**: `git`, `fzf`, `ripgrep`, `jq`, `lazygit`

### Development
- **Editor**: VS Code (configured via `modules/shared/vscode.nix`)
- **Secrets**: `modules/shared/secrets.nix` (Pattern: `secrets.nix.example` template)

## Conventions

### Code Style
- **Formatting**: Standard Nix formatting.
- **Naming**: Kebab-case for files (`usecase-develop.nix`).

### Configuration Patterns
- **Usecases**: Feature-specific configurations are isolated in `usecase-*.nix` files.
- **Secrets**: NEVER commit `secrets.nix`. Always update `secrets.nix.example` when adding new secret keys.
- **Idempotency**: All configurations must be reproducible. Avoid imperative `run_command` steps in setup unless wrapped in a script.

### OpenSpec Workflow
- **Changes**: All significant changes must go through the OpenSpec workflow (`openspec/changes/`).
- **Specs**: Capabilities are defined in `openspec/specs/`.

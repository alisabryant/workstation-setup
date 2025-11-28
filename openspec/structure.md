# Structure & Architecture

## Directory Map

```
.
├── flake.nix                   # Entry point: Defines System Configurations
├── flake.lock                  # Pin dependencies
├── install_theme.py            # Utility script
├── setup-secrets.sh            # Bootstrap script for secrets
├── modules/
│   ├── shared/                 # OS-Agnostic Configuration
│   │   ├── core.nix            # Shell, Git, CLI Tools (The Identity)
│   │   ├── vscode.nix          # VS Code Settings & Extensions
│   │   └── secrets.nix         # [GITIGNORED] Local secrets
│   ├── darwin/                 # macOS Specifics
│   │   ├── default.nix         # Base System (Dock, Finder, Fonts)
│   │   ├── machine-studio.nix  # Hardware: Mac Studio
│   │   └── usecase-*.nix       # Feature Flags (Game, Stream, Develop)
│   └── linux/                  # Linux Specifics
│       └── home.nix            # Home Manager config for Linux
└── openspec/                   # Specifications & Change Management
```

## Architecture

### The Module System
The configuration is built on a **Module System** to maximize code reuse.

1.  **Inputs (`flake.nix`)**: Pulls `nixpkgs`, `nix-darwin`, and `home-manager`.
2.  **Systems**:
    *   `darwinConfigurations`: Entry points for macOS hosts (`laptop`, `studio`).
    *   `homeConfigurations`: Entry point for generic Linux (`localhost`).
3.  **Layers**:
    *   **System Layer** (`darwin/default.nix`): OS-level settings (Dock, Finder).
    *   **User Layer** (`home-manager`): User-level packages and dotfiles.
    *   **Shared Layer** (`modules/shared/`): Common config imported by all systems.

### Data Flow
`secrets.nix` (Local) -> `flake.nix` (Inputs) -> `modules/*.nix` (Consumer)

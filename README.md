# Unified Workstation Configuration (Nix)

This repository manages a **Unified Workstation Configuration** for macOS and Linux. It uses **Nix Flakes**, **Nix-Darwin**, and **Home Manager** to ensure a reproducible, identical setup on any machine.

## 🏗 Architecture

The configuration is built using a **Module System** to maximize code reuse while respecting OS differences.

| Module                           | Purpose                    | Contents                                                  |
| :------------------------------- | :------------------------- | :-------------------------------------------------------- |
| **`shared/core.nix`**            | **The Developer Identity** | Zsh, Git config, CLI tools (Direnv, Mise, etc.).          |
| **`shared/vscode.nix`**          | **IDE Config**             | VSCodium settings & extensions.                           |
| **`darwin/default.nix`**         | **Mac Base System**        | Dock settings, Finder prefs, Base Casks (Chrome, Iterm2). |
| **`darwin/machine-studio.nix`**  | **Studio Hardware**        | Hardware specific tools (Corsair iCUE, Stream Deck).      |
| **`darwin/usecase-develop.nix`** | **Dev Tools**              | Zed, Firefox, Docker, Podman.                             |
| **`darwin/usecase-game.nix`**    | **Gaming**                 | Steam.                                                    |
| **`linux/home.nix`**             | **Linux System**           | Linux-specific configuration.                             |

## 🚀 Installation (Bootstrap)

### 1. Install Nix

You must have the Nix package manager installed.

```bash
sh <(curl -L https://nixos.org/nix/install)
```

_Restart your terminal after installation to ensure `nix` is in your path._

### 2. Clone the Repo

```bash
git clone https://github.com/yourusername/workstation-setup.git ~/workstation-setup
cd ~/workstation-setup
```

### 3. Setup Secrets (Required)

This repository uses a local `secrets.nix` file to manage PII (usernames, emails, hostnames).

1.  Run the setup script:
    ```bash
    ./setup-secrets.sh
    ```
2.  Open `modules/shared/secrets.nix` and replace the placeholder values with your actual information (from your Password Manager).
    - **Note**: Ensure `laptopHostname` and `studioHostname` match your actual machine names (run `scutil --get LocalHostName` to check).

### 4. Apply Configuration

```bash
# For macOS (requires sudo and experimental flags for first run)
# We use the full path to 'nix' to ensure sudo finds it
sudo /nix/var/nix/profiles/default/bin/nix run --extra-experimental-features 'nix-command flakes' nix-darwin -- switch --flake .
```

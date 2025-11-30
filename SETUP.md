# Mac Studio Setup Guide

This document provides the complete step-by-step process for setting up your Mac Studio from a **completely fresh macOS install**.

## Phase 1: Initial macOS Configuration

These are the very first steps after unboxing or resetting your Mac.

### 1. macOS First-Time Setup Wizard
- Complete the macOS setup assistant
- **Sign into iCloud account** (required for App Store, etc.)
- **Set up Touch ID** (fingerprint reader)
- **Configure display settings** (arrangement, resolution, etc.)

### 2. Install Essential Browsers & Extensions

#### Google Chrome
1. Download Chrome from [google.com/chrome](https://www.google.com/chrome/)
2. Install and open Chrome
3. **Set Chrome as default browser**:
   - System Settings > Desktop & Dock > Default web browser > Google Chrome
4. **Sign into Google accounts** on your Chrome profiles
5. **Install Bitwarden extension**:
   - Visit [chrome.google.com/webstore](https://chrome.google.com/webstore)
   - Search for "Bitwarden"
   - Add to Chrome and sign in

### 3. Install Development Tools

#### Antigravity IDE
1. Download Antigravity from [antigravity.dev](https://antigravity.dev) (or your source)
2. Install the application
3. **Install extensions**:
   - GitHub Pull Requests and Issues
   - GitHub Actions
   - Rose Pine (theme)

#### Xcode Command Line Tools
```bash
xcode-select --install
```
This installs Git and other essential development tools.

#### GitHub CLI
1. Download from [cli.github.com](https://cli.github.com)
2. Install the package
3. Authenticate:
   ```bash
   gh auth login
   ```

### 4. Create Workspace and Clone Repository

```bash
# Create workspace directory
mkdir -p ~/Documents/Github

# Clone this repository
cd ~/Documents/Github
gh repo clone yourusername/workstation-setup
# Or: git clone https://github.com/yourusername/workstation-setup.git

cd workstation-setup
```

## Phase 2: Automated Setup Process

### Step 1: Install Nix Package Manager

Install the Determinate Systems Nix installer (recommended for macOS):

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

**Note**: This will:
- Create a Nix volume on your disk
- Add build users and groups
- Require your password for sudo access

### Step 2: Install Homebrew

Nix-Darwin requires Homebrew to be pre-installed for managing casks:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the post-installation instructions to add Homebrew to your PATH:

```bash
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Step 3: Configure Secrets

Run the secrets setup script:

```bash
./setup-secrets.sh
```

Then edit `modules/shared/secrets.nix` with your personal information:

```bash
# Open in your editor
open modules/shared/secrets.nix
```

**Required values:**
- `username`: Your macOS username (run `whoami` to check)
- `email`: Your email address
- `gitName`: Your full name for Git commits
- `githubUsername`: Your GitHub username
- `studioHostname`: Your Mac's hostname (run `scutil --get LocalHostName`)

**Example:**
```nix
{
  username = "your-username";
  linuxUser = "your-username";
  email = "[email protected]";
  gitName = "Your Full Name";
  githubUsername = "your-github-handle";
  laptopHostname = "Your-MacBook-Pro";
  studioHostname = "Your-Mac-Studio";
}
```

### Step 4: Apply Configuration

Apply the Nix-Darwin configuration:

```bash
sudo /nix/var/nix/profiles/default/bin/nix run --extra-experimental-features 'nix-command flakes' nix-darwin -- switch --flake .
```

**What this does:**
- Installs all configured packages (CLI tools, development tools, etc.)
- Configures system settings (Dock, Finder, etc.)
- Installs Homebrew casks (applications)
- Sets up shell environment (Zsh with Starship prompt)
- Configures Git and other development tools

**Expected duration:** 10-20 minutes (depending on internet speed)

### Step 5: Post-Installation

After the configuration completes:

1. **Restart your terminal** or open a new terminal window to load the new shell configuration

2. **Verify installation:**
   ```bash
   # Check Nix
   nix --version
   
   # Check installed tools
   zoxide --version
   eza --version
   lazygit --version
   btop --version
   ```

3. **Future updates:**
   ```bash
   # After making changes to configuration files
   just apply
   ```

## Manual Installation Required

Some applications require manual installation due to authentication requirements or unavailable casks:

### Studio Hardware
- **Corsair iCUE**: Download from [corsair.com/icue](https://www.corsair.com/us/en/s/icue)
- **Elgato Stream Deck**: Download from [elgato.com/downloads](https://www.elgato.com/us/en/s/downloads)

### Development Tools
- **VMware Fusion**: Download from [Broadcom](https://support.broadcom.com/group/ecx/productdownloads?subfamily=VMware+Fusion) (requires Broadcom account)

### Optional: Enable Global Hotkeys

The configuration includes global hotkey support via **AeroSpace**.

**Configured hotkeys:**
- `Cmd + Return` → iTerm2
- `Cmd + Shift + M` → YouTube Music
- `Cmd + Shift + Z` → Zed
- `Cmd + Shift + C/E` → Outlook
- `Cmd + Shift + A` → Gemini
- `Cmd + Shift + D` → Discord
- `Alt + H/J/K/L` → Window Navigation

### Media Keys (F7, F8, F9)
To control YouTube Music PWA with your keyboard's media keys:

1. **Enable JavaScript in Chrome** (Required):
   - Open Chrome
   - Menu Bar > View > Developer > **Allow JavaScript from Apple Events**

2. **Block Apple Music** (Recommended):
   - The setup installs **noTunes** to prevent Apple Music from hijacking the keys
   - Ensure `noTunes` is running (icon in menu bar)

3. **Usage**:
   - F7: Previous Track
   - F8: Play/Pause
   - F9: Next Track
   - *Note: You may need to hold `Fn` depending on your keyboard settings*

## What Gets Installed

### System Configuration
- Dock: No autohide, custom size and magnification
- Finder: Show all files, extensions, path bar
- Screenshots: Save to clipboard by default
- Keyboard: Fast key repeat

### Applications (via Homebrew)
- **Browsers**: Chrome, Firefox
- **Communication**: Discord, Outlook
- **Development**: Zed, PyCharm, VS Code
- **Utilities**: iTerm2, Obsidian, Google Drive, Adobe Creative Cloud

### CLI Tools (via Nix)
- **Shell**: Zsh with Starship prompt, zoxide, eza
- **Development**: Git, GitHub CLI, Docker, Podman, Mise, Direnv
- **Languages**: Python 3, Node.js, TypeScript
- **Utilities**: ripgrep, fd, fzf, jq, lazygit, lazydocker, btop, fastfetch

### Shell Functions
Custom functions available in your shell:
- `compress [file.tar.gz]` - Create tar.gz archive
- `decompress [file.tar.gz]` - Extract tar.gz archive
- `img2jpg [file]` - Convert image to JPEG
- `img2jpg-small [file]` - Convert and resize to 1080p JPEG
- `img2png [file]` - Convert image to PNG

## Troubleshooting

### "Primary user does not exist" error
- Ensure `username` in `modules/shared/secrets.nix` matches your macOS username (`whoami`)

### "Git tree has uncommitted changes" warning
- This is normal - the configuration needs to see your changes to apply them
- The warning can be safely ignored

### Homebrew cask installation failures
- Some casks require manual installation (see "Manual Installation Required" section)
- Failed casks won't prevent the rest of the setup from completing

### Permission prompts during installation
- **Determinate Systems**: Required for Nix daemon (safe to allow)
- **sh (unidentified developer)**: Required for activation scripts (safe to allow)
- **skhd**: Only if you enable global hotkeys (optional)

## Updating Your Configuration

After making changes to any `.nix` files:

```bash
# Apply changes
just apply

# Or manually:
git add -f modules/shared/secrets.nix
sudo darwin-rebuild switch --flake .
git reset modules/shared/secrets.nix
```

## System Maintenance

### Update Nix packages
```bash
just update
```

### Garbage collection
Nix garbage collection is currently disabled (managed by Determinate Systems).
To manually clean up old packages:
```bash
nix-collect-garbage -d
```

## Additional Resources

- [Nix Darwin Documentation](https://github.com/LnL7/nix-darwin)
- [Home Manager Documentation](https://nix-community.github.io/home-manager/)
- [Determinate Systems](https://determinate.systems/)

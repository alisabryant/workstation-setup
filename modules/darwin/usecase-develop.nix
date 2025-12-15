{ pkgs, ... }: {
  homebrew.casks = [
     "zed"
     "firefox"
     "pycharm"
     # TODO: Install VMware Fusion manually from https://support.broadcom.com/group/ecx/productdownloads?subfamily=VMware+Fusion
     # "vmware-fusion"  # Requires Broadcom account authentication
     "visual-studio-code"
     # Podman Desktop: Open source container management for macOS (Apache 2.0)
     # Manages the Podman Machine VM and provides a GUI for containers
     "podman-desktop"
  ];
  
  environment.systemPackages = with pkgs; [
    # Podman: Primary container engine (daemonless, rootless, OCI-compliant)
    podman
    podman-compose  # Compatible with docker-compose.yml files
    
    # Container build tools
    buildah         # Build OCI images (like docker build)
    skopeo          # Copy/inspect container images
    
    # Optional: qemu for Podman Machine on macOS
    qemu
  ];

  # system.defaults.dock.autohide = false; # Optional override

  system.activationScripts.createDevGroup.text = ''
    echo "Grouping Development Apps..."
    DEV_FOLDER="$HOME/Applications/Development"
    mkdir -p "$DEV_FOLDER"
    
    # Clear old links
    rm -f "$DEV_FOLDER"/*.app

    # Create shortcuts
    # Create shortcuts
    ln -sf "/Applications/Zed.app" "$DEV_FOLDER/" || true
    ln -sf "/Applications/Firefox.app" "$DEV_FOLDER/" || true
    ln -sf "/Applications/PyCharm CE.app" "$DEV_FOLDER/" || true
    ln -sf "/Applications/VMware Fusion.app" "$DEV_FOLDER/" || true
    ln -sf "/Applications/Visual Studio Code.app" "$DEV_FOLDER/" || true
    ln -sf "/Applications/Podman Desktop.app" "$DEV_FOLDER/" || true
  '';

  system.activationScripts.addDevStack.text = ''
    if command -v dockutil >/dev/null; then
      if ! dockutil --find "Development" >/dev/null; then
        echo "Pinning Development Stack to Dock..."
        dockutil --add "$HOME/Applications/Development" --view grid --display stack --sort name --folder --no-restart
        killall Dock
      fi
    fi
  '';
}
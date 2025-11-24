{ pkgs, ... }: {
  homebrew.casks = [
     "zed"
     "firefox"
     "pycharm"
     "vmware-fusion"
     "visual-studio-code"
     
  ];
  home.packages = with pkgs; [
    docker
    docker-compose
    podman
  ];

  # system.defaults.dock.autohide = false; # Optional override

  system.activationScripts.createDevGroup.text = ''
    echo "Grouping Development Apps..."
    DEV_FOLDER="$HOME/Applications/Development"
    mkdir -p "$DEV_FOLDER"
    
    # Clear old links
    rm -f "$DEV_FOLDER"/*.app

    # Create shortcuts
    ln -sf "/Applications/Zed.app" "$DEV_FOLDER/" || true
    ln -sf "/Applications/Firefox.app" "$DEV_FOLDER/" || true
    ln -sf "/Applications/PyCharm CE.app" "$DEV_FOLDER/" || true
    ln -sf "/Applications/VMware Fusion.app" "$DEV_FOLDER/" || true
    ln -sf "/Applications/Visual Studio Code.app" "$DEV_FOLDER/" || true
    ln -sf "/Applications/Docker.app" "$DEV_FOLDER/" || true
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
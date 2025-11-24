{ pkgs, ... }: {
  homebrew.casks = [
    "steam"
  ];
  # system.defaults.dock.autohide = false; # Optional override

  system.activationScripts.createGameGroup.text = ''
    echo "Grouping Game Apps..."
    GAME_FOLDER="$HOME/Applications/Games"
    mkdir -p "$GAME_FOLDER"
    
    # Clear old links
    rm -f "$GAME_FOLDER"/*.app

    # Create shortcuts
    ln -sf "/Applications/Steam.app" "$GAME_FOLDER/" || true
  '';

  system.activationScripts.addGameStack.text = ''
    if command -v dockutil >/dev/null; then
      if ! dockutil --find "Games" >/dev/null; then
        echo "Pinning Games Stack to Dock..."
        dockutil --add "$HOME/Applications/Games" --view grid --display stack --sort name --folder --no-restart
        killall Dock
      fi
    fi
  '';
}
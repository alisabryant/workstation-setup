{ pkgs, userSettings, ... }: {
  environment.systemPackages = [ pkgs.dockutil pkgs.podman ];

  # Required for newer nix-darwin versions
  users.users.${userSettings.username}.home = "/Users/${userSettings.username}";
  system.primaryUser = userSettings.username;
  
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    casks = [
      "google-chrome"
      "google-drive"
      "adobe-creative-cloud"
      "iterm2"
      "obsidian"
      "discord"
      "microsoft-outlook"
      "nikitabobko/tap/aerospace"  # Tiling window manager with hotkey support
      "notunes" # Prevents Apple Music from launching
      # "microsoft-office"  # Install manually if needed - automated install often fails
      # "adobe-acrobat-reader"
    ];
  };


  system.defaults = {
    dock = {
      autohide = true;
      tilesize = 36;
      largesize = 72;
      magnification = true;
      orientation = "bottom";
      show-recents = false;
      minimize-to-application = true;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      persistent-apps = [
        "/Applications/Google Chrome.app"
        "/Users/${userSettings.username}/Applications/Chrome Apps.localized/Google Chat.app"
        "/Applications/Obsidian.app"
        "/Users/${userSettings.username}/Applications/Chrome Apps.localized/YouTube Music.app"
      ];
      persistent-others = [
        "/Users/${userSettings.username}/Downloads"
        "/Users/${userSettings.username}/Documents"
        "/Users/${userSettings.username}/Applications/Productivity"
      ];
    };
    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      _FXShowPosixPathInTitle = true;
      FXPreferredViewStyle = "clmv";
    };
    NSGlobalDomain = {
      KeyRepeat = 1;
      InitialKeyRepeat = 15;
      "com.apple.swipescrolldirection" = true;
      "com.apple.mouse.tapBehavior" = 1;
      AppleWindowTabbingMode = "fullscreen";
    };
    screencapture = {
      location = "~/Desktop/Screenshots";
      type = "png";
      disable-shadow = true;
      # Save screenshots to clipboard instead of file
      target = "clipboard";
    };
    loginwindow.LoginwindowText = "Seventeen Sierra Workstation";
  };
  
  system.activationScripts.postActivation.text = ''
    # Productivity Folder
    # TODO: Install Microsoft Office manually (automated install often fails)
    # Download from: https://www.microsoft.com/en-us/microsoft-365/mac/microsoft-365-for-mac
    mkdir -p /Users/${userSettings.username}/Applications/Productivity
    ln -sf "/Applications/Microsoft Word.app" "/Users/${userSettings.username}/Applications/Productivity/" 2>/dev/null || true
    ln -sf "/Applications/Microsoft Excel.app" "/Users/${userSettings.username}/Applications/Productivity/" 2>/dev/null || true
    ln -sf "/Applications/Microsoft PowerPoint.app" "/Users/${userSettings.username}/Applications/Productivity/" 2>/dev/null || true
    ln -sf "/Applications/Adobe Acrobat Reader.app" "/Users/${userSettings.username}/Applications/Productivity/" 2>/dev/null || true
    ln -sf "/Users/${userSettings.username}/Applications/Chrome Apps.localized/Quicken Simplifi.app" "/Users/${userSettings.username}/Applications/Productivity/" 2>/dev/null || true
    chown -R ${userSettings.username}:staff "/Users/${userSettings.username}/Applications/Productivity"

    # Podman Setup
    # Run as the user with proper HOME environment, not root
    PODMAN_CMD="/run/current-system/sw/bin/podman"
    USER_NAME="${userSettings.username}"
    
    if [ -f "$PODMAN_CMD" ]; then
      echo "Checking Podman machine status for $USER_NAME..."
      # Use sudo -Hiu to set HOME environment properly
      if ! sudo -Hiu "$USER_NAME" "$PODMAN_CMD" machine list 2>/dev/null | grep -q "podman-machine-default"; then
        echo "Initializing Podman machine..."
        sudo -Hiu "$USER_NAME" "$PODMAN_CMD" machine init || echo "Podman machine init failed or already exists"
        sudo -Hiu "$USER_NAME" "$PODMAN_CMD" machine start || echo "Podman machine start failed or already running"
      else
        echo "Podman machine already exists."
        # Ensure it's started
        if ! sudo -Hiu "$USER_NAME" "$PODMAN_CMD" machine list 2>/dev/null | grep "podman-machine-default" | grep -q "Running"; then
           echo "Starting Podman machine..."
           sudo -Hiu "$USER_NAME" "$PODMAN_CMD" machine start || echo "Podman machine already running"
        fi
      fi
    fi
  '';


  # services.nix-daemon.enable = true; # Deprecated
  nix.enable = false;
  # nix.settings.experimental-features = "nix-command flakes";
  
  # Automatic garbage collection to prevent disk space buildup
  # nix.gc = {
  #   automatic = true;
  #   interval = { Weekday = 0; Hour = 3; Minute = 0; }; # Sunday at 3 AM
  #   options = "--delete-older-than 7d";
  # };
  
  system.stateVersion = 5;
}
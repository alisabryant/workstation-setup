{ pkgs, userSettings, ... }: {
  environment.systemPackages = [ pkgs.dockutil ];

  # Required for newer nix-darwin versions
  users.users.${userSettings.username}.home = "/Users/${userSettings.username}";
  system.primaryUser = userSettings.username;
  
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "google-chrome"
      "google-drive"
      "adobe-creative-cloud"
      "rectangle"
      "iterm2"
      "obsidian"
      "discord"
      "bitwarden"
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
        "/Applications/iTerm.app"
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
    };
    loginwindow.LoginwindowText = "Rise8 Workstation";
  };
  
  # services.nix-daemon.enable = true; # Deprecated
  nix.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 5;
}
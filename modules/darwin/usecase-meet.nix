{ pkgs, ... }: {
  homebrew.casks = [
     "microsoft-teams"
     "slack"
     "zoom"
     "signal"
     
  ];
  # system.defaults.dock.autohide = false; # Optional override
}
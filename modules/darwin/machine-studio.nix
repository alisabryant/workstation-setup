{ pkgs, ... }: {
  # TODO: Install studio hardware software manually:
  # - Corsair iCUE: https://www.corsair.com/us/en/s/icue
  # - Elgato Stream Deck: https://www.elgato.com/us/en/s/downloads
  homebrew.casks = [
    # "corsair-icue"  # Cask unavailable, install manually
    # "elgato-stream-deck"  # May require manual installation
    
  ];
  # system.defaults.dock.autohide = false; # Optional override
}
{ pkgs, ... }: {
  homebrew.casks = [
     "zed"
     "firefox"
     "pycharm"
     "vmware-fusion"
     "visual-studio-code"
     
  ];
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    podman
  ];

  # system.defaults.dock.autohide = false; # Optional override
}
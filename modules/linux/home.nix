{ pkgs, userSettings, ... }: {
  home.username = userSettings.linuxUser;
  home.homeDirectory = "/home/" + userSettings.linuxUser;
  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    gnome.gnome-tweaks
    xclip
    gnumake
    gcc
    pkg-config
    
  ];
  programs.chromium.enable = true;
}
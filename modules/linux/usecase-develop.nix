{ pkgs, ... }: {
  home.packages = with pkgs; [
    zed-editor
    firefox
    docker
    docker-compose
    podman
  ];
}
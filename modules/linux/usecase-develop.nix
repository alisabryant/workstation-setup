{ pkgs, ... }: {
  home.packages = with pkgs; [
    zed-editor
    firefox
    
    # Podman: Primary container engine (daemonless, rootless, OCI-compliant)
    # On Linux, Podman runs natively without a VM - more secure than Docker
    podman
    podman-compose
    
    # Container build tools
    buildah   # Build OCI images (like docker build)
    skopeo    # Copy/inspect container images
  ];
}
# Justfile for Workstation Setup

# Apply the configuration to the local machine
apply:
    @echo "🔒 Staging secrets..."
    @git add -f modules/shared/secrets.nix
    @echo "🚀 Rebuilding system..."
    @sudo darwin-rebuild switch --flake . || (git reset modules/shared/secrets.nix && exit 1)
    @echo "🔓 Unstaging secrets..."
    @git reset modules/shared/secrets.nix
    @echo "✅ Done!"

# Update flake inputs and apply
update:
    @nix flake update
    @just apply

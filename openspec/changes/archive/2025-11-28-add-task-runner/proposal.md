# Change: Add Task Runner (Just)

## Summary
Introduce `just` as a command runner to automate complex workflows, specifically the safe handling of local secrets during Nix builds.

## Motivation
Nix Flakes ignores files listed in `.gitignore`, causing builds to fail because `secrets.nix` is not visible to the flake.
- **Current Workaround**: Manually running `git add -f modules/shared/secrets.nix` before every build.
- **Risk**: Users might accidentally commit secrets if they forget to unstage them.
- **Solution**: A `Justfile` can automate the "stage -> build -> unstage" workflow, ensuring secrets are used for the build but never committed.

## Impact
- **Configuration**: Adds `just` to `modules/shared/core.nix`.
- **New File**: `Justfile` in the root directory.
- **DX**: Replaces long `darwin-rebuild` commands with simple `just apply`.

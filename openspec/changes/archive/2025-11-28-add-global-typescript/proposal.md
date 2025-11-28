# Change: Add Global TypeScript Support

## Summary
Install TypeScript globally via Nix to ensure `tsc` is always available and to override unhelpful system wrappers.

## Motivation
The user encounters the error "This is not the tsc command you are looking for" when attempting to run TypeScript commands. This is likely due to a system stub or missing local dependency. Providing a global `tsc` binary ensures a consistent fallback and smoother developer experience.

## Impact
- **Configuration**: Adds `typescript` to `modules/shared/core.nix`.
- **DX**: `tsc` command will be globally available in the shell.

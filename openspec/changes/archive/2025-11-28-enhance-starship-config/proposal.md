# Change: Enhance Starship Configuration

## Summary
Upgrade the Starship prompt configuration to include cloud context awareness (AWS, GCloud, Azure, Kubernetes), system performance telemetry, and a transient prompt for cleaner terminal history.

## Glossary
- **Transient Prompt**: A UI pattern where the full prompt is displayed for the active line, but replaced by a minimal symbol (e.g., `❯`) in the scrollback history.
- **Context Awareness**: Displaying environment details (Kubernetes cluster, AWS profile) only when relevant tools are active.

## Motivation
The current prompt is aesthetically pleasing (Rosé Pine) but lacks functional density for advanced workflows.
- **Safety**: Developers need to know which Kubernetes cluster or AWS account they are targeting to avoid production accidents.
- **Performance**: Long-running commands should automatically report their duration.
- **Focus**: A "Transient Prompt" reduces visual noise in the terminal history, making logs easier to read.

## Impact
- **Architecture**: No structural changes.
- **Configuration**: Modifies `modules/shared/core.nix` (Starship settings).
- **DX**: Immediate visual feedback for environment context and command performance.

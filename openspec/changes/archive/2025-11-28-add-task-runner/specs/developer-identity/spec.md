## ADDED Requirements

### Requirement: Workflow Automation
The system SHALL provide a task runner to simplify common administrative commands.

#### Scenario: Apply Configuration
- **WHEN** the user runs `just apply`
- **THEN** the system SHALL stage `modules/shared/secrets.nix`
- **AND** the system SHALL run `darwin-rebuild switch --flake .`
- **AND** the system SHALL unstage `modules/shared/secrets.nix` immediately after (regardless of success/failure)

#### Scenario: Update System
- **WHEN** the user runs `just update`
- **THEN** the system SHALL run `nix flake update`
- **AND** the system SHALL run `just apply`

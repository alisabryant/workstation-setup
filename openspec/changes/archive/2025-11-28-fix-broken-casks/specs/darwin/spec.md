## ADDED Requirements

### Requirement: Base Applications
The system SHALL install a core set of applications via Homebrew Cask, excluding those known to be unstable in automation.

#### Scenario: Stable Build
- **WHEN** the user runs `just apply`
- **THEN** the build SHALL complete successfully
- **AND** it SHALL NOT attempt to install `adobe-acrobat-reader`

### Requirement: Dock Configuration
The system SHALL configure the macOS Dock with valid shortcuts to installed applications.

#### Scenario: Valid Icons
- **WHEN** the system configuration is applied
- **THEN** the Dock SHALL display the configured applications
- **AND** there SHALL be no "question mark" icons indicating missing files

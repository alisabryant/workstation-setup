## ADDED Requirements

### Requirement: Shell Configuration
The system SHALL configure the Zsh shell using modern, non-deprecated options.

#### Scenario: Clean Build
- **WHEN** the user runs `just apply`
- **THEN** the build SHALL complete successfully
- **AND** it SHALL NOT display warnings about `programs.zsh.initExtra`

### Requirement: System Branding
The system SHALL display the correct organization branding on the login screen.

#### Scenario: Login Text
- **WHEN** the machine is at the login screen
- **THEN** it SHALL display "Seventeen Sierra Workstation"

### Requirement: Homebrew Cleanup
The system SHALL manage Homebrew packages without triggering permission errors on system files.

#### Scenario: Safe Cleanup
- **WHEN** the user runs `just apply`
- **THEN** Homebrew SHALL uninstall unmanaged casks
- **BUT** it SHALL NOT attempt to "zap" (remove) system-protected preference files

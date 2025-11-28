# developer-identity Specification

## Purpose
TBD - created by archiving change enhance-starship-config. Update Purpose after archive.
## Requirements
### Requirement: Cloud Context Awareness
The prompt SHALL display active cloud environment details to prevent context errors.

#### Scenario: Kubernetes Context
- **WHEN** a `kubectl` context is active
- **THEN** the prompt SHALL display the current cluster and namespace
- **AND** the symbol SHALL be "⎈"

#### Scenario: AWS Profile
- **WHEN** the `AWS_PROFILE` environment variable is set
- **THEN** the prompt SHALL display the active profile name
- **AND** the symbol SHALL be "☁️"

#### Scenario: Google Cloud Context
- **WHEN** the gcloud configuration is active
- **THEN** the prompt SHALL display the active project/account
- **AND** the symbol SHALL be "🇬️"

#### Scenario: Azure Context
- **WHEN** the azure configuration is active
- **THEN** the prompt SHALL display the active subscription
- **AND** the symbol SHALL be "🇦️"

#### Scenario: Container Context
- **WHEN** a `Dockerfile` or `docker-compose.yml` is present in the directory
- **THEN** the prompt SHALL display the Docker symbol "🐳"

### Requirement: Performance Telemetry
The prompt SHALL provide feedback on system state and command performance.

#### Scenario: Command Duration
- **WHEN** a command takes longer than 2 seconds
- **THEN** the prompt SHALL display the execution time
- **AND** the style SHALL be "bold yellow"

#### Scenario: Low Battery Warning
- **WHEN** the battery level drops below 10%
- **THEN** the prompt SHALL display the battery percentage
- **AND** the style SHALL be "bold red"

### Requirement: Transient Prompt
The prompt SHALL minimize visual noise in the terminal history.

#### Scenario: Scrollback Cleanup
- **WHEN** a command is executed (Enter key pressed)
- **THEN** the previous prompt SHALL be replaced by a minimal character "❯"
- **AND** the full context information SHALL be removed from the history

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

### Requirement: Global TypeScript Availability
The system SHALL provide a global TypeScript compiler to ensure command availability.

#### Scenario: TSC Command
- **WHEN** the user runs `tsc --version`
- **THEN** the system SHALL display the installed TypeScript version
- **AND** the system SHALL NOT display "This is not the tsc command you are looking for"

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

### Requirement: Prompt Performance
The command prompt SHALL display contextual information without timing out on large directories.

#### Scenario: Large Directory Scan
- **WHEN** the user navigates to a directory with many files
- **THEN** the prompt SHALL render successfully
- **AND** it SHALL NOT display a timeout warning


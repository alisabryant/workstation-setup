## ADDED Requirements

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

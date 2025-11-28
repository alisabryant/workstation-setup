## ADDED Requirements

### Requirement: Prompt Performance
The command prompt SHALL display contextual information without timing out on large directories.

#### Scenario: Large Directory Scan
- **WHEN** the user navigates to a directory with many files
- **THEN** the prompt SHALL render successfully
- **AND** it SHALL NOT display a timeout warning

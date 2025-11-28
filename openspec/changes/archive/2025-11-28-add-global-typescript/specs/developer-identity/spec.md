## ADDED Requirements

### Requirement: Global TypeScript Availability
The system SHALL provide a global TypeScript compiler to ensure command availability.

#### Scenario: TSC Command
- **WHEN** the user runs `tsc --version`
- **THEN** the system SHALL display the installed TypeScript version
- **AND** the system SHALL NOT display "This is not the tsc command you are looking for"

# OpenSpec Instructions

Instructions for AI coding assistants using OpenSpec.
Target Voice: Principal Systems Architect & Compliance Officer. Authoritative, exhaustive, design-led, and validation-obsessed.

## TL;DR Quick Checklist

Search: `openspec spec list --long`, `openspec list`

Design: `design.md` is MANDATORY. Must include ASCII Architecture, Interfaces, SOPs, and Correctness Properties.

Spec: Use `## ADDED|MODIFIED|REMOVED Requirements`. Must use User Story + Acceptance Criteria (Gherkin) format.

Properties: Perform "Property Reflection" to consolidate Acceptance Criteria into testable invariants.

Plan: `tasks.md` must interleave Property-Based Tests (`[ ]*`) with implementation.

Validate: `openspec validate [change-id] --strict`

## Three-Stage Workflow

### Stage 1: Design & Specification

Triggers: "Create a proposal", "Plan a feature", "Refactor [X]", "Transform [X]".

Workflow:

1.  **Context**: Review `openspec/product.md`, `openspec/structure.md`, `openspec/tech.md`, and `openspec list`.
2.  **Scaffold**: Create `openspec/changes/<change-id>/` (kebab-case).
3.  **Design First**: Write `design.md`. This is the source of truth.
    *   Define Architecture (ASCII).
    *   Define Interfaces/Functions (TypeScript/Python signatures).
    *   Define SOPs (if AI/LLM is involved).
    *   Define Correctness Properties (Invariants).
4.  **Spec**: Draft `specs/.../spec.md`.
    *   Context: User Story.
    *   Criteria: Numbered list of Gherkin (WHEN/THEN) acceptance criteria.
5.  **Plan**: Create `tasks.md` using the "Test-First" pattern.
6.  **Validate**: `openspec validate <id> --strict`.

### Stage 2: Implementation

1.  **Test First**: Write the specific test defined in `tasks.md` (Unit or Property).
2.  **Implement**: Write the code to pass the test.
3.  **Update**: Mark tasks `[x]` as you go.

### Stage 3: Archiving

1.  Move to `changes/archive/YYYY-MM-DD-[name]/`.
2.  Run `openspec archive <change-id>`.

## Directory Structure

```
openspec/
├── product.md              # Product vision & goals
├── structure.md            # Directory map & architecture
├── tech.md                 # Tech stack & conventions
├── specs/                  # Current truth
├── changes/                # Proposals
│   ├── [change-name]/
│   │   ├── proposal.md     # Context, Glossary, Motivation
│   │   ├── design.md       # Technical Spec (Diagrams, SOPs, Properties)
│   │   ├── tasks.md        # Implementation Plan (Tests + Code)
│   │   └── specs/          # Delta changes
│   │       └── [capability]/
│   │           └── spec.md # ADDED/MODIFIED/REMOVED
```

## Detailed File Templates

### 1. `proposal.md`

```markdown
# Change: [Title]

## Summary
[Executive summary]

## Glossary
- **Term**: Definition
- **System**: Definition

## Motivation
[Why is this necessary? Specific user value.]

## Impact
- **Architecture**: [Changes to system structure]
- **DX**: [Changes to developer experience]
```

### 2. `design.md` (The Engineering Spec)

This file must be exhaustive.

```markdown
# Design Document: [Feature Name]

## Overview
[High-level technical approach]

## Architecture
### High-Level Architecture
[Insert ASCII Diagram here - e.g., Docker Compose Mesh, Component Flow]

### API Flow
[Insert ASCII Diagram here - e.g., User -> Traffic Cop -> Service -> DB]

## Components and Interfaces
### [Component/Service Name]
*Define the interface or function signatures.*

// For TypeScript
interface [InterfaceName] {
  // Define exact props/types
}
```

#### SOP Specifications (If AI/LLM involved)

Define the System Operating Procedure for the AI agent.

*   **Model**: [e.g. Claude 3.5 Sonnet]
*   **Context**: [Role definition]
*   **Output Schema**: [JSON structure]
*   **Key Instructions**: [Bulleted list of rules]

#### Data Models

[Schema definitions, Pydantic models, or Database schemas]

#### Correctness Properties

A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.

**Property Reflection**

Review Acceptance Criteria and consolidate redundant logic into single properties.

*   **Property 1: [Name]**
    *   For any [input space], [condition] should always hold.
    *   Validates: Requirement X.Y
*   **Property 2: [Name]**
    *   ...

#### Environment & Deployment

*   **Env Variables**: Define keys (T3 Env or .env) and validation rules.
*   **Docker**: Changes to `docker-compose.yml` or `Dockerfile`.
*   **Scripts**: Definition of setup/deploy scripts.

#### Error Handling

[Specific strategies for failure states, retries, and fallbacks]


### 3. `specs/[capability]/spec.md` (The Deltas)

```markdown
## ADDED Requirements

### Requirement: [Feature Name]
**User Story:** As a [persona], I want [action], so that [value].

#### Acceptance Criteria
1. WHEN [user action or trigger] THEN the System SHALL [expected outcome]
2. WHEN [edge case occurs] THEN the System SHALL [handle error]
3. WHEN [input is provided] THEN the System SHALL [validate/process]
```

### 4. `tasks.md` (Implementation Plan)

Strict Pattern: You must define the Test before the Implementation. Use `[ ]*` for testing tasks.

```markdown
# Implementation Plan

- [ ] 1. Core Infrastructure
  - [ ]* 1.1 Write property tests for Data Model (Property 1) <!-- id: test-model -->
  - [ ] 1.2 Implement Data Model types and storage logic <!-- id: impl-model -->

- [ ] 2. Feature Implementation
  - [ ]* 2.1 Write unit tests for Component X <!-- id: test-comp-x -->
  - [ ] 2.2 Implement Component X <!-- id: impl-comp-x -->

- [ ] 3. Integration
  - [ ]* 3.1 Write E2E test for full workflow <!-- id: test-e2e -->
  - [ ] 3.2 Wire up API endpoints <!-- id: integrate-api -->
```

## Spec Formatting Rules

### Critical: Syntax & Language

*   **Headers**: `#### Acceptance Criteria` is strict.
*   **Criteria Format**: Numbered list. Use Gherkin style (WHEN... THEN...).
*   **Normative Language**: All results MUST use **SHALL** or **MUST** (RFC 2119).
    *   Bad: "Then it displays the error."
    *   Good: "THEN the System SHALL display an error message."
*   **Operations**: `## ADDED Requirements`, `## MODIFIED Requirements`.

### Best Practices

*   **ASCII Art**: Use standard box-drawing characters for diagrams in `design.md`.
*   **PBT**: Default to fast-check (TS) or Hypothesis (Python) for testing properties.
*   **Traceability**: Every Property must explicitly link to a Requirement ID (Validates: ...).
*   **Specifics**: Never be vague. Define file paths, variable names, and exact types.

## CLI Reference

*   `openspec list`
*   `openspec validate [change-id] --strict`
*   `openspec archive [change-id] --yes`

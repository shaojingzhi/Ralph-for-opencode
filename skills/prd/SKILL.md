---
name: prd
description: "Generate a Product Requirements Document (PRD) for a new feature. Use when planning a feature, starting a new project, or when asked to create a PRD. Triggers on: create a prd, write prd for, plan this feature, requirements for, spec out."
user-invocable: true
---

# PRD Generator

Create detailed Product Requirements Documents that are clear, actionable, and suitable for implementation.

---

## The Job

1. Receive a feature description from the user
2. Ask 3-5 essential clarifying questions (with lettered options)
3. Generate a structured PRD based on answers
4. Save to `tasks/prd-[feature-name].md`

Important: Do NOT start implementing. Just create the PRD.

---

## Step 1: Clarifying Questions

Ask only critical questions where the initial prompt is ambiguous. Focus on:

- Problem or goal
- Core functionality
- Scope or boundaries
- Success criteria

### Format Questions Like This

1. What is the primary goal of this feature?
   A. Improve user onboarding experience
   B. Increase user retention
   C. Reduce support burden
   D. Other: please specify

2. Who is the target user?
   A. New users only
   B. Existing users only
   C. All users
   D. Admin users only

3. What is the scope?
   A. Minimal viable version
   B. Full-featured implementation
   C. Just the backend or API
   D. Just the UI

This lets users respond with short option codes for quick iteration.

---

## Step 2: PRD Structure

Generate the PRD with these sections:

### 1. Introduction or Overview
Brief description of the feature and the problem it solves.

### 2. Goals
Specific, measurable objectives.

### 3. User Stories
Each story needs:
- Title
- Description in the form As a user, I want, so that
- Acceptance Criteria as a verifiable checklist

Each story should be small enough to implement in one focused session.

For UI stories always include Verify in browser using available browser tooling in acceptance criteria.

### 4. Functional Requirements
Numbered list of specific functionalities.

### 5. Non-Goals
What this feature will not include.

### 6. Design Considerations
Optional UI, UX, or reuse notes.

### 7. Technical Considerations
Optional constraints, dependencies, or integration points.

### 8. Success Metrics
How success will be measured.

### 9. Open Questions
Remaining areas needing clarification.

---

## Writing for Junior Developers

- Be explicit and unambiguous
- Avoid jargon or explain it
- Provide enough detail to understand purpose and core logic
- Number requirements for easy reference
- Use concrete examples where helpful

---

## Output

- Format: Markdown
- Location: `tasks/`
- Filename: `prd-[feature-name].md`

---

## Checklist

Before saving the PRD:

- Asked clarifying questions with lettered options
- Incorporated the user's answers
- Stories are small and specific
- Functional requirements are numbered and unambiguous
- Non-goals define clear boundaries
- Saved to `tasks/prd-[feature-name].md`

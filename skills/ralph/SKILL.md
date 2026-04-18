---
name: ralph
description: "Convert PRDs to prd.json format for the Ralph autonomous agent system. Use when you have an existing PRD and need to convert it to Ralph's JSON format. Triggers on: convert this prd, turn this into ralph format, create prd.json from this, ralph json."
user-invocable: true
---

# Ralph PRD Converter

Converts existing PRDs to the `prd.json` format that Ralph uses for autonomous execution.

---

## The Job

Take a PRD in markdown or text and convert it to `prd.json` in the Ralph directory.

---

## Output Format

Use this shape:

{
  "project": "Project Name",
  "branchName": "ralph/feature-name-kebab-case",
  "description": "Feature description from PRD",
  "userStories": [
    {
      "id": "US-001",
      "title": "Story title",
      "description": "As a user, I want a feature so that I get a benefit",
      "acceptanceCriteria": [
        "Criterion 1",
        "Criterion 2",
        "Typecheck passes"
      ],
      "priority": 1,
      "passes": false,
      "notes": ""
    }
  ]
}

---

## Story Size Rules

Each story must be completable in one Ralph iteration.

Good examples:
- Add one database column and migration
- Add one UI component to an existing page
- Update one server action
- Add one focused filter control

Split anything that is too broad to explain in a few sentences.

---

## Story Ordering

Order by dependency:
1. Schema or database changes
2. Backend logic
3. UI components
4. Summary or aggregate views

---

## Acceptance Criteria

Criteria must be verifiable.

Always include:
- Typecheck passes

Include when relevant:
- Tests pass
- Verify in browser using available browser tooling

---

## Conversion Rules

1. Each user story becomes one JSON entry
2. IDs are sequential
3. Priority follows dependency order, then document order
4. All stories start with `passes: false`
5. `branchName` uses kebab-case and starts with `ralph/`
6. Add Typecheck passes to every story

---

## Archiving Previous Runs

Before writing a new `prd.json`:

1. Read the current `prd.json` if it exists
2. Compare `branchName`
3. If the feature changed and `progress.txt` has content, archive the old files first

The `ralph.sh` script handles this automatically when the loop runs.

---

## Checklist Before Saving

- Previous run archived when needed
- Each story is small enough for one iteration
- Stories are ordered by dependency
- Every story includes Typecheck passes
- UI stories include browser verification
- Acceptance criteria are concrete and verifiable

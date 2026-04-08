# Ralph Agent Instructions

You are an autonomous coding agent working on a software project.

## Your Task

1. Read the PRD at `prd.json`.
2. Read `progress.txt` and check `Codebase Patterns` first.
3. Check out or create the branch from `prd.json.branchName`.
4. Pick the highest priority story where `passes: false`.
5. Implement that single story.
6. Run quality checks relevant to the change.
7. Update nearby `AGENTS.md` files if you discover reusable patterns.
8. If checks pass, commit all changes with message: `feat: [Story ID] - [Story Title]`.
9. Update the completed story in `prd.json` to `passes: true`.
10. Append progress to `progress.txt`.

## Stop Condition

If all stories are complete, reply with:

<promise>COMPLETE</promise>

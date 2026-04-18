# Demo Workflow

This repository includes a minimal runnable example at `examples/minimal/prd.json`.

The example asks Ralph to do one safe task:

- create `CHANGELOG.md`
- add a `# Changelog` title
- add a `## Unreleased` section

## Run the demo in this repository

1. Start from a clean working tree.

2. Copy the minimal PRD into place:

   ```bash
   cp examples/minimal/prd.json ./prd.json
   ```

3. Run one short Ralph loop with Codex:

   ```bash
   ./ralph.sh --tool codex 3
   ```

4. Inspect the result:

   ```bash
   git status
   git log --oneline --decorate -3
   cat CHANGELOG.md
   cat progress.txt
   ```

5. If the run succeeds, you should see:

- a branch named `ralph/demo-add-changelog`
- a new `CHANGELOG.md`
- an updated `progress.txt`
- `prd.json` marked with `"passes": true`
- a commit created by Ralph

## Run the demo in another project

1. Install Ralph into your target project:

   ```bash
   ./install.sh --tool codex --project /path/to/your-project
   ```

2. Copy the example PRD:

   ```bash
   cp examples/minimal/prd.json /path/to/your-project/scripts/ralph/prd.json
   ```

3. Run Ralph from the installed directory:

   ```bash
   cd /path/to/your-project/scripts/ralph
   ./ralph.sh --tool codex 3
   ```

## Notes

- The Codex loop uses `workspace-write` sandbox by default.
- The Codex loop uses `never` approval mode by default.
- Override the model with `--model` or `CODEX_MODEL`.
- Override sandbox or approval with `--codex-sandbox` and `--codex-approval`.

## Reset after the demo

If you want to remove the demo artifacts after testing:

```bash
git switch main
git branch -D ralph/demo-add-changelog
rm -f CHANGELOG.md prd.json progress.txt .last-branch
rm -rf archive
```

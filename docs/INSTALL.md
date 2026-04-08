# Installation

This fork supports OpenCode, Amp, and Claude Code through a unified installer.

## Unified installer

```bash
./install.sh --tool opencode
./install.sh --tool amp
./install.sh --tool claude
```

The installer copies these skills into the selected tool's skill directory:

- `prd`
- `ralph`

## Install into a project

To also copy the Ralph runner files into a project:

```bash
./install.sh --tool opencode --project /path/to/your-project
```

This creates:

```text
/path/to/your-project/scripts/ralph/
  ralph.sh
  OPENCODE.md
  prompt.md
  CLAUDE.md
  prd.json.example
```

It also appends this ignore rule to the project `.gitignore`:

```text
scripts/ralph/.last-branch
```

## Tool-specific skill locations

The installer uses these destinations:

- OpenCode: `~/.config/opencode/skills/`
- Amp: `~/.config/amp/skills/`
- Claude Code: `~/.claude/skills/`

## OpenCode compatibility wrapper

This fork also keeps a compatibility command for OpenCode:

```bash
./install-opencode.sh --project /path/to/your-project
```

Internally it forwards to:

```bash
./install.sh --tool opencode ...
```

## After installation

### 1. Create a PRD

In OpenCode, Amp, or Claude Code, invoke the `prd` skill.

Example:

```text
Use the prd skill to create a PRD for adding task priorities
```

### 2. Convert the PRD to `prd.json`

Invoke the `ralph` skill.

Example:

```text
Use the ralph skill to convert tasks/prd-task-priorities.md to scripts/ralph/prd.json
```

### 3. Run the loop

```bash
cd /path/to/your-project/scripts/ralph
./ralph.sh --tool opencode 10
```

Swap `opencode` for `amp` or `claude` if needed.

## OpenCode-specific notes

- OpenCode runs are isolated from nested session environment variables before `opencode run`
- The default OpenCode model is `codexzh/gpt-5.4`
- The default OpenCode agent is `build`
- You can override the model with `OPENCODE_MODEL`

Example:

```bash
OPENCODE_MODEL=codexzh/gpt-5.4 ./ralph.sh --tool opencode 10
```

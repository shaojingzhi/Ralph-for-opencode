# Installation

This fork supports Codex CLI, OpenCode, Amp, and Claude Code through a unified installer.

## Unified installer

```bash
./install.sh --tool codex
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
./install.sh --tool codex --project /path/to/your-project
```

This creates:

```text
/path/to/your-project/scripts/ralph/
  ralph.sh
  CODEX.md
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

- Codex CLI: `${CODEX_HOME:-~/.codex}/skills/`
- OpenCode: `~/.config/opencode/skills/`
- Amp: `~/.config/amp/skills/`
- Claude Code: `~/.claude/skills/`

## Compatibility wrappers

This fork includes compatibility commands for Codex and OpenCode:

```bash
./install-codex.sh --project /path/to/your-project
./install-opencode.sh --project /path/to/your-project
```

Internally they forward to:

```bash
./install.sh --tool codex ...
./install.sh --tool opencode ...
```

## After installation

### 1. Create a PRD

In Codex, OpenCode, Amp, or Claude Code, invoke the `prd` skill.

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
./ralph.sh --tool codex 10
```

Swap `codex` for `opencode`, `amp`, or `claude` if needed.

## Codex-specific notes

- Ralph runs Codex through `codex exec`.
- The default sandbox is `workspace-write`.
- The default approval policy is `never`.
- Codex uses your configured default model unless you set `CODEX_MODEL` or pass `--model`.
- You can override the sandbox with `RALPH_CODEX_SANDBOX` or `--codex-sandbox`.
- You can override approval with `RALPH_CODEX_APPROVAL` or `--codex-approval`.

Examples:

```bash
./ralph.sh --tool codex --model gpt-5.1-codex 10
RALPH_CODEX_SANDBOX=danger-full-access ./ralph.sh --tool codex 10
RALPH_CODEX_APPROVAL=on-request ./ralph.sh --tool codex 10
```

## OpenCode-specific notes

- OpenCode runs are isolated from nested session environment variables before `opencode run`
- The default OpenCode model is `codexzh/gpt-5.4`
- The default OpenCode agent is `build`
- You can override the model with `OPENCODE_MODEL`

Example:

```bash
OPENCODE_MODEL=codexzh/gpt-5.4 ./ralph.sh --tool opencode 10
```

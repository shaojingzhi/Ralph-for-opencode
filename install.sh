#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOL="opencode"
TARGET_PROJECT=""

usage() {
  cat <<EOF
Usage: ./install.sh [--tool opencode|amp|claude] [--project /path/to/project]

Installs Ralph skills for the selected tool.
Optionally installs Ralph runner files into a target project under scripts/ralph/.

Examples:
  ./install.sh --tool opencode
  ./install.sh --tool opencode --project /path/to/my-app
  ./install.sh --tool amp
  ./install.sh --tool claude
EOF
}

copy_dir() {
  local src="$1"
  local dest="$2"
  rm -rf "$dest"
  mkdir -p "$(dirname "$dest")"
  cp -R "$src" "$dest"
}

skill_install_dir() {
  case "$TOOL" in
    opencode) printf '%s' "$HOME/.config/opencode/skills" ;;
    amp) printf '%s' "$HOME/.config/amp/skills" ;;
    claude) printf '%s' "$HOME/.claude/skills" ;;
    *)
      echo "Error: Unsupported tool '$TOOL'"
      exit 1
      ;;
  esac
}

install_skills() {
  local dest_root
  dest_root="$(skill_install_dir)"

  mkdir -p "$dest_root"
  copy_dir "$SCRIPT_DIR/skills/prd" "$dest_root/prd"
  copy_dir "$SCRIPT_DIR/skills/ralph" "$dest_root/ralph"

  echo "Installed skills for $TOOL to: $dest_root"
  echo "  - prd"
  echo "  - ralph"
}

install_project_files() {
  local project_dir="$1"
  local ralph_dir="$project_dir/scripts/ralph"

  if [ ! -d "$project_dir" ]; then
    echo "Error: Project directory does not exist: $project_dir"
    exit 1
  fi

  mkdir -p "$ralph_dir"
  cp "$SCRIPT_DIR/ralph.sh" "$ralph_dir/ralph.sh"
  cp "$SCRIPT_DIR/OPENCODE.md" "$ralph_dir/OPENCODE.md"
  cp "$SCRIPT_DIR/prompt.md" "$ralph_dir/prompt.md"
  cp "$SCRIPT_DIR/CLAUDE.md" "$ralph_dir/CLAUDE.md"
  cp "$SCRIPT_DIR/prd.json.example" "$ralph_dir/prd.json.example"
  chmod +x "$ralph_dir/ralph.sh"

  if [ ! -f "$project_dir/.gitignore" ] || ! grep -q '^scripts/ralph/.last-branch$' "$project_dir/.gitignore"; then
    printf '\nscripts/ralph/.last-branch\n' >> "$project_dir/.gitignore"
  fi

  echo "Installed Ralph runner files to: $ralph_dir"
  echo "Next: copy prd.json.example to prd.json and customize it."
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tool)
      TOOL="$2"
      shift 2
      ;;
    --tool=*)
      TOOL="${1#*=}"
      shift
      ;;
    --project)
      TARGET_PROJECT="$2"
      shift 2
      ;;
    --project=*)
      TARGET_PROJECT="${1#*=}"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

if [[ "$TOOL" != "opencode" && "$TOOL" != "amp" && "$TOOL" != "claude" ]]; then
  echo "Error: Invalid tool '$TOOL'. Must be 'opencode', 'amp', or 'claude'."
  exit 1
fi

install_skills

if [ -n "$TARGET_PROJECT" ]; then
  install_project_files "$TARGET_PROJECT"
fi

cat <<EOF

Install complete.

You can now use these skills with $TOOL:
  - "Use the prd skill to create a PRD for ..."
  - "Use the ralph skill to convert tasks/prd-*.md to prd.json"

To run the loop in a project:
  cd /path/to/project/scripts/ralph
  ./ralph.sh --tool $TOOL 10
EOF

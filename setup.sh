#!/usr/bin/env bash
# Set up one project (or all) with uv: .venv + editable install + pytest.
# Usage: ./setup.sh <project>|all
set -euo pipefail

PROJECTS=(tomli markdown-it-py click mako jinja werkzeug marshmallow itsdangerous rich pygments)

setup_one() {
  local proj="$1" spec="."
  case "$proj" in
    markdown-it-py) spec=".[testing]" ;;
    marshmallow)    spec=".[tests]" ;;
  esac
  echo "== $proj"
  (cd "$proj" && uv venv --python 3.12 && uv pip install -e "$spec" pytest)
  echo "== $proj ready. Run tests with: cd $proj && uv run pytest"
}

case "${1:-}" in
  all) for p in "${PROJECTS[@]}"; do setup_one "$p"; done ;;
  "")  echo "Usage: ./setup.sh <project>|all"; printf 'Projects: %s\n' "${PROJECTS[*]}"; exit 1 ;;
  *)
    if [ -d "${1}" ]; then setup_one "$1"; else
      echo "No project folder named '$1'."; printf 'Projects: %s\n' "${PROJECTS[*]}"; exit 1
    fi ;;
esac

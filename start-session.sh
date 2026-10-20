#!/usr/bin/env bash
# Sets up a tutor session.
#   reference/ = current working tree (the AI-built version)
#   The user rebuilds by hand in the project root, which starts at the base commit.
# Usage: ./start-session.sh [base-ref]
set -euo pipefail

BASE="${1:-HEAD}"

git rev-parse --git-dir >/dev/null 2>&1 || { echo "Not a git repo."; exit 1; }
cd "$(git rev-parse --show-toplevel)"

if [ -e reference ]; then
  echo "reference/ already exists. Move or delete it first."
  exit 1
fi

# keep the session folder out of git status
grep -qxF "reference/" .git/info/exclude 2>/dev/null || echo "reference/" >> .git/info/exclude

SKIP=(':!reference' ':!.opencode' ':!PROGRESS.md' ':!FEATURES.md' ':!start-session.sh')

# reference/ <- working tree (tracked + untracked, respecting .gitignore)
LIST="$(mktemp)"
git ls-files -z --cached --others --exclude-standard -- . "${SKIP[@]}" > "$LIST"
mkdir reference
while IFS= read -r -d '' f; do
  [ -f "$f" ] || continue
  mkdir -p "reference/$(dirname "$f")"
  cp -p "$f" "reference/$f"
done < "$LIST"

echo "Base:      $(git rev-parse --short "$BASE")"
echo "reference/ $(find reference -type f | wc -l) files"

# Reset the project root to the base commit, so the user rebuilds against a clean
# starting point. reference/ holds the AI-built version of every file.
git checkout "$BASE" -- .
git clean -fd -e reference -e .opencode

# tidy leftover caches and empty dirs outside reference/
find . -type d -name __pycache__ -not -path './.git/*' -not -path './reference/*' -prune -exec rm -rf {} +
find . -mindepth 1 -type d -empty -not -path './.git/*' -not -path './reference/*' -not -path './.opencode/*' -delete

rm -f "$LIST"

echo "Project root reset to $(git rev-parse --short "$BASE"). The AI-built version is in reference/."

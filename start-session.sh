#!/usr/bin/env bash
# Sets up a tutor session.
#   reference/ = current working tree (the AI-built version)
#   original/  = the base commit (default HEAD) = your starting point
# Usage: ./start-session.sh [base-ref]
set -euo pipefail

BASE="${1:-HEAD}"

git rev-parse --git-dir >/dev/null 2>&1 || { echo "Not a git repo."; exit 1; }
cd "$(git rev-parse --show-toplevel)"

if [ -e original ] || [ -e reference ]; then
  echo "original/ or reference/ already exists. Move or delete them first."
  exit 1
fi

# keep the session folders out of git status
for p in original/ reference/; do
  grep -qxF "$p" .git/info/exclude 2>/dev/null || echo "$p" >> .git/info/exclude
done

SKIP=(':!original' ':!reference' ':!.opencode' ':!PROGRESS.md' ':!FEATURES.md' ':!start-session.sh')

# reference/ <- working tree (tracked + untracked, respecting .gitignore)
LIST="$(mktemp)"
git ls-files -z --cached --others --exclude-standard -- . "${SKIP[@]}" > "$LIST"
mkdir reference
while IFS= read -r -d '' f; do
  [ -f "$f" ] || continue
  mkdir -p "reference/$(dirname "$f")"
  cp -p "$f" "reference/$f"
done < "$LIST"

# original/ <- base commit
mkdir original
git archive "$BASE" | tar -x -C original
rm -rf original/.opencode original/PROGRESS.md original/FEATURES.md original/start-session.sh

echo "Base:      $(git rev-parse --short "$BASE")"
echo "original/  $(find original -type f | wc -l) files"
echo "reference/ $(find reference -type f | wc -l) files"

# Remove the now-duplicated addon files from the root (only if the copy is identical).
# Files that stay at the root: git/config dotfiles and agent instructions.
KEEP=(.gitignore agents.md AGENTS.md)
removed=0
while IFS= read -r -d '' f; do
  [ -f "$f" ] || continue
  case " ${KEEP[*]} " in *" $f "*) continue ;; esac
  if cmp -s "$f" "reference/$f"; then
    rm "$f"; removed=$((removed+1))
  fi
done < "$LIST"
rm -f "$LIST"

# tidy leftover caches and empty dirs outside the session folders
find . -type d -name __pycache__ -not -path './.git/*' -not -path './original/*' -not -path './reference/*' -prune -exec rm -rf {} +
find . -mindepth 1 -type d -empty -not -path './.git/*' -not -path './original/*' -not -path './reference/*' -not -path './.opencode/*' -delete

echo "Removed $removed duplicated files from root (copies live in reference/)."
echo "Reminder: point your dev environment / symlink at original/, not the repo root."

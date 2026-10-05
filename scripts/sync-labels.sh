#!/usr/bin/env bash
# Create or update the repo's labels. Requires the GitHub CLI (gh) and write access.
# Usage: scripts/sync-labels.sh [owner/repo]
set -euo pipefail
REPO="${1:-$(gh repo view --json nameWithOwner -q .nameWithOwner)}"

labels=(
  "area:contracts|1F7058|Soroban smart contracts"
  "area:web|2F5DB8|Frontend"
  "area:indexer|6B7868|Indexer and API"
  "area:sdk|8F5F08|TypeScript SDK"
  "area:schemas|8F5F08|JSON Schemas"
  "area:tokens|5FCBA4|Design tokens"
  "area:docs|B9C2AE|Documentation"
  "area:research|7057FF|Protocol design and research"
  "type:bug|B83232|Something is broken"
  "type:feature|1F7058|New feature or improvement"
  "good first issue|7057FF|Good for newcomers"
  "help wanted|008672|Maintainers would like help"
  "needs-adr|FBCA04|Needs an architecture decision record"
  "blocked|B83232|Blocked by another issue or decision"
)

for entry in "${labels[@]}"; do
  IFS='|' read -r name color desc <<<"$entry"
  gh label create "$name" --color "$color" --description "$desc" --repo "$REPO" --force
done
echo "Labels synced for $REPO"

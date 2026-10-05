#!/usr/bin/env bash
# Create the starter issue set. Run scripts/sync-labels.sh first. Requires gh.
# Usage: scripts/create-starter-issues.sh [owner/repo]
set -euo pipefail
REPO="${1:-$(gh repo view --json nameWithOwner -q .nameWithOwner)}"

issue() { gh issue create --repo "$REPO" --title "$1" --label "$2" --body "$3"; }

issue "contracts(claim-registry): emit claim_registered event and extend TTL" \
  "area:contracts,good first issue" \
"The registry stores claims but emits no event and never extends storage TTL.

**Where to look:** \`contracts/claim-registry/src/lib.rs\`

**Done when**
- [ ] \`register_claim\` emits an event with claim hash and author
- [ ] Persistent entry TTL is extended on write and documented
- [ ] Tests assert the event and TTL behavior"

issue "contracts(inquiry-escrow): deposit a USDC bounty and release to one examiner" \
  "area:contracts,help wanted" \
"Implement the first slice of escrow: deposit, release, and refund for a single claim.

**Where to look:** \`docs/protocol-spec.md\` (draft interfaces), \`contracts/inquiry-escrow/\`

**Done when**
- [ ] \`deposit\`, \`release\` (restricted), \`refund_remaining\`
- [ ] Token transfers use the Stellar Asset Contract interface
- [ ] Tests cover over-release, double refund, and unauthorized release
- [ ] ADR if the authorization model for \`release\` needs a decision"

issue "contracts(staking): stake, lock, unlock, and slash" \
  "area:contracts,help wanted" \
"Implement examiner staking per the draft interface in \`docs/protocol-spec.md\`.

**Done when**
- [ ] \`stake\`, \`unlock\`, \`slash\` with tests
- [ ] Slashing is restricted and capped in basis points
- [ ] Open question about who may call \`slash\` is recorded in an ADR"

issue "contracts(reputation): field-scoped non-transferable score" \
  "area:contracts" \
"Store a score per (examiner, field). It must not be transferable.

**Done when**
- [ ] \`score\` and restricted \`record_outcome\`
- [ ] No transfer path exists, with a test proving it
- [ ] Open question about field definitions summarized in the PR"

issue "indexer: ingest claim-registry events from Soroban RPC into SQLite" \
  "area:indexer,good first issue" \
"The indexer currently serves an in-memory empty list.

**Where to look:** \`apps/indexer/src/index.ts\`

**Done when**
- [ ] Poll Soroban RPC \`getEvents\` from the last processed ledger
- [ ] Persist claims and the cursor in SQLite
- [ ] \`GET /claims\` returns persisted claims
- [ ] Documented how to rebuild from scratch"

issue "web: connect a Stellar wallet (Freighter)" \
  "area:web,good first issue" \
"Add wallet connect and display the connected address.

**Done when**
- [ ] Connect and disconnect
- [ ] Network mismatch is shown clearly
- [ ] Uses design tokens, with visible keyboard focus"

issue "web: base components (Button, StatusChip, Card, Input)" \
  "area:web,good first issue" \
"Extract the styles in \`apps/web/src/app.css\` into small reusable components using semantic tokens only.

**Done when**
- [ ] Components exist with hover, focus-visible, disabled states
- [ ] No raw palette values used
- [ ] StatusChip never relies on color alone"

issue "web: claim submission form with SHA-256 hashing and IPFS upload" \
  "area:web" \
"Let an author pick a file, hash it in the browser, upload to IPFS, fill metadata, and validate against \`packages/schemas/claim.schema.json\`.

**Done when**
- [ ] Hash computed client-side with Web Crypto
- [ ] Metadata validated before submission
- [ ] Errors say what is wrong and how to fix it"

issue "schemas: add validation tests with Ajv" \
  "area:schemas,good first issue" \
"Add a test suite that validates example claims and reviews against the schemas and rejects invalid ones.

**Done when**
- [ ] At least 3 valid and 5 invalid examples per schema
- [ ] Runs in CI via \`pnpm test\`"

issue "sdk: generate TypeScript bindings for claim-registry" \
  "area:sdk" \
"Follow \`packages/sdk/README.md\` to generate bindings from the built WASM and expose a typed client from \`createClient\`.

**Done when**
- [ ] Generated bindings committed
- [ ] \`createClient\` exposes \`registerClaim\` and \`getClaim\`
- [ ] README documents regeneration"

issue "research: extend the threat model with concrete attack scenarios" \
  "area:research,good first issue" \
"Pick two rows in \`docs/threat-model.md\` and write a concrete attack scenario, expected cost to the attacker, and a recommended mitigation.

**Done when**
- [ ] Two scenarios written up with numbers or clear assumptions
- [ ] Mitigations mapped to contract changes where relevant"

issue "docs: worked example reviews (one strong, one weak)" \
  "area:docs,good first issue" \
"Using a public preprint, write one strong and one weak example review following \`docs/review-rubric.md\`, validated against \`review.schema.json\`.

**Done when**
- [ ] Both reviews under \`docs/examples/\`
- [ ] Short note explains what makes each strong or weak"

echo "Starter issues created in $REPO"

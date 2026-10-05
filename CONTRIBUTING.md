# Contributing to Elenchus Protocol

Thanks for helping. This guide is short on purpose.

## Ways to contribute

| Area | Label | Good for |
|---|---|---|
| Smart contracts (Rust/Soroban) | `area:contracts` | Escrow, staking, reputation, voting logic |
| Frontend | `area:web` | Wallet connection, submission and review UI |
| Indexer / backend | `area:indexer` | Event ingestion, API, reviewer matching |
| SDK & schemas | `area:sdk`, `area:schemas` | Bindings, validation, types |
| Docs & research | `area:docs`, `area:research` | Threat model, rubric, governance, protocol design |

Research and documentation contributions are as valuable as code. The hardest problems here (review quality, collusion resistance) are design problems.

## Getting set up

```bash
git clone https://github.com/<org>/elenchus-protocol.git
cd elenchus-protocol
pnpm install
pnpm --filter @elenchus-protocol/tokens build
```

Contracts additionally need Rust and the Stellar CLI. See [`contracts/README.md`](contracts/README.md).

## Workflow

1. **Find or open an issue.** Comment to claim it so work is not duplicated. For anything larger than a small fix, agree on the approach in the issue before writing code.
2. **Fork and branch** from `main`: `feat/escrow-release`, `fix/indexer-pagination`, `docs/threat-model`.
3. **Keep PRs focused.** One concern per PR. Include tests for contract and logic changes.
4. **Use [Conventional Commits](https://www.conventionalcommits.org/):** `feat(escrow): release bounty to accepted examiner`.
5. **Open a PR** using the template. CI must pass.
6. A maintainer reviews. Expect questions, not just approvals. Reviewing is the point of this project.

## Standards

- **Contracts:** `cargo fmt`, `cargo clippy -D warnings`, tests for every public function, `require_auth()` on every state-changing call that acts on behalf of an address.
- **TypeScript:** strict mode, `pnpm typecheck` clean.
- **UI:** use semantic design tokens (`--elx-color-*`), never raw palette values. Never convey status by color alone. See [`packages/tokens/README.md`](packages/tokens/README.md).
- **Schemas and protocol changes:** record the decision in `docs/adr/` (copy an existing ADR).
- **No secrets** in commits. `.env` is ignored. Use `.env.example`.

## Decisions and design discussions

Protocol-level questions (reputation scoring, anonymity, bounty funding) are decided in GitHub Discussions first, then recorded as an ADR. See [`docs/governance.md`](docs/governance.md).

## Reporting security issues

Do **not** open a public issue. See [`SECURITY.md`](SECURITY.md).

## Code of conduct

Participation is governed by [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md).

## What and why

<!-- What does this change, and why? Link the issue: Closes #123 -->

## Area

- [ ] contracts
- [ ] web
- [ ] indexer
- [ ] sdk / schemas
- [ ] tokens
- [ ] docs / research

## Checklist

- [ ] Tests added or updated (required for contract and logic changes)
- [ ] `cargo fmt`, `cargo clippy`, `cargo test` pass (contracts)
- [ ] `pnpm build` and `pnpm typecheck` pass (JS)
- [ ] Public contract interface changed? I bumped `version()` and updated `packages/sdk`
- [ ] Protocol-level decision? I added or updated an ADR in `docs/adr/`
- [ ] UI changes use semantic tokens and do not rely on color alone for meaning
- [ ] No secrets or keys committed

## Notes for reviewers

<!-- Trade-offs, open questions, how to test -->

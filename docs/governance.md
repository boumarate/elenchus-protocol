# Governance (draft)

## Roles

- **Contributors** anyone who opens issues, PRs, or discussions.
- **Maintainers** review and merge, triage issues, and run releases.
- **Protocol parameter owners** hold authority over on-chain parameters (stake sizes, slashing rates). Initially the maintainers via a multisig. The long-term plan is an open question.

## How decisions are made

1. **Discuss** in GitHub Discussions (category: *Design*).
2. **Propose** with an ADR pull request in `docs/adr/`.
3. **Decide** by maintainer consensus after a minimum 7-day comment window for protocol changes.
4. **Record** the outcome in the ADR (`Accepted`, `Rejected`, `Superseded`).

Small fixes and docs changes do not need an ADR.

## Changing on-chain parameters

During testnet, maintainers may change parameters freely and must announce changes in the changelog. Before any mainnet deployment, a documented process (multisig threshold, time delay, public notice) must be accepted as an ADR.

## Conflicts of interest

Maintainers disclose conflicts and recuse from decisions about their own submissions or employers.

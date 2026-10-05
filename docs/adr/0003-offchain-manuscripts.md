# ADR 0003: Manuscripts live off-chain, anchored by hash

- Status: Accepted
- Date: 2026-10-04

## Context

Manuscripts and datasets are large. Storing them on-chain is impractical, and some authors need access control.

## Decision

Store manuscripts on IPFS. Anchor the SHA-256 hash (the claim id) and CID on-chain in `claim-registry`. Metadata is validated against `packages/schemas/claim.schema.json`.

## Consequences

- Anyone can verify a manuscript matches its on-chain anchor.
- Availability depends on pinning. Docs must guide authors on pinning.
- Private or embargoed manuscripts are out of scope for v0.

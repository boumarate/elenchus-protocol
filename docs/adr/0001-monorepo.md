# ADR 0001: Use a monorepo

- Status: Accepted
- Date: 2026-10-04

## Context

Contracts, SDK, indexer, and web app change together. Contributors need one place to find issues, run CI, and understand the whole system. The project has few maintainers.

## Decision

Use one repository with pnpm workspaces for JavaScript and a Cargo workspace for contracts.

## Consequences

- A contract interface change and its client updates land in one PR.
- One CI pipeline with path filters keeps runs fast.
- Packages can be split into their own repos later (for example, an audited, frozen `contracts` repo).

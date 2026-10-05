# ADR 0002: Design tokens as a first-class package

- Status: Accepted
- Date: 2026-10-04

## Context

The UI needs a consistent, accessible visual language that contributors can extend without design review for every change.

## Decision

Maintain design tokens in `packages/tokens` using the W3C Design Tokens format. Components consume semantic tokens only. The build validates theme parity and checks contrast.

The base color `#070906` was sampled from bio.xyz's `theme-color`. All other values are original. Bio's logos and wordmarks are not used.

## Consequences

- Dark and light themes stay in sync, enforced by the build.
- Tokens can be consumed by CSS, TypeScript, and Tailwind.
- Replacing the visual identity means editing JSON, not components.

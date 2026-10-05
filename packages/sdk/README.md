# @elenchus-protocol/sdk

TypeScript client for the Elenchus contracts. Status: **skeleton**. It exports shared types and a client factory; generated contract bindings come next.

## Generating bindings

```bash
cd contracts && stellar contract build
stellar contract bindings typescript \
  --wasm target/wasm32v1-none/release/claim_registry.wasm \
  --output-dir ../packages/sdk/src/generated/claim-registry
```

Commit generated output so contributors do not need the Stellar CLI just to work on the frontend.

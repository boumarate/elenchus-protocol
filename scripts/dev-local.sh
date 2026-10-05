#!/usr/bin/env bash
# Start a local Stellar network (needs Docker) and show how to deploy.
set -euo pipefail

command -v docker >/dev/null || { echo "Docker is required for a local network."; exit 1; }
command -v stellar >/dev/null || { echo "Install the Stellar CLI first: https://developers.stellar.org/docs/tools/cli/install-cli"; exit 1; }

stellar container start local || true
stellar network add local \
  --rpc-url http://localhost:8000/soroban/rpc \
  --network-passphrase "Standalone Network ; February 2017" 2>/dev/null || true
stellar keys generate dev --network local --fund 2>/dev/null || true

cat <<MSG

Local network is up. Build and deploy claim-registry:

  cd contracts && stellar contract build
  stellar contract deploy \\
    --wasm target/wasm32v1-none/release/claim_registry.wasm \\
    --source dev --network local

MSG

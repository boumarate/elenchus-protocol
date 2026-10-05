/**
 * Elenchus SDK entry point.
 *
 * Contract bindings are generated from the compiled WASM, not hand-written:
 *   stellar contract bindings typescript --wasm <path> --output-dir packages/sdk/src/generated/<name>
 * See packages/sdk/README.md. Until the contracts stabilise this file only
 * exports shared types so the web app and indexer can compile against them.
 */

export type ClaimStatus = 'pending' | 'examining' | 'corroborated' | 'contested' | 'refuted';

export interface Claim {
  /** Hex SHA-256 of the manuscript. This is the on-chain claim id. */
  id: string;
  author: string;
  cid: string;
  registeredAt: number;
  status: ClaimStatus;
}

export interface ClientConfig {
  rpcUrl: string;
  networkPassphrase: string;
  contractIds: {
    claimRegistry?: string;
    inquiryEscrow?: string;
    staking?: string;
    reputation?: string;
    crossExam?: string;
  };
}

export const TESTNET: Pick<ClientConfig, 'rpcUrl' | 'networkPassphrase'> = {
  rpcUrl: 'https://soroban-testnet.stellar.org',
  networkPassphrase: 'Test SDF Network ; September 2015',
};

export function createClient(config: ClientConfig) {
  // TODO(good-first-issue): wrap generated bindings once claim-registry is deployed to testnet.
  return { config };
}

#![no_std]
//! Shared types for Elenchus contracts.

use soroban_sdk::contracttype;

/// Lifecycle of a claim. Mirrors `ClaimStatus` in `packages/sdk`.
#[contracttype]
#[derive(Clone, Copy, Debug, Eq, PartialEq)]
pub enum ClaimStatus {
    Pending,
    Examining,
    Corroborated,
    Contested,
    Refuted,
}

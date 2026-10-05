#![no_std]
//! Staking: examiners lock stake to claim an assignment. Stake is slashed for no-shows, plagiarism, or reviews the community rejects.
//!
//! STATUS: stub. See docs/protocol-spec.md and the matching GitHub issue before implementing.

use soroban_sdk::{contract, contractimpl, Env};

#[contract]
pub struct Staking;

#[contractimpl]
impl Staking {
    /// Interface version. Bump when the public ABI changes.
    pub fn version(_env: Env) -> u32 {
        0
    }
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn reports_version() {
        let env = Env::default();
        let id = env.register(Staking, ());
        let client = StakingClient::new(&env, &id);
        assert_eq!(client.version(), 0);
    }
}

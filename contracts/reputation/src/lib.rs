#![no_std]
//! Reputation: non-transferable, field-scoped examiner score (the Elenchus score).
//!
//! STATUS: stub. See docs/protocol-spec.md and the matching GitHub issue before implementing.

use soroban_sdk::{contract, contractimpl, Env};

#[contract]
pub struct Reputation;

#[contractimpl]
impl Reputation {
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
        let id = env.register(Reputation, ());
        let client = ReputationClient::new(&env, &id);
        assert_eq!(client.version(), 0);
    }
}

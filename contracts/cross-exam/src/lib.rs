#![no_std]
//! Cross-examination: reputation-weighted voting on review quality.
//!
//! STATUS: stub. See docs/protocol-spec.md and the matching GitHub issue before implementing.

use soroban_sdk::{contract, contractimpl, Env};

#[contract]
pub struct CrossExam;

#[contractimpl]
impl CrossExam {
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
        let id = env.register(CrossExam, ());
        let client = CrossExamClient::new(&env, &id);
        assert_eq!(client.version(), 0);
    }
}

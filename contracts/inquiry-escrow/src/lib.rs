#![no_std]
//! Inquiry escrow: holds the review bounty (USDC) and releases it to examiners whose reviews are accepted. Refunds the remainder when milestones fail.
//!
//! STATUS: stub. See docs/protocol-spec.md and the matching GitHub issue before implementing.

use soroban_sdk::{contract, contractimpl, Env};

#[contract]
pub struct InquiryEscrow;

#[contractimpl]
impl InquiryEscrow {
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
        let id = env.register(InquiryEscrow, ());
        let client = InquiryEscrowClient::new(&env, &id);
        assert_eq!(client.version(), 0);
    }
}

# Protocol specification (draft)

Status: **draft**. Sections marked *Open* are decided in GitHub Discussions, then recorded as ADRs.

## Actors

- **Author** registers a claim and funds its inquiry bounty.
- **Examiner** stakes to review a claim and is paid for accepted reviews.
- **Reader** reads claims, reviews, and verdicts. No account needed.
- **Maintainers/Governance** set protocol parameters (see `governance.md`).

## Claim lifecycle

```
pending ──► examining ──► corroborated
                     ├──► contested
                     └──► refuted
```

| State | Meaning |
|---|---|
| `pending` | Registered, bounty funded, not enough examiners yet |
| `examining` | Required number of examiners have staked |
| `corroborated` | Reviews accepted, majority recommend corroboration |
| `contested` | Reviews disagree materially |
| `refuted` | Reviews accepted, majority recommend refutation |

A verdict says what examiners concluded. It is not a statement of truth.

## Flow

1. **Register.** `claim-registry.register_claim(author, content_hash, cid)`.
2. **Fund.** Author deposits USDC into `inquiry-escrow` for the claim.
3. **Stake.** Examiners lock stake in `staking` to claim an assignment.
4. **Review.** Examiner submits a review (JSON validating against `review.schema.json`) to IPFS and records its hash.
5. **Cross-examine.** Authors, other examiners, and editors vote on review quality in `cross-exam`, weighted by reputation.
6. **Settle.** Accepted reviews are paid from escrow and stake returned. Rejected reviews forfeit part of stake. Reputation updates.

## Draft interfaces

Not final. Open an issue before implementing.

```rust
// inquiry-escrow
fn deposit(env, claim_id: BytesN<32>, funder: Address, token: Address, amount: i128);
fn release(env, claim_id: BytesN<32>, examiner: Address, amount: i128); // restricted
fn refund_remaining(env, claim_id: BytesN<32>);

// staking
fn stake(env, examiner: Address, claim_id: BytesN<32>, amount: i128);
fn unlock(env, examiner: Address, claim_id: BytesN<32>);
fn slash(env, examiner: Address, claim_id: BytesN<32>, bps: u32); // restricted

// reputation
fn score(env, examiner: Address, field: Symbol) -> i128;
fn record_outcome(env, examiner: Address, field: Symbol, delta: i128); // restricted

// cross-exam
fn vote(env, voter: Address, review_id: BytesN<32>, quality: u32);
fn tally(env, review_id: BytesN<32>) -> Tally;
```

## Open questions

1. **Who decides review quality?** Authors are conflicted. Pure community voting can be gamed. Candidate: reputation-weighted votes from authors, peer examiners, and editors, with caps on any one group.
2. **Reputation scope.** Field-scoped scores are more meaningful but fragment the system. How are fields defined?
3. **Anonymity.** Blind, open, or examiner's choice? Open identity builds trust. Anonymity protects junior reviewers.
4. **Bounty funding.** Author-paid, funder-paid, institution-paid, or a community pool?
5. **Slashing parameters.** Percentages, appeal process, and time limits.
6. **Identity and Sybil resistance.** ORCID links? Stake size? Both?
7. **Cross-contract authority.** Which contract may call restricted functions in which? Governance or a router contract?

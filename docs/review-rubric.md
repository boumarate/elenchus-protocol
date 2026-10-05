# Review rubric (draft)

Reviews are scored on four criteria, 1 to 5, and must justify each score with evidence. Schema: `packages/schemas/review.schema.json`.

| Score | Meaning |
|---|---|
| 1 | Serious problems that undermine the work |
| 2 | Significant weaknesses |
| 3 | Acceptable, with notable gaps |
| 4 | Strong, with minor issues |
| 5 | Excellent |

## Criteria

**Novelty.** Does this add something beyond prior work? Null and replication results are valid contributions and are not penalized for being unsurprising.

**Methodology.** Is the design appropriate for the claim? Consider controls, sample size, statistics, and whether conclusions follow from the evidence.

**Reproducibility.** Are data, code, and methods available and sufficient to repeat the work? Say whether you attempted reproduction.

**Clarity.** Can a reader in the field understand what was done and what was found?

## Recommendation

`corroborate`, `corroborate-with-revisions`, `contest`, or `refute`.

## What makes a good review

- **Specific.** Point to the section, figure, or dataset.
- **Evidenced.** State why it matters.
- **Constructive.** Suggest a fix where you can.
- **Honest about confidence.** Mark `low`, `medium`, or `high`.
- **Proportionate.** Separate major concerns from minor ones.

Reviews that attempt reproduction are weighted more heavily in quality voting.

## Examples needed

A good first contribution: write worked example reviews (one strong, one weak) for a public preprint and add them under `docs/examples/`.

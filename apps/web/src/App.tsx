import type { ClaimStatus } from '@elenchus-protocol/sdk';

const LABEL: Record<ClaimStatus, string> = {
  pending: 'Pending',
  examining: 'Under examination',
  corroborated: 'Corroborated',
  contested: 'Contested',
  refuted: 'Refuted',
};

// Placeholder data. Replace with indexer results (see apps/indexer).
const SAMPLE: { id: string; title: string; status: ClaimStatus }[] = [
  { id: 'bafybei…q4', title: 'Effect of intermittent fasting on circadian gene expression in adult mice', status: 'examining' },
  { id: 'bafybei…7m', title: 'A null result: vitamin D supplementation and seasonal mood scores', status: 'corroborated' },
  { id: 'bafybei…ax', title: 'Replication of a reported room-temperature superconductivity signal', status: 'contested' },
];

function StatusChip({ status }: { status: ClaimStatus }) {
  return (
    <span
      className="chip"
      style={{
        color: `var(--elx-color-status-${status}-fg)`,
        background: `var(--elx-color-status-${status}-bg)`,
        borderColor: `var(--elx-color-status-${status}-border)`,
      }}
    >
      {LABEL[status]}
    </span>
  );
}

export function App() {
  return (
    <main className="page">
      <header>
        <h1>Elenchus</h1>
        <p className="reading">
          Register a claim. Examiners stake on their verdicts. Review is rewarded, and the record is open.
        </p>
      </header>

      <section aria-labelledby="claims-heading">
        <h2 id="claims-heading">Claims</h2>
        <ul className="claims">
          {SAMPLE.map((c) => (
            <li key={c.id} className="card">
              <div className="card-top">
                <StatusChip status={c.status} />
                <code>{c.id}</code>
              </div>
              <p className="reading">{c.title}</p>
            </li>
          ))}
        </ul>
      </section>
    </main>
  );
}

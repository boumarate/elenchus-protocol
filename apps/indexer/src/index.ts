import { createServer } from 'node:http';
import type { Claim } from '@elenchus-protocol/sdk';

const port = Number(process.env.INDEXER_PORT ?? 8787);

// In-memory placeholder. TODO(good-first-issue): poll Soroban RPC getEvents for the
// claim-registry contract and persist to SQLite.
const claims: Claim[] = [];

const server = createServer((req, res) => {
  const url = new URL(req.url ?? '/', `http://${req.headers.host ?? 'localhost'}`);
  res.setHeader('content-type', 'application/json');

  if (url.pathname === '/health') {
    res.end(JSON.stringify({ ok: true }));
    return;
  }
  if (url.pathname === '/claims') {
    res.end(JSON.stringify({ claims }));
    return;
  }
  res.statusCode = 404;
  res.end(JSON.stringify({ error: 'not_found' }));
});

server.listen(port, () => {
  console.log(`indexer listening on :${port}`);
});

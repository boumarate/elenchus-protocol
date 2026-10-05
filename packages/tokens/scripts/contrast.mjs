#!/usr/bin/env node
// Checks WCAG contrast for key semantic pairs in both themes. Fails the run if any pair is below its target.
import { readFileSync } from 'node:fs';
const flat = JSON.parse(readFileSync(new URL('../dist/tokens.json', import.meta.url), 'utf8'));
const nest = (obj) => {
  const root = {};
  for (const [path, value] of Object.entries(obj)) {
    const keys = path.split('.');
    let node = root;
    keys.slice(0, -1).forEach((k) => (node = node[k] ??= {}));
    node[keys.at(-1)] = value;
  }
  return root;
};
const themes = Object.fromEntries(Object.entries(flat.themes).map(([n, t]) => [n, nest(t)]));

const lum = (hex) => {
  const n = hex.replace('#', '').slice(0, 6);
  const [r, g, b] = [0, 2, 4].map((i) => parseInt(n.slice(i, i + 2), 16) / 255)
    .map((c) => (c <= 0.03928 ? c / 12.92 : ((c + 0.055) / 1.055) ** 2.4));
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
};
// Blend an 8-digit hex over a base for status chips
const over = (fg, base) => {
  if (fg.length < 9) return fg;
  const a = parseInt(fg.slice(7, 9), 16) / 255;
  const mix = [1, 3, 5].map((i) => Math.round(parseInt(fg.slice(i, i + 2), 16) * a + parseInt(base.slice(i, i + 2), 16) * (1 - a)));
  return '#' + mix.map((c) => c.toString(16).padStart(2, '0')).join('');
};
const ratio = (a, b) => { const [x, y] = [lum(a), lum(b)].sort((p, q) => q - p); return (x + 0.05) / (y + 0.05); };

let failed = 0;
for (const [name, t] of Object.entries(themes)) {
  const c = t.color;
  const pairs = [
    ['text.primary on bg.base', c.text.primary, c.bg.base, 7],
    ['text.secondary on bg.base', c.text.secondary, c.bg.base, 4.5],
    ['text.tertiary on bg.base', c.text.tertiary, c.bg.base, 4.5],
    ['text.primary on bg.raised', c.text.primary, c.bg.raised, 7],
    ['text.link on bg.base', c.text.link, c.bg.base, 4.5],
    ['on-accent on accent.default', c.accent['on-accent'], c.accent.default, 4.5],
    ['on-danger on danger.default', c.danger['on-danger'], c.danger.default, 4.5],
    ['focus.ring on bg.base (3:1 UI)', c.focus.ring, c.bg.base, 3],
    ...Object.entries(c.status).map(([s, v]) => [`status.${s}.fg on its chip`, v.fg, over(v.bg, c.bg.base), 4.5]),
  ];
  console.log(`\n${name}`);
  for (const [label, fg, bg, min] of pairs) {
    const r = ratio(fg, bg);
    const ok = r >= min;
    if (!ok) failed++;
    console.log(`  ${ok ? 'pass' : 'FAIL'}  ${r.toFixed(2).padStart(5)}:1  (min ${min})  ${label}`);
  }
}
if (failed) { console.error(`\n${failed} pair(s) below target.`); process.exit(1); }
console.log('\nAll contrast checks passed.');

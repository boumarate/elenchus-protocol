# @elenchus-protocol/tokens

Design tokens for Elenchus Protocol. One source of truth, four outputs.

```
src/core.json          Primitives + theme-independent tokens (type, space, radius, motion...)
src/themes/dark.json   Semantic colors, dark (default)
src/themes/light.json  Semantic colors, light
        │
        └── pnpm build ──► dist/tokens.css           CSS custom properties
                           dist/tokens.ts            Typed, resolved values
                           dist/tokens.json          Flat map for tooling
                           dist/tailwind-preset.cjs  Tailwind preset using the CSS variables
```

The source follows the [W3C Design Tokens](https://tr.designtokens.org/format/) draft (`$value`, `$type`, `$description`, `{references}`), so Style Dictionary, Tokens Studio, or Figma plugins can read it later without changes.

## Design direction

Elenchus is the Socratic method of testing a claim by questioning it. The interface should feel like a place where claims are examined carefully, not a trading terminal.

- **Dark, green-tinged base.** `palette.ink.0` is `#070906`, sampled from bio.xyz's `theme-color`. Every other value in this package is Elenchus's own. Bio's full stylesheet was not available, so this is Bio-inspired, not a copy of Bio's tokens. Replace values in `src/` if you obtain the real ones.
- **Verdigris accent.** Oxidised-copper green. Calm and scientific, not neon.
- **Three typefaces with clear jobs.** Schibsted Grotesk for interface, Newsreader (serif) for reading manuscripts and reviews, JetBrains Mono for hashes, CIDs, and addresses.
- **Status colors map to the claim lifecycle:** pending, examining, corroborated, contested, refuted.
- **Borders over shadows** on dark surfaces. Shadows are for floating layers only.
- **Radius encodes hierarchy.** Tight on inputs, softer on panels, round on status chips.

Trademarks: Bio's logos and wordmarks are theirs. Do not use them in Elenchus.

## Usage

### CSS

```css
@import '@elenchus-protocol/tokens/css';

.card {
  background: var(--elx-color-bg-raised);
  border: var(--elx-border-width-hairline) solid var(--elx-color-border-subtle);
  border-radius: var(--elx-radius-lg);
  padding: var(--elx-space-6);
}
```

Theme switching:

```html
<html data-theme="light">  <!-- or "dark". Omit to follow the OS (dark if no preference) -->
```

### Tailwind

```js
// tailwind.config.js
module.exports = {
  presets: [require('@elenchus-protocol/tokens/tailwind')],
  content: ['./src/**/*.{ts,tsx}'],
};
```

```html
<div class="bg-bg-raised text-text-primary rounded-lg border border-border-subtle p-6">
  <span class="text-status-corroborated-fg bg-status-corroborated-bg">Corroborated</span>
</div>
```

### TypeScript

```ts
import { themes, cssVar } from '@elenchus-protocol/tokens/ts';

themes.dark.color.accent.default; // '#5FCBA4'
cssVar['color.bg.base'];          // 'var(--elx-color-bg-base)'
```

## Rules

1. **Components use semantic tokens only** (`color.*`), never `palette.*`. That is what makes theming work.
2. **Never convey status by color alone.** Pair status colors with a text label or icon.
3. **Adding a semantic token means adding it to both themes.** The build fails if `dark.json` and `light.json` differ.
4. **Adding a palette value goes in `core.json`.** Theme files may not define `palette.*`.
5. **Contrast is checked on every build** (`scripts/contrast.mjs`): body text 7:1, secondary text and status chips 4.5:1, focus ring 3:1. A failing pair fails the build.
6. **Generated files in `dist/` are committed** so contributors can use the package without building. CI runs `pnpm check` to catch stale output.

## Token reference

| Group | Prefix | Notes |
|---|---|---|
| Palette | `--elx-palette-{ink,bone,verdigris,cobalt,amber,madder}-{step}` | Primitives only |
| Semantic color | `--elx-color-{bg,border,text,accent,danger,focus,status}-*` | Themed |
| Type | `--elx-font-{family,weight,size,leading,tracking}-*` | Raw scales |
| Text styles | `--elx-text-{display,h1,h2,h3,body,reading,label,caption,code}-{family,size,weight,leading,tracking}` | Composed styles |
| Measure | `--elx-measure-{prose,ui,page}` | Max line lengths. Serif prose is 68ch |
| Space | `--elx-space-{0..32}` | 4px base |
| Radius | `--elx-radius-{none,sm,md,lg,xl,pill}` | |
| Border | `--elx-border-width-{hairline,thick}` | |
| Shadow | `--elx-shadow-{sm,md,lg}` | |
| Motion | `--elx-motion-{duration,easing}-*` | Durations collapse to 0 under `prefers-reduced-motion` |
| Z-index | `--elx-z-{base,sticky,dropdown,overlay,modal,toast}` | |
| Breakpoint | `--elx-breakpoint-{sm,md,lg,xl}` | For reference. CSS variables cannot be used in media queries |

## Develop

```bash
pnpm build      # validate, resolve references, emit dist/, check contrast
pnpm check      # CI: rebuild and fail if dist/ is out of date
open preview.html   # visual check of palette, status chips, type, and a sample card
```

Requires Node 18+. No dependencies.

## Fonts

Tokens name the font families but do not load them. Load Schibsted Grotesk, Newsreader, and JetBrains Mono in your app (for example with `next/font` or a Google Fonts link). Fallback stacks are defined so layout stays stable while they load.

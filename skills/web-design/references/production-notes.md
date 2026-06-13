# Production Notes

Shared hard-won notes for Müller-Brockmann editorial pages and Vignelli Canon design systems. Read when rasterizing artwork, embedding images, running headless verification, or shipping type-critical heroes.

## Type fidelity when rasterizing

Helvetica is not installed in most headless environments. Rasterizing SVG/HTML (cairosvg, headless-Chromium screenshots) with a `Helvetica`/`Arial`/`sans-serif` stack silently falls back to Noto Sans — a rounded humanist face that reads like Calibri and breaks the grotesque. The failure is invisible until someone asks "why does this look like Calibri?"

Fix:

- Render in a true Helvetica/Arial-metric grotesque — Liberation Sans (verify with `fc-match "Liberation Sans:bold"`) or an embedded Helvetica/Arimo TTF.
- Run `fc-match Helvetica` to reveal the fallback chain.
- Always eyeball one render before trusting automated output.

The same trap applies to optical-alignment canvas measurement: side-bearing is font-specific. Headless Chrome often lacks the webfont, so canvas falls back to a different grotesque. To verify optics offline, embed the real webfont via `@font-face` (local TTF). In production, runtime JS that measures the loaded font is correct for the user.

## Optical alignment caveat

Large display glyphs carry a left side-bearing: the ink sits inside the layout box, so a headline whose box is on the column line still looks indented against body text. Runtime canvas measurement (see [muller-brockmann-grid.md](muller-brockmann-grid.md) §2.6) must use the actually-loaded font. Wrong font in → wrong nudge out.

## Image embedding

Use project-relative paths or the site's public asset directory (`public/`, `static/`, etc.). Avoid:

- Thread-scoped or authenticated URLs that break in preview iframes or static export.
- Hotlinking without license or stable hosting.

For local HTML previews, serve via a dev server rather than opening `file://` when modules or CORS matter. For static editorial pages without ES modules, `file://` works for both preview and `verify_grid.js`.

Prefer real photography over generic stock when the brief calls for editorial credibility. Use user-provided assets, licensed sources, or project-owned images.

## Headless grid verification

`verify_grid.js` requires:

- `CHROME` — path to a Chrome/Chromium binary.
- `PUP` — path to the `puppeteer-core` module (install with `npm install puppeteer-core` in the project, then set `PUP` to that module path).

If `puppeteer-core` is not installed, Node exits with `Cannot find module 'puppeteer-core'`. Use manual verification instead (see below).

On Windows, if `grid_tokens.py --scaffold` fails with `UnicodeEncodeError` on stdout, set `PYTHONIOENCODING=utf-8` or redirect output to a UTF-8 file.

Sandbox Chrome flags that work:

```text
--headless=new --no-sandbox --disable-gpu --disable-dbus --use-gl=angle --use-angle=swiftshader
```

If Puppeteer is unavailable, fall back to:

1. Toggle the grid overlay (`G` key) in a browser.
2. Screenshot a zoom crop of the top-left corner (masthead vs body vs column line).
3. Check that gutter, margin, and baseline multiples are consistent by inspection.

A clean automated run looks like: `col=0px overlay=0px baseline≤4px ink=0px` → `GRID VERIFY: PASS`.

## Optional code → image workflow

When you need in-situ mockups (signage on a wall, diagram in a station):

1. Draw the type/diagram in code first, in the correct grotesque — the source of truth.
2. If using an image model, pass the crisp artwork as a reference and name the face explicitly: *Helvetica Bold, Swiss neo-grotesque; NOT Calibri, NOT Noto Sans, NOT a rounded humanist sans.*
3. If the reference font is wrong, the model reproduces the wrong font — fix the reference before blaming the prompt.

Avoid video generation for type-critical heroes. Most video models drift letterforms frame-to-frame. When type is the hero, deliver stills or screen-capture an interactive webpage.

## Wayfinding-in-context vocabulary (Vignelli)

Useful shot types when documenting transit/wayfinding work:

- Type on the train flank (wordmark + destination blind).
- Route diagram on the wall (backlit, traveler in silhouette).
- Paper map in hand by a window.
- Overhead platform directional (white Helvetica on signal blue).
- Station ID + square platform flag.
- Concourse pictogram totem.

Pair each coded design beside its in-context render when the deliverable is a case study.

# Lake Iseo Camper + SUP Guide

A source-controlled travel guide for a camper-van and stand-up-paddleboarding trip to Lake Iseo, Italy.

The canonical publication entry point is **`guide.qmd`**. The long-form content is split into small Markdown/Quarto include files under **`content/`**, so ordinary travel-guide edits do not require touching the PDF or web templates.

## Outputs

The project builds two editions from the same source:

- **HTML** — a responsive web edition styled with `styles.scss`
- **PDF** — an A4 publication-style edition rendered by **Typst** through the local Quarto format in `_extensions/iseo-guide/`

The PDF build uses Typst, not LaTeX. Quarto includes the Typst compiler, so no separate Typst installation is required.

## Build locally

Install [Quarto](https://quarto.org/docs/get-started/) **1.10 or newer**.

```bash
make all
```

Or run the outputs separately:

```bash
quarto render guide.qmd --to html
quarto render guide.qmd --to iseo-guide-typst
```

Rendered files are written to `_output/`:

```text
_output/
├── index.html
├── lake-iseo-camper-guide.pdf
└── lake-iseo-camper-guide.typ   # copied here by CI when Quarto emits retained source
```

For live HTML editing:

```bash
make preview
```

## Repository structure

```text
.
├── guide.qmd                    # publication entry point + metadata
├── content/                     # editable guide chapters/sections
│   ├── 01.qmd
│   ├── 02.qmd
│   └── ...
├── _quarto.yml
├── styles.scss                  # web edition design
├── Makefile
├── _extensions/
│   └── iseo-guide/
│       ├── _extension.yml
│       ├── typst-template.typ   # PDF publication design
│       └── page.typ             # PDF page geometry/header
└── .github/
    └── workflows/
        └── build.yml
```

### Where to edit what

- **Travel-guide content:** `content/*.qmd`
- **Title, formats and include order:** `guide.qmd`
- **Web appearance:** `styles.scss`
- **PDF appearance:** `_extensions/iseo-guide/typst-template.typ`
- **PDF page geometry/header:** `_extensions/iseo-guide/page.typ`
- **Quarto project settings:** `_quarto.yml`
- **CI build:** `.github/workflows/build.yml`

## Continuous integration

Every push to `main`, every pull request, and every manual workflow run builds **both HTML and PDF**.

The workflow uploads a `lake-iseo-guide` artifact containing the complete `_output/` directory. It also collects Quarto's retained generated Typst source when available, so the exact typeset intermediate can be inspected alongside the PDF.

The Quarto version is pinned in CI so that changes in future Quarto/Typst releases do not silently change the publication.

## Design approach

The PDF format is deliberately local to this repository. It uses Quarto's Typst template-partial mechanism, with a lake-inspired palette, editorial cover, page header, styled section hierarchy, tables and callouts. This keeps the Markdown independent of layout code and makes later redesigns possible without rewriting the guide.

The design is inspired by magazine/newsletter Typst templates such as the free `dashing-dept-news` family, but is implemented as a purpose-built long-form guide rather than forcing the content into a newsletter schema.

## HTML publishing

The HTML edition is already built by CI and included in the workflow artifact. The repository is **not yet configured to serve it through GitHub Pages**; doing that is optional and requires enabling/configuring Pages for the repository. The build itself does not depend on Pages.

## Generated files

Generated output is intentionally **not committed** to `main`; download it from the GitHub Actions artifact. This keeps the source history clean while still producing reproducible PDF and HTML editions on every change.

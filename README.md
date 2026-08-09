# Peachy Keen Green

Peachy Keen Green is a static site for Vegan Recipies that is built with [Hugo](https://gohugo.io/).

---

## 1. Environment & Prerequisites

1. **Python 3.13** & `direnv` (optional but recommended):
   If using `direnv`, allow the directory environment to set `PROJECT_ROOT`, `PYTHON_VERSION="3.13"`, and add system paths:
   ```bash
   direnv allow
   ```
2. **Hugo**:
   Ensure Hugo is installed (`hugo version`).

3. **Virtual Environment & Dependencies (Optional)**:
   The tools use standard library modules exclusively and require no external runtime dependencies.
   If you wish to set up a virtual environment or install development tools (`pytest`, `ruff`):
   ```bash
   python -m venv .venv
   source .venv/bin/activate
   pip install -e ".[dev]"
   ```

---

## 2. Creating New Content

Content is organized as Hugo Leaf Bundles under `src/`. Each recipe has its own folder containing `index.md` and its dedicated image files.

To create a new Leaf Bundle article automatically:

```bash
hugo new foo-bar-baz/index.md
```

Hugo automatically creates the folder (`src/foo-bar-baz/`), sets `title: "Foo Bar Baz"` and `slug: "foo-bar-baz"`, and populates `index.md` using the default archetype template (`archetypes/default.md`).

Example directory: `src/foo-bar-baz/`
- `index.md`
- `foo-bar-baz-img-1.jpg`

Example generated `src/foo-bar-baz/index.md`:
```yaml
---
title: "Foo Bar Baz"
slug: "foo-bar-baz"
date: 2026-08-09T13:46:55-07:00
draft: false
categories: []
description: ""
featured_image: ""
---

Recipe content goes here in Markdown format.
```

---

## 3. Development & Usage

### Re-Building the Site (`./gen.sh`)
By default, `./gen.sh` cleans generated site artifacts from `docs/` (while preserving static assets in `docs/images/` and `docs/css/`) before rebuilding the site:

```bash
./gen.sh
```

To skip the clean step and build directly into `docs/`:

```bash
./gen.sh --no-clean
```

### Running the Hugo Local Development Server (`hugo server`)
To preview the site locally on port 8080:

```bash
hugo server --port 8080
```

To prevent Hugo from injecting the live reload auto-refresh script (`<script src="/livereload.js...">`) into HTML files during local preview:

```bash
hugo server --port 8080 --disableLiveReload
```

Useful flags:
- Include draft posts: `hugo server --port 8080 -D`
- Include future-dated posts: `hugo server --port 8080 --buildFuture`
- Disable live reload script injection: `hugo server --port 8080 --disableLiveReload`

The development server serves the site at `http://localhost:8080/` and watches `src/` and `page_layouts/` for updates.

---

## 4. Search System & GitHub Pages Serving

The search system operates statically on GitHub Pages:
- **Hugo Index Template (`docs/index.json`)**: Generated automatically during `./gen.sh` via Hugo's native `outputs.home = ["HTML", "JSON"]` template (`page_layouts/index.json`).
- **Inline Header Search**: Clicking the 🔍 icon in the header expands an inline search input field. Pressing **Return / Enter** or clicking 🔍 executes search (`/?q=query`).
- **Edge CDN JS Delivery**: Uses [Fuse.js](https://fusejs.io/) via jsDelivr Edge CDN (`https://cdn.jsdelivr.net/npm/fuse.js@7.0.0/dist/fuse.basic.min.js`) loaded with `defer` for zero initial page load impact.

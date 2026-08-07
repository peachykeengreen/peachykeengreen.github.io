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

The starting point for creating new content (recipes or posts) is adding a new `.md` file to `src/`.

Example `src/my-new-recipe.md`:
```yaml
---
title: "My New Recipe"
slug: "my-new-recipe"
date: "2026-08-07T09:00:00-07:00"
lastmod: "2026-08-07T09:00:00-07:00"
draft: false
categories: ["Entree"]
description: "A description of the recipe."
featured_image: "/images/my-new-recipe-img-1.jpg"
---

Recipe content goes here in Markdown format.
```

---

## 3. Development & Usage

### Re-Building the Site (`./gen.sh`)
By default, `./gen.sh` cleans generated site artifacts from `dest/` (while preserving static assets in `dest/images/` and `dest/css/`) before rebuilding the site:

```bash
./gen.sh
```

To skip the clean step and build directly into `dest/`:

```bash
./gen.sh --no-clean
```

### Running the Hugo Local Development Server (`hugo server`)
To preview the site locally with live reloading on port 8080:

```bash
hugo server --port 8080
```

Useful flags:
- Include draft posts: `hugo server --port 8080 -D`
- Include future-dated posts: `hugo server --port 8080 --buildFuture`

The development server serves the site at `http://localhost:8080/` and automatically watches `src/` and `page_layouts/` for live updates. Image assets live directly in `dest/images/` and CSS assets live in `dest/css/`, both preserved across `./gen.sh` builds.

---

## 4. Search System & GitHub Pages Serving

The search system operates statically on GitHub Pages:
- **Hugo Index Template (`dest/index.json`)**: Generated automatically during `./gen.sh` via Hugo's native `outputs.home = ["HTML", "JSON"]` template (`page_layouts/index.json`).
- **Inline Header Search**: Clicking the 🔍 icon in the header expands an inline search input field. Pressing **Return / Enter** or clicking 🔍 executes search (`/?q=query`).
- **Edge CDN JS Delivery**: Uses [Fuse.js](https://fusejs.io/) via jsDelivr Edge CDN (`https://cdn.jsdelivr.net/npm/fuse.js@7.0.0/dist/fuse.basic.min.js`) loaded with `defer` for zero initial page load impact.

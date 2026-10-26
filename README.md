# project_sites

Simple Jekyll/GitHub Pages landing page for the `jhuapl-bio` GitHub organization.

Published at **https://jhuapl-bio.github.io/project_sites/** from https://github.com/jhuapl-bio/project_sites.

## Deployment

Every push to `main` runs `.github/workflows/pages.yml`, which builds the site with Jekyll and deploys it to GitHub Pages. One-time setup: in **Settings → Pages**, set **Source** to **GitHub Actions**.

## Setup

1. Download the approved JHU/APL logo from the official Johns Hopkins brand resources and save the appropriate artwork as `assets/img/apl-logo.svg`.
2. Edit `_data/projects.yml` to add/remove categories and repositories.

## Editing projects

Each category in `_data/projects.yml` contains a title, description, icon, and list of repositories. No HTML edits are needed for routine additions.

## Local preview

If Ruby/Jekyll is installed:

```bash
bundle exec jekyll serve
```

For this simple site, pushing directly to GitHub Pages is generally sufficient.

## Branding

The stylesheet uses Johns Hopkins Heritage Blue and restrained Hopkins accent colors. Use only official, approved Johns Hopkins/JHU/APL logo artwork and follow the current Johns Hopkins brand guidelines.


## Local demo

For a zero-dependency demo, simply open `demo.html` in a browser. It is fully standalone and has its CSS embedded.

```bash
open demo.html        # macOS
xdg-open demo.html    # Linux
```

Alternatively, preview the Jekyll source locally with `bundle exec jekyll serve` if you have Jekyll installed.

## Regenerating `demo.html`

After changing `index.html`, `_data/projects.yml`, or `assets/css/style.css`, run:

```bash
make demo
```

This runs Jekyll, renders the YAML/Liquid templates, inlines the generated CSS, and replaces `demo.html` with a standalone file that can be opened directly in a browser.

Other useful commands:

```bash
make serve   # Jekyll development server
make build   # Build the normal site into _site/
make clean   # Remove Jekyll build/cache files
```

If Jekyll is not installed, `make demo` will print installation guidance instead of silently producing a stale demo.

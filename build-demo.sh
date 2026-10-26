#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

if [[ -f Gemfile ]] && command -v bundle >/dev/null 2>&1; then
  JEKYLL=(bundle exec jekyll)
elif command -v jekyll >/dev/null 2>&1; then
  JEKYLL=(jekyll)
else
  cat >&2 <<'MSG'
Error: Jekyll was not found.

Install Jekyll, then rerun:
  make demo

For example, with Ruby available:
  gem install bundler jekyll
MSG
  exit 1
fi

BUILD_DIR="${TMPDIR:-/tmp}/jhuapl-bio-demo.$$"
trap 'rm -rf "$BUILD_DIR"' EXIT

"${JEKYLL[@]}" build --destination "$BUILD_DIR"

INDEX="$BUILD_DIR/index.html"
CSS="$BUILD_DIR/assets/css/style.css"

[[ -f "$INDEX" ]] || { echo "Error: Jekyll did not produce index.html" >&2; exit 1; }
[[ -f "$CSS" ]] || { echo "Error: Jekyll did not produce assets/css/style.css" >&2; exit 1; }

python3 - "$INDEX" "$CSS" "$ROOT/demo.html" <<'PY'
from pathlib import Path
import re
import sys

index_path, css_path, output_path = map(Path, sys.argv[1:])
html = index_path.read_text(encoding="utf-8")
css = css_path.read_text(encoding="utf-8")

# Replace the generated stylesheet link with embedded CSS so demo.html is portable.
pattern = r'<link\s+rel=["\']stylesheet["\']\s+href=["\'][^"\']*assets/css/style\.css["\']\s*/?>'
replacement = '<style>\n' + css + '\n</style>'
html, count = re.subn(pattern, replacement, html, count=1, flags=re.IGNORECASE)
if count != 1:
    raise SystemExit("Error: could not find the site stylesheet link in generated index.html")

output_path.write_text(html, encoding="utf-8")
PY

echo "Created: $ROOT/demo.html"

#!/bin/bash
# scripts/build-zims.sh
# Compiles the three MComzLibrary ZIM files from downloaded source texts.
# Prerequisites: zim-tools (zimwriterfs), pandoc
# Run scripts/download-sources.sh first.
#
# Each ZIM's welcome page is a pandoc rendering of docs/intros/INTRO_<CAT>.md,
# which carries the links-table that readers use to open the texts.
# EPUB sources are converted to single self-contained HTML via pandoc.
# PDFs are bundled alongside HTML at the top level of each ZIM.

set -euo pipefail

SOURCES="${MCOMZ_SOURCES_DIR:-sources}"
BUILD="build"
DIST="dist"
INTROS="docs/intros"

# ── Dependency check ──────────────────────────────────────────────────────────
for cmd in zimwriterfs pandoc; do
  command -v "$cmd" >/dev/null 2>&1 || {
    echo "ERROR: $cmd not found." >&2
    echo "  Install: sudo apt-get install zim-tools pandoc" >&2
    exit 1
  }
done

mkdir -p "$DIST"

# ── Helpers ───────────────────────────────────────────────────────────────────

# Convert an EPUB to a single self-contained HTML file via pandoc.
epub_to_html() {
  local epub="$1" dest_html="$2"
  [[ -f "$dest_html" ]] && { echo "  skip  $(basename "$dest_html")"; return; }
  echo "  conv  $(basename "$epub")"
  pandoc "$epub" \
    --to=html5 \
    --standalone \
    --metadata title="$(basename "$epub" .epub | tr '-' ' ')" \
    -o "$dest_html" 2>/dev/null || {
      echo "  WARN: pandoc failed for $epub" >&2
      rm -f "$dest_html"
    }
}

# Render an intro .md as the ZIM's welcome index.html, wrapped in house styling.
generate_index_from_md() {
  local intro_md="$1" build_dir="$2" title="$3"
  local out="$build_dir/index.html"
  echo "  Rendering $(basename "$intro_md") → index.html"

  local body
  body=$(pandoc "$intro_md" --from=gfm --to=html5)

  cat > "$out" <<HTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${title}</title>
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
           max-width: 820px; margin: 2rem auto; padding: 0 1.5rem;
           background: #fff; color: #222; line-height: 1.6; }
    h1 { border-bottom: 2px solid #333; padding-bottom: .5rem; }
    h2 { margin-top: 2rem; color: #333; }
    h3 { margin-top: 1.5rem; color: #444; }
    a { color: #0066cc; text-decoration: none; }
    a:hover { text-decoration: underline; }
    table { border-collapse: collapse; margin: 1rem 0; width: 100%;
            font-size: .95rem; }
    th, td { border: 1px solid #ddd; padding: .5rem .75rem; text-align: left;
             vertical-align: top; }
    th { background: #f4f4f4; }
    blockquote { border-left: 3px solid #ccc; margin: 1rem 0;
                 padding: .25rem 1rem; color: #555; background: #fafafa; }
    code { background: #f4f4f4; padding: .1rem .3rem; border-radius: 3px;
           font-size: .9em; }
    footer { margin-top: 3rem; padding-top: 1rem; border-top: 1px solid #ccc;
             font-size: .85rem; color: #888; }
  </style>
</head>
<body>
${body}
<footer>
  Part of <a href="https://github.com/mcomz-org/MComzLibrary">MComzLibrary</a>
  — offline knowledge for MComzOS.
</footer>
</body>
</html>
HTML
}

# ── Build one ZIM ─────────────────────────────────────────────────────────────
build_zim() {
  local category="$1" zim_name="$2" title="$3" description="$4" intro_md="$5"
  local src="$SOURCES/$category"
  local build_dir="$BUILD/$category"

  echo ""
  echo "=== Building ${zim_name}.zim ==="
  mkdir -p "$build_dir"

  # Convert EPUBs → self-contained HTML
  shopt -s nullglob
  for epub in "$src"/*.epub; do
    epub_to_html "$epub" "$build_dir/$(basename "$epub" .epub).html"
  done

  # Copy HTML files directly
  for html in "$src"/*.html; do
    local dest="$build_dir/$(basename "$html")"
    [[ -f "$dest" ]] && { echo "  skip  $(basename "$html")"; continue; }
    cp "$html" "$dest"
    echo "  copy  $(basename "$html")"
  done

  # Copy PDFs alongside HTML at the top level
  for pdf in "$src"/*.pdf; do
    local dest="$build_dir/$(basename "$pdf")"
    [[ -f "$dest" ]] && { echo "  skip  $(basename "$pdf")"; continue; }
    cp "$pdf" "$dest"
    echo "  pdf   $(basename "$pdf")"
  done
  shopt -u nullglob

  # Render the intro .md as the welcome page
  generate_index_from_md "$intro_md" "$build_dir" "$title"

  # Generate a minimal 48x48 PNG illustration (required by zimwriterfs)
  python3 - "$build_dir/illustration.png" <<'PYEOF'
import struct, zlib, sys
def make_png(path, r, g, b):
    def chunk(t, d):
        return struct.pack('>I', len(d)) + t + d + struct.pack('>I', zlib.crc32(t + d) & 0xffffffff)
    row = bytes([0]) + bytes([r, g, b] * 48)
    data = zlib.compress(row * 48)
    open(path, 'wb').write(
        b'\x89PNG\r\n\x1a\n'
        + chunk(b'IHDR', struct.pack('>IIBBBBB', 48, 48, 8, 2, 0, 0, 0))
        + chunk(b'IDAT', data)
        + chunk(b'IEND', b'')
    )
make_png(sys.argv[1], 26, 82, 118)   # MComz blue
PYEOF

  # Compile ZIM
  echo "  Compiling ZIM..."
  zimwriterfs \
    --welcome=index.html \
    --illustration=illustration.png \
    --language=eng \
    --title="$title" \
    --description="$description" \
    --longDescription="$description" \
    --creator="MComzLibrary contributors" \
    --publisher="mcomz-org" \
    --name="mcomz_en_${category}" \
    --withFullTextIndex \
    "$build_dir" \
    "$DIST/${zim_name}.zim"

  local size
  size=$(du -sh "$DIST/${zim_name}.zim" | cut -f1)
  echo "  Done: $DIST/${zim_name}.zim (${size})"
}

# ── Build all three ZIMs ──────────────────────────────────────────────────────

build_zim "spiritual" "MComz-Scriptures" \
  "MComz Scriptures" \
  "Religious and philosophical texts from seven major world traditions" \
  "$INTROS/INTRO_SCRIPTURES.md"

build_zim "literature" "MComz-Literature" \
  "MComz Literature" \
  "Classic literature for morale, education, and younger readers" \
  "$INTROS/INTRO_LITERATURE.md"

build_zim "survival" "MComz-Survival" \
  "MComz Survival Reference" \
  "Medical, survival, civil defence, communications, and engineering reference" \
  "$INTROS/INTRO_SURVIVAL.md"

echo ""
echo "=== All ZIMs built ==="
ls -lh "$DIST/"
echo ""
echo "Total size:"
du -sh "$DIST/"

#!/bin/bash
# scripts/build-zims.sh
# Compiles the three MComzLibrary ZIM files from downloaded source texts.
# Prerequisites: zim-tools (zimwriterfs), pandoc
# Run scripts/download-sources.sh first.
#
# Source texts become single self-contained HTML files (via pandoc for EPUBs).
# PDFs are bundled as downloadable files within the ZIM.
# Each ZIM has a generated index.html as its main page.

set -euo pipefail

SOURCES="${MCOMZ_SOURCES_DIR:-sources}"
BUILD="build"
DIST="dist"

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

# Prettify a filename slug into a display title.
# "king-james-version" → "King James Version"
slug_to_title() {
  echo "$1" | tr '-' ' ' | sed 's/\b./\u&/g'
}

# Generate the main index.html for a ZIM.
generate_index() {
  local build_dir="$1" title="$2" description="$3"
  local out="$build_dir/index.html"
  echo "  Generating index.html"

  {
    cat <<HTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${title}</title>
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, sans-serif;
           max-width: 800px; margin: 2rem auto; padding: 0 1.5rem;
           background: #fff; color: #222; line-height: 1.6; }
    h1 { border-bottom: 2px solid #333; padding-bottom: .5rem; }
    h2 { margin-top: 1.5rem; color: #444; font-size: 1rem;
         text-transform: uppercase; letter-spacing: .05em; }
    ul { list-style: none; padding: 0; }
    li { margin: .4rem 0; }
    a { color: #0066cc; text-decoration: none; font-size: 1.05rem; }
    a:hover { text-decoration: underline; }
    .pdf::before { content: "📄 "; }
    footer { margin-top: 2rem; padding-top: 1rem; border-top: 1px solid #ccc;
             font-size: .8rem; color: #888; }
  </style>
</head>
<body>
<h1>${title}</h1>
<p>${description}</p>
HTML

    # HTML books
    local book_items=()
    for f in "$build_dir"/*.html; do
      [[ "$(basename "$f")" == "index.html" ]] && continue
      [[ -f "$f" ]] || continue
      local name label
      name=$(basename "$f" .html)
      label=$(slug_to_title "$name")
      book_items+=("  <li><a href=\"${name}.html\">${label}</a></li>")
    done
    if [[ ${#book_items[@]} -gt 0 ]]; then
      echo "<h2>Texts</h2><ul>"
      printf '%s\n' "${book_items[@]}"
      echo "</ul>"
    fi

    # PDFs
    if compgen -G "$build_dir/downloads/*.pdf" >/dev/null 2>&1; then
      echo "<h2>Reference Documents</h2>"
      echo "<ul>"
      for pdf in "$build_dir/downloads/"*.pdf; do
        [[ -f "$pdf" ]] || continue
        local pname plabel
        pname=$(basename "$pdf")
        plabel=$(slug_to_title "${pname%.pdf}")
        echo "  <li class=\"pdf\"><a href=\"downloads/${pname}\">${plabel}</a></li>"
      done
      echo "</ul>"
    fi

    cat <<HTML
<footer>
  Part of <a href="https://github.com/mcomz-org/MComzLibrary">MComzLibrary</a>
  — offline knowledge for MComzOS.
</footer>
</body></html>
HTML
  } > "$out"
}

# ── Build one ZIM ─────────────────────────────────────────────────────────────
build_zim() {
  local category="$1" zim_name="$2" title="$3" description="$4"
  local src="$SOURCES/$category"
  local build_dir="$BUILD/$category"

  echo ""
  echo "=== Building ${zim_name}.zim ==="
  mkdir -p "$build_dir/downloads"

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

  # Copy PDFs into downloads/
  for pdf in "$src"/*.pdf; do
    local dest="$build_dir/downloads/$(basename "$pdf")"
    [[ -f "$dest" ]] && { echo "  skip  $(basename "$pdf")"; continue; }
    cp "$pdf" "$dest"
    echo "  pdf   $(basename "$pdf")"
  done
  shopt -u nullglob

  # Generate index
  generate_index "$build_dir" "$title" "$description"

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
    "$build_dir" \
    "$DIST/${zim_name}.zim"

  local size
  size=$(du -sh "$DIST/${zim_name}.zim" | cut -f1)
  echo "  Done: $DIST/${zim_name}.zim (${size})"
}

# ── Build all three ZIMs ──────────────────────────────────────────────────────

build_zim "spiritual" "MComz-Scriptures" \
  "MComz Scriptures" \
  "Religious and philosophical texts from seven major world traditions"

build_zim "literature" "MComz-Literature" \
  "MComz Literature" \
  "Classic literature for morale, education, and younger readers"

build_zim "survival" "MComz-Survival" \
  "MComz Survival Reference" \
  "Medical, survival, civil defence, communications, and engineering reference"

echo ""
echo "=== All ZIMs built ==="
ls -lh "$DIST/"
echo ""
echo "Total size:"
du -sh "$DIST/"

#!/bin/bash
# scripts/download-sources.sh
# Downloads all CORE source texts for MComzLibrary.
# Usage: ./scripts/download-sources.sh [--force]
#
# Idempotent: skips files that already exist unless --force is passed.
# Failed downloads print a WARN and leave no partial file — run again to retry.
#
# TODO markers indicate URLs that need manual verification before the first
# production run. Test each marked URL in a browser first.

set -euo pipefail

SOURCES="${MCOMZ_SOURCES_DIR:-sources}"
FORCE="${1:-}"

mkdir -p \
  "$SOURCES/spiritual" \
  "$SOURCES/literature" \
  "$SOURCES/survival"

# Download helper — skips if file exists, warns on failure, never leaves partial files.
dl() {
  local dest="$1" url="$2"
  [[ "$FORCE" != "--force" && -f "$dest" ]] && { echo "  skip  $dest"; return; }
  echo "  fetch $dest"
  wget -q --show-progress -O "$dest.tmp" "$url" 2>&1 && mv "$dest.tmp" "$dest" || {
    echo "  WARN: failed — $url" >&2
    rm -f "$dest.tmp"
  }
}

# ── SPIRITUAL ─────────────────────────────────────────────────────────────────
echo "=== Spiritual ==="

# Berean Standard Bible — CC0 (public domain dedication 30 Apr 2023)
# TODO: verify download URL; check https://bereanbible.com/bsb.epub works
dl "$SOURCES/spiritual/berean-standard-bible.epub" \
   "https://bereanbible.com/bsb.epub"

# King James Version — PG #10
dl "$SOURCES/spiritual/king-james-version.html" \
   "https://www.gutenberg.org/files/10/10-h/10-h.htm"

# The Quran (Yusuf Ali, 1934 text) — PG #16955
# Use 1934 text specifically — NOT the 1977 revised edition.
dl "$SOURCES/spiritual/quran-yusuf-ali.html" \
   "https://www.gutenberg.org/files/16955/16955-h/16955-h.htm"

# Bhagavad Gita — "The Song Celestial" (Sir Edwin Arnold trans.) — PG #2388
dl "$SOURCES/spiritual/bhagavad-gita-arnold.html" \
   "https://www.gutenberg.org/files/2388/2388-h/2388-h.htm"

# Tao Te Ching (James Legge trans.) — PG #216
dl "$SOURCES/spiritual/tao-te-ching-legge.html" \
   "https://www.gutenberg.org/files/216/216-h/216-h.htm"

# JPS Tanakh 1917 — PG #2961
# TODO: verify PG #2961 is the full JPS 1917 Tanakh (Holy Scriptures)
dl "$SOURCES/spiritual/tanakh-jps-1917.html" \
   "https://www.gutenberg.org/files/2961/2961-h/2961-h.htm"

# ── LITERATURE ────────────────────────────────────────────────────────────────
echo "=== Literature ==="

# The Complete Works of William Shakespeare — PG #100
dl "$SOURCES/literature/shakespeare-complete-works.html" \
   "https://www.gutenberg.org/files/100/100-h/100-h.htm"

# The Adventures of Sherlock Holmes (Conan Doyle) — Standard Ebooks
dl "$SOURCES/literature/sherlock-holmes.epub" \
   "https://standardebooks.org/ebooks/arthur-conan-doyle/the-adventures-of-sherlock-holmes/downloads/arthur-conan-doyle_the-adventures-of-sherlock-holmes.epub"

# The Count of Monte Cristo (Dumas) — Standard Ebooks
# TODO: verify translator slug — SE may use a specific translator name in the URL
dl "$SOURCES/literature/count-of-monte-cristo.epub" \
   "https://standardebooks.org/ebooks/alexandre-dumas/the-count-of-monte-cristo/anonymous/downloads/alexandre-dumas_the-count-of-monte-cristo_anonymous.epub"

# Pride and Prejudice (Jane Austen) — Standard Ebooks
dl "$SOURCES/literature/pride-and-prejudice.epub" \
   "https://standardebooks.org/ebooks/jane-austen/pride-and-prejudice/downloads/jane-austen_pride-and-prejudice.epub"

# Meditations (Marcus Aurelius, George Long trans.) — Standard Ebooks
dl "$SOURCES/literature/meditations.epub" \
   "https://standardebooks.org/ebooks/marcus-aurelius/meditations/george-long/downloads/marcus-aurelius_meditations_george-long.epub"

# The Call of the Wild (Jack London) — Standard Ebooks
dl "$SOURCES/literature/call-of-the-wild.epub" \
   "https://standardebooks.org/ebooks/jack-london/the-call-of-the-wild/downloads/jack-london_the-call-of-the-wild.epub"

# Treasure Island (R.L. Stevenson) — Standard Ebooks
dl "$SOURCES/literature/treasure-island.epub" \
   "https://standardebooks.org/ebooks/robert-louis-stevenson/treasure-island/downloads/robert-louis-stevenson_treasure-island.epub"

# The Jungle Book (Rudyard Kipling) — Standard Ebooks
dl "$SOURCES/literature/jungle-book.epub" \
   "https://standardebooks.org/ebooks/rudyard-kipling/the-jungle-book/downloads/rudyard-kipling_the-jungle-book.epub"

# Alice's Adventures in Wonderland (Lewis Carroll) — Standard Ebooks
dl "$SOURCES/literature/alices-adventures-in-wonderland.epub" \
   "https://standardebooks.org/ebooks/lewis-carroll/alices-adventures-in-wonderland/downloads/lewis-carroll_alices-adventures-in-wonderland.epub"

# Winnie-the-Pooh (A.A. Milne, 1926) — entered US PD 2022
# TODO: SE may not have this yet; verify https://standardebooks.org/ebooks/a-a-milne/winnie-the-pooh
# Fallback: search Project Gutenberg for the 1926 text
dl "$SOURCES/literature/winnie-the-pooh.epub" \
   "https://standardebooks.org/ebooks/a-a-milne/winnie-the-pooh/downloads/a-a-milne_winnie-the-pooh.epub"

# Aesop's Fables (Jacobs trans.) — PG #21
dl "$SOURCES/literature/aesops-fables.html" \
   "https://www.gutenberg.org/files/21/21-h/21-h.htm"

# The Arabian Nights (Andrew Lang, 1898) — PG #1264
dl "$SOURCES/literature/arabian-nights-lang.html" \
   "https://www.gutenberg.org/files/1264/1264-h/1264-h.htm"

# Scouting for Boys (Baden-Powell, 1908) — PG #65993
dl "$SOURCES/literature/scouting-for-boys.html" \
   "https://www.gutenberg.org/files/65993/65993-h/65993-h.htm"

# ── SURVIVAL / MEDICAL / REFERENCE ───────────────────────────────────────────
# Military manuals and medical references are served as PDFs (see RATIONALE.md —
# these are scanned documents; HTML conversion produces unreadable output).
echo "=== Survival (PDFs) ==="

# FM 21-76 Survival (US Army) — Public Domain (US Gov)
dl "$SOURCES/survival/fm-21-76-survival.pdf" \
   "https://archive.org/download/milmanual-fm-21-76-survival/milmanual-fm-21-76-survival.pdf"

# AFH 10-644 Survival (US Air Force) — Public Domain (US Gov)
# TODO: verify archive.org ID for AFH 10-644
dl "$SOURCES/survival/afh-10-644-survival.pdf" \
   "https://archive.org/download/AFH10-644/AFH10-644.pdf"

# TC 3-25.26 Map Reading and Land Navigation (US Army) — Public Domain (US Gov)
# TODO: verify archive.org ID
dl "$SOURCES/survival/tc-3-25-26-map-reading.pdf" \
   "https://archive.org/download/TC3-25.26/TC3-25.26.pdf"

# SOF Medical Handbook (US DoD) — Public Domain (US Gov)
# TODO: verify archive.org ID — search "Special Operations Forces Medical Handbook"
dl "$SOURCES/survival/sof-medical-handbook.pdf" \
   "https://archive.org/download/SOFMedicalHandbook/SOF%20Medical%20Handbook.pdf"

# Are You Ready? (US FEMA) — Public Domain (US Gov)
dl "$SOURCES/survival/fema-are-you-ready.pdf" \
   "https://www.ready.gov/sites/default/files/2020-03/ready_are-you-ready-guide.pdf"

# CERT Basic Training Participant Manual (US FEMA) — Public Domain (US Gov)
# TODO: FEMA changes these URLs frequently; verify current URL at community.fema.gov
dl "$SOURCES/survival/fema-cert-basic-training.pdf" \
   "https://community.fema.gov/ProtectiveActions/api/download?Id=a1Bt0000000TNJHEA4&lang=en"

# MCRP 3-40.3C Antenna Handbook (USMC) — Public Domain (US Gov)
# TODO: verify archive.org ID
dl "$SOURCES/survival/mcrp-3-40-3c-antenna-handbook.pdf" \
   "https://archive.org/download/MCRP3-40.3C/MCRP3-40.3C.pdf"

# Boatswain's Mate Manual (US Navy) — Public Domain (US Gov)
# TODO: verify URL — multiple editions exist on archive.org
dl "$SOURCES/survival/boatswains-mate-manual.pdf" \
   "https://archive.org/download/NavyBoatswainsMateManual/NavyBoatswainsMateManual.pdf"

# Basic Machines and How They Work (US Navy NRTC) — Public Domain (US Gov)
dl "$SOURCES/survival/basic-machines-navy.pdf" \
   "https://archive.org/download/basic_machines_and_how_they_work/basic_machines_and_how_they_work.pdf"

# NEETS Modules 1–4 and 18 (US Navy) — Public Domain (US Gov)
# TODO: verify archive.org ID pattern — NEETS has 24 modules; we include selected set
for module in 01 02 03 04 18; do
  dl "$SOURCES/survival/neets-module-${module}.pdf" \
     "https://archive.org/download/NEETS_Module_${module}/NEETS_Module_${module}.pdf"
done

# Excreta Disposal for Rural Areas (Wagner & Lanoix, WHO 1958) — Public Domain
# WHO publications from 1958 are in the public domain (copyright expired).
# TODO: verify WHO IRIS URL
dl "$SOURCES/survival/excreta-disposal-wagner-lanoix.pdf" \
   "https://apps.who.int/iris/bitstream/handle/10665/41687/WHO_MONO_39.pdf"

# On the Mode of Communication of Cholera (John Snow, 1855) — Public Domain
# TODO: verify PG ID — searching for "Snow cholera" at gutenberg.org
dl "$SOURCES/survival/cholera-john-snow.html" \
   "https://www.gutenberg.org/files/28507/28507-h/28507-h.htm"

# CD3WD — see RATIONALE.md. Selected PDFs must be downloaded manually.
# The CD3WD collection is available at https://cd3wd.com/ and archive.org
# Place chosen PDFs in sources/survival/ with prefix cd3wd- before running build.
echo ""
echo "  NOTE: CD3WD PDFs require manual selection."
echo "        Download from https://cd3wd.com/ and place in $SOURCES/survival/"
echo "        Use filenames starting with 'cd3wd-' (e.g. cd3wd-water-purification.pdf)"

echo ""
echo "=== Download complete. Check WARN lines above for failures. ==="

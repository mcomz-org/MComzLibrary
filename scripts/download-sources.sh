#!/bin/bash
# scripts/download-sources.sh
# Downloads all CORE source texts for MComzLibrary.
# Usage: ./scripts/download-sources.sh [--force]
#
# Idempotent: skips files that already exist unless --force is passed.
# Failed downloads are skipped cleanly — the build proceeds with whatever
# was successfully downloaded, and failures are written to download-failures.txt
# for review (and surfaced in the GitHub Actions job summary).

set -uo pipefail

SOURCES="${MCOMZ_SOURCES_DIR:-sources}"
FORCE="${1:-}"
FAILURES=()

mkdir -p \
  "$SOURCES/spiritual" \
  "$SOURCES/literature" \
  "$SOURCES/survival"

# Download helper — skips if file exists, records failures, never leaves partial files.
dl() {
  local dest="$1" url="$2" label="${3:-}"
  [[ "$FORCE" != "--force" && -f "$dest" ]] && { echo "  skip  $(basename "$dest")"; return; }
  echo "  fetch $(basename "$dest")"
  if wget -q --show-progress -O "$dest.tmp" "$url" 2>&1; then
    mv "$dest.tmp" "$dest"
  else
    rm -f "$dest.tmp"
    local note="${label:+ — ${label}}"
    FAILURES+=("$(basename "$dest")${note}")
    echo "  FAIL  $(basename "$dest") — $url" >&2
  fi
}

# ── SCRIPTURES ────────────────────────────────────────────────────────────────
echo "=== Scriptures ==="

# Berean Standard Bible — CC0 (public domain dedication 30 Apr 2023)
# Modern English, Protestant 66-book canon. Does not include the Apocrypha
# (see World English Bible below for the Ecumenical/Deuterocanonical edition).
dl "$SOURCES/spiritual/berean-standard-bible.epub" \
   "https://bereanbible.com/bsb.epub"

# King James Version — PG #10 — Public Domain
dl "$SOURCES/spiritual/king-james-version.html" \
   "https://www.gutenberg.org/files/10/10-h/10-h.htm"

# World English Bible, Ecumenical Edition (with Apocrypha/Deuterocanon) — Public Domain
# Modern English translation including the Catholic/Orthodox Deuterocanonical books
# (Tobit, Judith, Wisdom, Sirach, Baruch, 1–2 Maccabees, etc.). Published by ebible.org.
# Covers the ~50% of world Christianity (Catholic + Orthodox) whose canon is not fully
# represented by the Protestant 66-book BSB or KJV.
dl "$SOURCES/spiritual/world-english-bible-with-apocrypha.epub" \
   "https://ebible.org/epub/eng-web.epub"

# The Book of Mormon (1830 ed.) — PG #17 — Public Domain
# Latter-day Saints: ~17 million adherents globally (~0.25% of world). Pew classifies
# LDS under "Christians" but the BoM is a distinct scripture. Included because it meets
# all three criteria: single primary scripture, PD English source, >0.1% of world.
dl "$SOURCES/spiritual/book-of-mormon.html" \
   "https://www.gutenberg.org/files/17/17-h/17-h.htm"

# The Book of Enoch / 1 Enoch (R.H. Charles trans., 1912) — PG #77935 — Public Domain
# Canonical scripture of Ethiopian Orthodox Christianity (~50 million adherents); not
# included in the Catholic/Orthodox Deuterocanon that the WEB Ecumenical Edition carries.
# Influenced Second Temple Judaism and early Christianity.
dl "$SOURCES/spiritual/book-of-enoch-charles.html" \
   "https://www.gutenberg.org/files/77935/77935-h/77935-h.htm"

# The Quran — PG #16955 (Yusuf Ali, Pickthall, and Shakir translations side by side)
# Includes the Yusuf Ali 1934 text alongside two other respected translations.
dl "$SOURCES/spiritual/quran-three-translations.html" \
   "https://www.gutenberg.org/cache/epub/16955/pg16955-images.html"

# Bhagavad Gita — "The Song Celestial" (Sir Edwin Arnold trans.) — PG #2388
dl "$SOURCES/spiritual/bhagavad-gita-arnold.html" \
   "https://www.gutenberg.org/files/2388/2388-h/2388-h.htm"

# The Upanishads (F. Max Müller trans., Sacred Books of the East) — PG #3283 — Public Domain
# The foundational Hindu śruti tier. Classical Hindu theology regards the Upanishads as
# more central than the Gita; the Gita is more widely read, so both are included.
dl "$SOURCES/spiritual/upanishads-muller.html" \
   "https://www.gutenberg.org/cache/epub/3283/pg3283-images.html"

# Tao Te Ching (James Legge trans.) — PG #216
dl "$SOURCES/spiritual/tao-te-ching-legge.html" \
   "https://www.gutenberg.org/files/216/216-h/216-h.htm"

# JPS Tanakh 1917 — hosted by the Jewish Publication Society (public domain)
# PDF (not available as HTML from a reliable public source)
dl "$SOURCES/spiritual/tanakh-jps-1917.pdf" \
   "https://jps.org/wp-content/uploads/2015/10/Tanakh1917.pdf"

# The Dhammapada (F. Max Müller trans., 1881) — PG #2017 — Public Domain
# Representative text for Buddhism (~7% of world, per Pew 2010). Müller's translation
# is archaic but definitively PD; will be upgraded to Buddharakkhita translation once
# BPS grants permission (see docs/RATIONALE.md Action Items).
dl "$SOURCES/spiritual/dhammapada-muller.html" \
   "https://www.gutenberg.org/cache/epub/2017/pg2017-images.html"

# The Analects of Confucius (James Legge trans.) — PG #3330 — Public Domain
# Central text of the Confucian ethical tradition that underpins Chinese folk
# religion (~6% of world, per Pew 2010) alongside Buddhism and Taoism.
dl "$SOURCES/spiritual/analects-of-confucius-legge.html" \
   "https://www.gutenberg.org/cache/epub/3330/pg3330-images.html"

# ── LITERATURE ────────────────────────────────────────────────────────────────
echo "=== Literature ==="

# The Complete Works of William Shakespeare — PG #100
dl "$SOURCES/literature/shakespeare-complete-works.html" \
   "https://www.gutenberg.org/files/100/100-h/100-h.htm"

# The Adventures of Sherlock Holmes (Conan Doyle) — Standard Ebooks
dl "$SOURCES/literature/sherlock-holmes.epub" \
   "https://standardebooks.org/ebooks/arthur-conan-doyle/the-adventures-of-sherlock-holmes/downloads/arthur-conan-doyle_the-adventures-of-sherlock-holmes.epub"

# The Count of Monte Cristo (Dumas, Chapman and Hall trans.) — Standard Ebooks
dl "$SOURCES/literature/count-of-monte-cristo.epub" \
   "https://standardebooks.org/ebooks/alexandre-dumas/the-count-of-monte-cristo/chapman-and-hall/downloads/alexandre-dumas_the-count-of-monte-cristo_chapman-and-hall.epub"

# Pride and Prejudice (Jane Austen) — Standard Ebooks
dl "$SOURCES/literature/pride-and-prejudice.epub" \
   "https://standardebooks.org/ebooks/jane-austen/pride-and-prejudice/downloads/jane-austen_pride-and-prejudice.epub"

# Frankenstein (Mary Shelley, 1818) — Standard Ebooks
dl "$SOURCES/literature/frankenstein.epub" \
   "https://standardebooks.org/ebooks/mary-shelley/frankenstein/downloads/mary-shelley_frankenstein.epub"

# Jane Eyre (Charlotte Brontë, 1847) — Standard Ebooks
dl "$SOURCES/literature/jane-eyre.epub" \
   "https://standardebooks.org/ebooks/charlotte-bronte/jane-eyre/downloads/charlotte-bronte_jane-eyre.epub"

# Wuthering Heights (Emily Brontë, 1847) — Standard Ebooks
dl "$SOURCES/literature/wuthering-heights.epub" \
   "https://standardebooks.org/ebooks/emily-bronte/wuthering-heights/downloads/emily-bronte_wuthering-heights.epub"

# Little Women (Louisa May Alcott, 1868) — Standard Ebooks
dl "$SOURCES/literature/little-women.epub" \
   "https://standardebooks.org/ebooks/louisa-may-alcott/little-women/downloads/louisa-may-alcott_little-women.epub"

# Middlemarch (George Eliot, 1871) — Standard Ebooks
dl "$SOURCES/literature/middlemarch.epub" \
   "https://standardebooks.org/ebooks/george-eliot/middlemarch/downloads/george-eliot_middlemarch.epub"

# The Awakening (Kate Chopin, 1899) — Standard Ebooks
dl "$SOURCES/literature/the-awakening.epub" \
   "https://standardebooks.org/ebooks/kate-chopin/the-awakening/downloads/kate-chopin_the-awakening.epub"

# Narrative of the Life of Frederick Douglass (1845) — Standard Ebooks
dl "$SOURCES/literature/narrative-of-the-life-of-frederick-douglass.epub" \
   "https://standardebooks.org/ebooks/frederick-douglass/narrative-of-the-life-of-frederick-douglass/downloads/frederick-douglass_narrative-of-the-life-of-frederick-douglass.epub"

# Up from Slavery (Booker T. Washington, 1901) — Standard Ebooks
dl "$SOURCES/literature/up-from-slavery.epub" \
   "https://standardebooks.org/ebooks/booker-t-washington/up-from-slavery/downloads/booker-t-washington_up-from-slavery.epub"

# The Souls of Black Folk (W.E.B. Du Bois, 1903) — Standard Ebooks
dl "$SOURCES/literature/the-souls-of-black-folk.epub" \
   "https://standardebooks.org/ebooks/w-e-b-du-bois/the-souls-of-black-folk/downloads/w-e-b-du-bois_the-souls-of-black-folk.epub"

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

# Alice's Adventures in Wonderland (Lewis Carroll, ill. John Tenniel) — Standard Ebooks
dl "$SOURCES/literature/alices-adventures-in-wonderland.epub" \
   "https://standardebooks.org/ebooks/lewis-carroll/alices-adventures-in-wonderland/john-tenniel/downloads/lewis-carroll_alices-adventures-in-wonderland_john-tenniel.epub"

# Winnie-the-Pooh (A.A. Milne, 1926) — entered US PD 2022
# TODO: verify SE has published this yet; may still fail
dl "$SOURCES/literature/winnie-the-pooh.epub" \
   "https://standardebooks.org/ebooks/a-a-milne/winnie-the-pooh/downloads/a-a-milne_winnie-the-pooh.epub" \
   "TODO: verify SE has Winnie-the-Pooh (entered US PD 2022)"

# Aesop's Fables (Jacobs trans.) — PG #21
dl "$SOURCES/literature/aesops-fables.html" \
   "https://www.gutenberg.org/files/21/21-h/21-h.htm"

# The Arabian Nights (Andrew Lang, 1898) — PG #128
dl "$SOURCES/literature/arabian-nights-lang.html" \
   "https://www.gutenberg.org/files/128/128-h/128-h.htm"

# Scouting for Boys (Baden-Powell, 1908) — PG #65993
dl "$SOURCES/literature/scouting-for-boys.html" \
   "https://www.gutenberg.org/files/65993/65993-h/65993-h.htm"

# Rubáiyát of Omar Khayyám (FitzGerald, 1859) — PG #246
dl "$SOURCES/literature/rubaiyat-of-omar-khayyam.html" \
   "https://www.gutenberg.org/cache/epub/246/pg246-images.html"

# The Art of War (Sun Tzu, Lionel Giles trans., 1910) — Standard Ebooks
dl "$SOURCES/literature/the-art-of-war.epub" \
   "https://standardebooks.org/ebooks/sun-tzu/the-art-of-war/lionel-giles/downloads/sun-tzu_the-art-of-war_lionel-giles.epub"

# Shakuntala (Kalidasa, Arthur W. Ryder trans.) — PG #16659
dl "$SOURCES/literature/shakuntala.html" \
   "https://www.gutenberg.org/cache/epub/16659/pg16659-images.html"

# 170 Chinese Poems (Arthur Waley, 1918) — PG #42290
dl "$SOURCES/literature/170-chinese-poems.html" \
   "https://www.gutenberg.org/cache/epub/42290/pg42290-images.html"

# West African Folk Tales (Barker & Sinclair, 1917) — PG #66923
dl "$SOURCES/literature/west-african-folk-tales.html" \
   "https://www.gutenberg.org/cache/epub/66923/pg66923-images.html"

# Panchatantra (Arthur W. Ryder trans., 1925) — PD in US since 2021
# TODO: URL not yet confirmed — not found on PG; needs archive.org search
# dl "$SOURCES/literature/panchatantra.html" \
#    "TODO"

# ── SURVIVAL / MEDICAL / REFERENCE ───────────────────────────────────────────
# Military manuals and medical references are served as PDFs (see RATIONALE.md —
# these are scanned documents; HTML conversion produces unreadable output).
echo "=== Survival (PDFs) ==="

# FM 21-76 Survival (US Army, 1992 edition) — Public Domain (US Gov)
dl "$SOURCES/survival/fm-21-76-survival.pdf" \
   "https://ia801604.us.archive.org/28/items/Fm21-76SurvivalManual/FM21-76_SurvivalManual.pdf"

# AFH 10-644 Survival/SERE (US Air Force, 2017 edition) — Public Domain (US Gov)
dl "$SOURCES/survival/afh-10-644-survival.pdf" \
   "https://ia601805.us.archive.org/1/items/AFH10644SurvivalEvasionResistanceEscapeSERE/AFH%2010-644%20Survival%20Evasion%20Resistance%20Escape%20SERE%20.pdf"

# FM 3-25.26 Map Reading and Land Navigation (US Army, 2001) — Public Domain (US Gov)
# Note: superseded by TC 3-25.26 (2013) but 2001 edition is available as a single file.
dl "$SOURCES/survival/fm-3-25-26-map-reading.pdf" \
   "https://ia801503.us.archive.org/10/items/milmanual-fm-3-25.26-map-reading-and-land-navigation/fm_3-25.26_map_reading_and_land_navigation.pdf"

# SOF Medical Handbook (US DoD, 2001 edition) — Public Domain (US Gov)
dl "$SOURCES/survival/sof-medical-handbook.pdf" \
   "https://archive.org/download/SOFMH2001/SOFMH2001.pdf"

# Are You Ready? (US FEMA, 2021 edition) — Public Domain (US Gov)
dl "$SOURCES/survival/fema-are-you-ready.pdf" \
   "https://www.ready.gov/sites/default/files/2021-11/are-you-ready-guide.pdf"

# CERT Basic Training Participant Manual (US FEMA, 2019 edition) — Public Domain (US Gov)
dl "$SOURCES/survival/fema-cert-basic-training.pdf" \
   "https://www.ready.gov/sites/default/files/2019.CERT_.Basic_.PM_FINAL_508c.pdf"

# MCRP 3-40.3C Antenna Handbook (USMC, 2001 edition) — Public Domain (US Gov)
dl "$SOURCES/survival/mcrp-3-40-3c-antenna-handbook.pdf" \
   "https://archive.org/download/MCRP3-403C/MCRP3-403C.pdf"

# Boatswain's Mate Manual (US Navy NAVEDTRA 14343A) — Public Domain (US Gov)
dl "$SOURCES/survival/boatswains-mate-manual.pdf" \
   "https://navytribe.com/wp-content/uploads/2015/11/navedtra-14343a.pdf"

# Basic Machines and How They Work (US Navy NAVEDTRA 14037, 1994) — Public Domain (US Gov)
dl "$SOURCES/survival/basic-machines-navy.pdf" \
   "https://www.constructionknowledge.net/public_domain_documents/Div_1_General/Basic_Skills/Basic%20Machines%20NAVEDTRA%2014037%201994.pdf"

# NEETS Modules 1–4 and 18 (US Navy) — Public Domain (US Gov)
# Source: maritime.org (San Francisco Maritime National Historical Park NEETS archive)
dl "$SOURCES/survival/neets-module-01.pdf" "https://maritime.org/doc/neets/mod01.pdf"
dl "$SOURCES/survival/neets-module-02.pdf" "https://maritime.org/doc/neets/mod02.pdf"
dl "$SOURCES/survival/neets-module-03.pdf" "https://maritime.org/doc/neets/mod03.pdf"
dl "$SOURCES/survival/neets-module-04.pdf" "https://maritime.org/doc/neets/mod04.pdf"
dl "$SOURCES/survival/neets-module-18.pdf" "https://maritime.org/doc/neets/mod18.pdf"

# FM 4-25.11 First Aid (US Army, 2002) — Public Domain (US Gov)
# Comprehensive illustrated first aid; most chapters fully applicable to civilians
dl "$SOURCES/survival/fm-4-25-11-first-aid.pdf" \
   "https://archive.org/download/FM4-25.11/FM4-25.11.pdf"

# The Ship's Medicine Chest and Medical Aid at Sea (US PHS, 2003) — Public Domain (US Gov)
# Prolonged medical care for non-doctors — fills the gap between first aid and the SOF Handbook
dl "$SOURCES/survival/ships-medicine-chest.pdf" \
   "https://archive.org/download/gov.law.usphs.ships.2003/usphs.ships.2003.pdf"

# Ship Captain's Medical Guide 22nd ed. (UK MCA/HMSO, 1999) — Crown Copyright, OGL v3.0
# Was published on GOV.UK under OGL; OGL is perpetual and irrevocable. Complements Ship's Medicine Chest.
# TODO: URL not yet confirmed — archived 22nd ed. PDF needs to be located
# dl "$SOURCES/survival/ship-captains-medical-guide-22nd.pdf" \
#    "TODO"

# EPA Emergency Disinfection of Drinking Water (US EPA) — Public Domain (US Gov)
# Two-page quick reference covering bleach, calcium hypochlorite, and iodine disinfection methods
dl "$SOURCES/survival/epa-emergency-disinfection.pdf" \
   "https://www.epa.gov/sites/default/files/2017-09/documents/emergency_disinfection_of_drinking_water_sept2017.pdf"

# CDC Making Water Safe in an Emergency — Public Domain (US Gov)
# TODO: URL not yet confirmed — CDC PDF URL needs verification
# dl "$SOURCES/survival/cdc-making-water-safe.pdf" \
#    "TODO"

# HSE INDG347 Basic First Aid at Work (UK HSE) — Crown Copyright / OGL v3.0
# Two-page quick-reference card: CPR, bleeding, burns, fractures
dl "$SOURCES/survival/hse-indg347-first-aid.pdf" \
   "https://www.hse.gov.uk/pubns/indg347.pdf"

# USDA Complete Guide to Home Canning (2015 rev.) — Public Domain (US Gov)
# TODO: URL not yet confirmed — NCHFP page did not reveal direct PDF download URLs
# dl "$SOURCES/survival/usda-complete-guide-canning.pdf" \
#    "TODO"

# CD3WD — Selected PDFs must be downloaded manually (see RATIONALE.md).
# Place chosen PDFs in sources/survival/ with prefix cd3wd- before running build.
echo "  note  CD3WD: place manually selected PDFs in $SOURCES/survival/ as cd3wd-*.pdf"

# ── Summary ───────────────────────────────────────────────────────────────────
echo ""
if [[ ${#FAILURES[@]} -eq 0 ]]; then
  echo "=== All downloads succeeded ==="
  rm -f download-failures.txt
else
  echo "=== ${#FAILURES[@]} download(s) failed ==="
  printf '%s\n' "${FAILURES[@]}" | tee download-failures.txt
  echo ""
  echo "Build will proceed with successfully downloaded files."
  echo "Fix URLs in scripts/download-sources.sh and re-run, or run with --force."
fi

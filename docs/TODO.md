# MComzLibrary — In-flight

Last updated 2026-04-22.

## Immediate
- **Push local commits.** 7 commits on `main` ahead of `origin/main` — intro welcome pages, Scriptures + Literature downloads, build rework, tourniquet correction. Push when ready.
- **Verify CI on new build pipeline.** `scripts/build-zims.sh` now renders intro `.md` → `index.html`. GitHub Actions hasn't run against this yet; confirm `build-zims.yml` still produces valid ZIMs.
- **Exercise expanded downloads end-to-end.** Six new scripture URLs and nine new Standard Ebook URLs since last run. Each verified individually via WebFetch; the full `download-sources.sh` run not yet exercised.

## Survival content audit
- Tourniquet / catastrophic bleeding corrected to current Stop the Bleed / TCCC doctrine (commit `5915b09`).
- Rest of triage (CPR, choking, water, shelter, sanitation) spot-checked against current guidance — no changes needed, not deeply audited.
- **Mental health** section of INTRO_SURVIVAL empty pending Psychological First Aid Guide permission (RATIONALE action item).

## Literature still-sourcing
Four items gated on location or permission (see `docs/intros/INTRO_LITERATURE.md`): Panchatantra (Ryder 1925), Waley's *Monkey* (1942), a condensed Ramayana, Sa'di's *Gulistan*.

## Challenges posted — no outreach plan yet
- Sponsor challenge for $100k CC BY Book Prize — live in INTRO_LITERATURE.md.
- Modern-fiction-author challenge — live in INTRO_LITERATURE.md.

## Open permission requests
Tracked in `docs/RATIONALE.md` (Action Items — Permission Requests). Highest-value: Hesperian (*Where There Is No Doctor* + four companions), BPS (Buddharakkhita Dhammapada), Sphere Handbook, Oxfam WASH, WEDC Guides, Ship Captain's Medical Guide 22nd ed. (UK MCA), CDC *Making Water Safe in an Emergency*, USDA *Complete Guide to Home Canning*.

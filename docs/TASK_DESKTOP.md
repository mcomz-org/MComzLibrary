# Desktop / Cowork Task: Document Refinement & Zotero Workflow

## Context

You are refining the MComzOS offline library documentation. Read `docs/RATIONALE.md` first.

**MComzOS** is an emergency communications OS. The library supports **Sustainable Survival**: *the ability for you and your family to thrive without impacting the ability of others to thrive, now or in the future.*

## Task 1: Proofread and polish RATIONALE.md

Read the entire document and fix:

- Any inconsistencies between sections (e.g. an item listed as CORE in one place but SEEK PERMISSION in another)
- NC items must be consistently shown as excluded from core ZIMs everywhere
- Licence shorthand must match the definitions table at the bottom
- Category naming must be consistent throughout
- The document should read well top-to-bottom for someone encountering the project for the first time
- Check that every Action Item in the table has a corresponding entry in the library tables, and vice versa
- Ensure the Sustainable Survival definition appears early and is referenced consistently

## Task 2: Draft Martin's Zotero workflow

Martin has 7 Zotero collections covering water engineering (~150 items). He needs a workflow to identify which items meet our criteria. Draft a step-by-step guide:

### For Martin:
1. Open Zotero
2. Select each collection in turn
3. Right-click → Export Collection → choose CSV format
4. Save each export with the collection name (e.g. `water-development.csv`, `wastewater.csv`)
5. Combine all CSVs into one file, or keep separate — either works
6. Share the CSV(s) with Claude (via Desktop, Chat, or upload to the repo)

### For Claude (processing the export):
1. Read the CSV(s)
2. For each item, extract: Title, Author, Year, Publisher, URL
3. Web search each item for licence terms (focus on publisher websites and Creative Commons registries)
4. Classify each item as:
   - ✅ **Include** — PD or non-NC open licence, practical, accessible
   - 🟡 **NC but valuable** — NC licence, worth seeking permission
   - ❌ **Exclude** — copyrighted textbook, too technical for laypeople, or not relevant to Sustainable Survival
5. For ✅ and 🟡 items, note: whether the content is genuinely accessible to non-professionals, and what unique practical knowledge it provides that isn't already covered
6. Output as a table in `docs/WATER_ASSESSMENT.md`

### Martin's bias check:
Martin believes most of his library isn't suitable for non-professionals. This may be true for textbooks like Metcalf & Eddy, but the Oxfam WASH resources and WHO publications in his library are specifically designed for non-specialists. The assessment should flag items Martin might be undervaluing because he's so familiar with them that he's forgotten how useful they are to beginners.

## Task 3: If Deep Research findings are available

If `docs/RESEARCH_FINDINGS.md` exists (produced by the Deep Research task), integrate its recommendations into `docs/RATIONALE.md`:

1. Add confirmed new items to the appropriate library tables
2. Update licence entries with verified information
3. Add new Action Items for any new SEEK PERMISSION entries
4. Remove or flag any items the overlap analysis identified as redundant
5. Update the revision history

## Task 4: README review

Review `README.md` for:
- Accuracy against the current RATIONALE.md
- Clear instructions for newcomers
- Welcoming tone for potential contributors
- Any broken or placeholder links that need updating

## Output

Save all changes directly to the repo files. Update the revision history in RATIONALE.md with a v0.0.3 entry.

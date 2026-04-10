# MComzLibrary

Offline knowledge library for [MComzOS](https://github.com/MComz-org/MComzOS) — an emergency communications OS for Raspberry Pi and x86_64 Debian 12.

## What is this?

Three ZIM files containing freely redistributable knowledge for communities without internet access:

| ZIM | Contents |
|---|---|
| `MComz-Scriptures.zim` | Religious and philosophical texts from seven major world traditions |
| `MComz-Literature.zim` | Classic literature for morale, education, and younger readers |
| `MComz-Survival.zim` | Medical, survival, civil defence, engineering, communications, water & sanitation |

MComzOS also downloads **WikiMed Mini** from Kiwix's library as a fourth ZIM.

## Sustainable Survival

*The ability for you and your family to thrive without impacting the ability of others to thrive, now or in the future.*

This library supports that goal. Every text is selected to help communities move from crisis through recovery to long-term self-sufficiency.

## Documentation

- **[Library Rationale](docs/RATIONALE.md)** — Full selection criteria, licence verification, and gap analysis
- **[Deep Research Tasks](docs/TASK_DEEP_RESEARCH.md)** — Gap analysis and licence verification (for Claude Deep Research)
- **[Desktop/Cowork Tasks](docs/TASK_DESKTOP.md)** — Document refinement and Zotero workflow (for Claude Desktop or Cowork)
- **[Code Tasks](docs/TASK_CODE.md)** — ZIM compilation pipeline and repo setup (for Claude Code)
- **[Martin's Water Bibliography](docs/WATER_BIBLIOGRAPHY.md)** — Water engineering source assessment

## Quick start

```bash
# Clone the repo
git clone https://github.com/MComz-org/MComzLibrary.git
cd MComzLibrary

# See what's planned
cat docs/RATIONALE.md

# When ZIM compilation is ready:
# ./scripts/build-zims.sh
```

## Contributing

We warmly welcome contributions, especially:

- **Translations** — Help us produce ZIMs in other languages
- **Regional foraging guides** — Public domain texts for your region
- **Licence verification** — Help us confirm redistribution terms
- **Content suggestions** — Public domain or CC BY/CC BY-SA texts that support Sustainable Survival
- **ZIM compilation** — Help with the build pipeline

Please open an issue to discuss before starting work on a large contribution.

## Licence

The ZIM files produced by this project contain no NC-licensed material, so they can be freely redistributed, remixed, and built upon. Individual source texts retain their original licences (noted in the Rationale).

Repository tooling and documentation: MIT licence.

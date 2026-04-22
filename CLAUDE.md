# CLAUDE.md

Working notes for Claude sessions on this repo. Read first.

## Architecture
- Three ZIMs (Scriptures / Literature / Survival) built from `sources/{spiritual,literature,survival}/` by `scripts/build-zims.sh`.
- Each ZIM's welcome page is `docs/intros/INTRO_<CAT>.md` rendered via pandoc at build time. The intro file is the authoritative contents page — edit it as prose, not the build script.
- Adding a source text = one entry in `scripts/download-sources.sh` + one row in the matching intro's table. Nothing else.
- Scripture category directory is `spiritual/` (legacy); user-facing name is Scriptures.

## Workflow
1. `./scripts/download-sources.sh` — idempotent; fetches PD/CC sources; failures go to `download-failures.txt`.
2. `./scripts/build-zims.sh` — needs `zim-tools` + `pandoc`; outputs to `dist/`.
3. CI: `.github/workflows/build-zims.yml` (Node 24).

## Handover
See [`docs/TODO.md`](docs/TODO.md) for current in-flight items.

## Related docs
- [`docs/RATIONALE.md`](docs/RATIONALE.md) — selection criteria, licence verification, permission-request tracker.
- [`docs/TASK_CODE.md`](docs/TASK_CODE.md) / [`TASK_DEEP_RESEARCH.md`](docs/TASK_DEEP_RESEARCH.md) / [`TASK_DESKTOP.md`](docs/TASK_DESKTOP.md) — per-role task sheets.

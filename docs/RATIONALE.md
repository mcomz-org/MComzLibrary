# MComzOS Offline Library Rationale — v0.0.2

## Purpose

MComzOS is an Ansible-built emergency communications OS for Raspberry Pi (ARM64) and x86_64 Debian 12. It enables communities to maintain communications, access critical knowledge, and support each other when conventional infrastructure is unavailable.

MComzOS provides emergency communications procedures, software, and possibly hardware — alongside a **Sustainable Survival** open source manual.

**Sustainable Survival** is defined as: *the ability for you and your family to thrive without impacting the ability of others to thrive, now or in the future.*

This document defines the offline library component. It is a curated, legally distributable knowledge base designed to help communities move from crisis through recovery to long-term self-sufficiency — without requiring an internet connection.

## How the Library Works

### Three core ZIM files ship with MComzOS

MComzOS includes exactly three ZIM files, built by the MComzLibrary project (`MComz-org/MComzLibrary` on GitHub) and served locally via Kiwix:

| ZIM file | Contents | Estimated size |
|---|---|---|
| `MComz-Spiritual.zim` | Religious and philosophical texts | TBD |
| `MComz-Literature.zim` | Classic literature for morale and education | TBD |
| `MComz-Survival.zim` | Medical, mental health, survival, civil defence, engineering, communications — everything practical | TBD |

These three ZIMs are also published to Kiwix's public library so anyone can download them independently of MComzOS.

### Fourth ZIM: WikiMed Mini

The MComzOS Ansible playbook also downloads **WikiMed Mini** (~400 MB), a pre-built ZIM available from Kiwix's library. This provides first-aid confirmation and drug interaction checks in plain language, without the diagnostic depth of the full 2.2 GB WikiMed. We don't build this ZIM — we download it. Total ZIMs in the Ansible playbook: **four** (three custom-built + one downloaded).

### Recommended additional ZIMs

Users with larger storage (32 GB+ SD cards or USB drives) can add further ZIM files to their Kiwix library. These are **not** built or maintained by the MComzLibrary project — they are existing ZIMs available from Kiwix's library or other sources:

- **WikiMed (full)** (~2.2 GB) — clinical pathology references for trained professionals
- **Wikipedia (English)** (~110 GB) — the complete offline encyclopedia
- **Project Gutenberg** (various sizes) — expanded reading options
- Regional foraging ZIMs (see below)

### Regional ZIMs

Foraging guides are highly region-specific — a plant safe in Scotland may have a toxic lookalike in Australia. Rather than building regional variants of MComzOS (which we won't do until releases are stable at ≥6 month intervals), we plan to produce small regional ZIM files that users can download and add to their library:

- `MComz-Foraging-UK-Europe.zim`
- `MComz-Foraging-NorthAmerica.zim`
- `MComz-Foraging-Australia.zim`
- `MComz-Foraging-Pacific-Tropics.zim`

Each regional ZIM bundles all available public domain foraging texts for that region into a single convenient download. Even small ZIMs (a few MB) are well-supported by Kiwix's infrastructure. The convenience of a single file with unified search justifies the packaging even where a region has only 2–3 available texts.

### Thematic access within MComzOS

The MComzOS dashboard provides thematic navigation across all loaded ZIMs, so users can find content by topic (e.g. "Medical" → "Where There Is No Doctor") regardless of which ZIM file contains it. This is a feature of the MComzOS HTML dashboard, not the ZIM files themselves. The three core ZIMs are a packaging convenience; the user experience is seamless.

### Format strategy

All content in the core ZIMs is served primarily as **HTML** — this is how Kiwix's reader renders content, and it enables full-text search. For the Literature ZIM especially, **EPUB versions can be included alongside the HTML** within the same ZIM file, available as downloads for users who want to transfer books to a dedicated e-reader. ZIM files can contain any file type; Kiwix serves non-HTML files as downloads. This avoids maintaining separate ZIMs for different formats.

For technical manuals with complex diagrams, diagrams should be converted to **SVG** where feasible for clean scaling, or embedded as high-resolution images in HTML pages. Where automated PDF-to-SVG conversion produces poor results, manual editorial cleanup may be needed — this is a pipeline task.

For Kiwix's public library distribution, we may need to produce HTML-only versions of our ZIMs (without bundled EPUBs) if Kiwix has size or format preferences. This is a packaging detail, not an architectural constraint.

## Selection Principles

1. **Supports Sustainable Survival.** Every text must contribute to keeping people alive, healthy, informed, connected, or psychologically resilient in the absence of conventional infrastructure — and must support the transition from crisis to long-term self-sufficiency rather than short-term combat survival.

2. **Freely shareable.** We want everyone to be able to copy, share, and build on this library without restriction. Core (🟢) items must be legally redistributable without fee and without non-commercial clauses, so that communities, charities, and individuals can pass the library on freely. Items with non-commercial restrictions are excluded from the core ZIMs but listed as recommended additions — we actively seek permission from rights holders to include them, and we encourage users to add them to their own Kiwix libraries.

3. **No combat, evasion, or weapons content.** The library maintains a civilian, humanitarian focus consistent with Sustainable Survival — thriving without impacting others' ability to thrive. Military survival manuals are included only where their content addresses universal civilian needs (shelter, water, navigation, first aid). Content focused on combat evasion, prisoner resistance, weapons construction, or military rescue doctrine is excluded — not because such knowledge lacks value, but because it falls outside community-oriented sustainable resilience.

4. **Storage-conscious.** The core OS occupies ~4 GB. The three library ZIMs must fit within realistic SD card headroom (16 GB recommended total). Individual items with very large footprints are recommended as separate user-added ZIMs rather than baked into the core.

5. **Accessible and readable.** If a text is likely to put someone off trying the next one — due to impenetrable archaisms, poor translation quality, or heavy academic prose — it should be replaced with a better alternative or excluded. People in crisis may pick a book at random; every text should reward that choice.

## Geographic and Cultural Balance

This project started in the UK, and the library reflects that origin. The dominance of US government texts is a pragmatic consequence of the US federal government being the world's largest producer of freely redistributable technical literature (works by US government employees are not subject to copyright under 17 USC §105). The UK's Open Government Licence, which enables similar reuse, was only introduced in 2010 (v1.0), updated to v2.0 in 2013 and v3.0 in 2014.

We are actively working to broaden the library's cultural and geographic representation, particularly in literature and practical skills. We warmly welcome contributions — see the Translation and Localisation section below.

The current spiritual texts represent seven major world traditions. The literature selection is heavily Western and English-language. We have added non-Western classics where high-quality, readable public domain translations exist, and we continue to seek more.

## Translation and Localisation

We explicitly invite contributors who would like to help produce other-language variants of our ZIM files. Many of the source texts already exist in multiple translations:

- The spiritual texts exist in dozens of languages
- The Hesperian medical books have been translated into 80+ languages
- US military manuals have some translated editions

The recommended approach is to build **separate ZIMs per language** (e.g. `MComz-Spiritual-ES.zim`, `MComz-Survival-FR.zim`) rather than bundling multiple languages into one ZIM, to keep individual file sizes manageable.

If you would like to contribute a translation or localised ZIM, please open an issue on the MComzLibrary GitHub repository.

## Side-by-Side Translations

For spiritual texts especially, side-by-side presentation of traditional and modern translations — and where possible, the original language text alongside English — adds significant value. The Kiwix HTML viewer supports this layout. Specific plans:

- **Quran**: Arabic text alongside Yusuf Ali English (1934)
- **Tanakh**: Hebrew alongside JPS 1917 English
- **Bhagavad Gita**: Sanskrit alongside Arnold English
- Other texts as original-language digital sources become available

This is a stretch goal for v1.0 of the ZIMs, not a blocker for initial compilation.

---

## Status Key

| Icon | Meaning |
|---|---|
| 🟢 **CORE** | Included in the relevant core ZIM file. Licence confirmed for free redistribution. |
| 🟡 **SEEK PERMISSION** | Included in the free image; permission needed before distributing on pre-loaded hardware. |
| 🟡 **ADD IF [REGION]** | User-downloadable regional ZIM. Not in the core image. |
| 🟡 **SEPARATE ZIM** | Recommended as an additional ZIM the user can download from Kiwix or other sources. Not in the core image. |
| 🔴 **EXCLUDED** | Not included. Reason given. |

---

## The Library

### Spiritual — `MComz-Spiritual.zim`

| Status | Title & Author | Licence | Notes |
|---|---|---|---|
| 🟢 **CORE** | **Berean Standard Bible** | Public Domain (explicitly dedicated 30 Apr 2023) | Modern English translation. No restrictions. |
| 🟢 **CORE** | **King James Version** | Public Domain (copyright expired) | 17th-century English, Textus Receptus tradition. |
| 🟢 **CORE** | **The Quran** *(Abdullah Yusuf Ali, 1934 text)* | Public Domain (expired Pakistan 2002; US via Project Gutenberg #16955) | Use original 1934 text, not 1977 revised edition. Side-by-side Arabic planned. |
| 🟢 **CORE** | **The Bhagavad Gita** *(Sir Edwin Arnold trans.)* | Public Domain (copyright expired) | 19th-century translation. Side-by-side Sanskrit planned. |
| 🟢 **CORE** | **Tao Te Ching** *(James Legge trans.)* | Public Domain (copyright expired) | 19th-century translation. |
| 🟢 **CORE** | **JPS Tanakh (1917)** | Public Domain (copyright expired) | Jewish Publication Society edition. Side-by-side Hebrew planned. |
| 🟡 **SEEK PERMISSION** | **The Dhammapada** *(Acharya Buddharakkhita)* | BPS Free Distribution (no fee may be charged) | Contact BPS (bps@bps.lk) for hardware-bundling permission. |
| 🟡 **SEEK PERMISSION** | **Guru Granth Sahib** *(Dr. Sant Singh Khalsa)* | Permissive Grant (SikhNet; no formal open licence) | Contact SikhNet for written permission. |
| 🟡 **SEEK PERMISSION** | **The Clear Quran** *(Dr. Mustafa Khattab)* | Verify terms (likely copyright) | Contact publisher for redistribution permission. |

### Literature — `MComz-Literature.zim`

All literature items are **Public Domain** via Standard Ebooks or Project Gutenberg unless noted.

| Status | Title & Author | Origin | Notes |
|---|---|---|---|
| 🟢 **CORE** | **Complete Works of William Shakespeare** | English | Standard Ebooks. |
| 🟢 **CORE** | **The Adventures of Sherlock Holmes** *(A.C. Doyle)* | English | Standard Ebooks. Morale and psychological resilience. |
| 🟢 **CORE** | **The Count of Monte Cristo** *(Alexandre Dumas)* | French (PD English trans.) | Standard Ebooks. Morale and psychological resilience. |
| 🟢 **CORE** | **Pride and Prejudice** *(Jane Austen)* | English | Standard Ebooks. Morale and psychological resilience. |
| 🟢 **CORE** | **The Call of the Wild** *(Jack London)* | American | Standard Ebooks. Survival narrative. |
| 🟢 **CORE** | **Meditations** *(Marcus Aurelius)* | Roman (PD English trans.) | Standard Ebooks. Stoic philosophical grounding. |
| 🟢 **CORE** | **Treasure Island** *(R.L. Stevenson)* | Scottish | Standard Ebooks. Morale. |
| 🟢 **CORE** | **The Jungle Book** *(Rudyard Kipling)* | British-Indian | Standard Ebooks. Younger readers. |
| 🟢 **CORE** | **Alice's Adventures in Wonderland** *(Lewis Carroll)* | English | Standard Ebooks. Younger readers. |
| 🟢 **CORE** | **Winnie-the-Pooh** *(A.A. Milne, 1926)* | English | Standard Ebooks. Younger readers. (US PD 2022.) |
| 🟢 **CORE** | **Aesop's Fables** | Greek (PD English trans.) | All ages. |
| 🟢 **CORE** | **The Arabian Nights** *(Andrew Lang, 1898)* | Middle Eastern (PD English) | Non-Western classic. Accessible, entertaining retelling. Project Gutenberg. |
| 🟢 **CORE** | **Scouting for Boys** *(Robert Baden-Powell, 1908)* | British | Public Domain (expired 31 Dec 2011). Project Gutenberg #65993. Practical outdoor skills: fire, shelter, first aid, knots, signalling. British origin. |
| 🟡 **SEPARATE ZIM** | **Project Gutenberg Library** (Top 100 or subsets) | Various | Available from Kiwix. Variable size. |

### Medical — `MComz-Survival.zim`

| Status | Title & Author | Licence | Notes |
|---|---|---|---|
| 🟡 **SEEK PERMISSION** | **Where There Is No Doctor** *(Hesperian)* | Hesperian Open Copyright (NC; digital distribution requires written permission) | Not in core ZIM (NC). Contact permissions@hesperian.org. Users strongly encouraged to add. |
| 🟡 **SEEK PERMISSION** | **Where There Is No Dentist** *(Hesperian)* | Hesperian Open Copyright (same) | Not in core ZIM (NC). Same contact. |
| 🟡 **SEEK PERMISSION** | **Where Women Have No Doctor** *(Hesperian)* | Hesperian Open Copyright (same) | Not in core ZIM (NC). Clinical companion to Where There Is No Doctor, covering women's health in resource-limited settings. Same contact. |
| 🟡 **SEEK PERMISSION** | **A Book for Midwives** *(Hesperian)* | Hesperian Open Copyright (same) | Not in core ZIM (NC). Same contact. |
| 🟡 **SEEK PERMISSION** | **Health Actions for Women** *(Hesperian)* | Hesperian Open Copyright (same) | Not in core ZIM (NC). Same contact. |
| 🟢 **CORE** | **SOF Medical Handbook** *(US DoD)* | Public Domain (US Gov) | Trauma stabilisation and clinical dosages. Note: assumes relatively rapid medevac access — gap exists for prolonged remote care scenarios (5+ days). |
| 🟡 **SEEK PERMISSION** | **WHO Guidelines for Drinking-Water Quality** *(4th ed., WHO)* | CC BY-NC-SA 3.0 IGO | Not in core ZIM (NC). Essential water safety reference. Contact WHO copyright for permission. |
| 🟡 **SEEK PERMISSION** | **Ship Captain's Medical Guide** *(UK MCA, 22nd ed.)* | OGL v3.0 (verify — 22nd ed. was on GOV.UK before withdrawal) | The 23rd/24th editions contain third-party IP and are published by TSO, which explicitly prohibits redistribution. The older 22nd edition was previously freely available under OGL on GOV.UK. **Action:** Source an archived 22nd edition and verify its OGL status. If confirmed, include. This fills a critical gap: the SOF Handbook assumes medevac access; the SCMG is designed for prolonged care at sea without medical professionals. |
| 🟢 **DOWNLOADED** | **WikiMed Mini (English)** | CC BY-SA 4.0 | ~400 MB. Plain-language first aid and drug information. Downloaded by the MComzOS Ansible playbook from Kiwix's library — not built by this project. |
| 🟡 **SEPARATE ZIM** | **WikiMed (English, full)** | CC BY-SA 4.0 | ~2.2 GB. Clinical references for trained professionals. Available from Kiwix. |

### Mental Health — `MComz-Survival.zim`

| Status | Title & Author | Licence | Notes |
|---|---|---|---|
| 🟡 **SEEK PERMISSION** | **Psychological First Aid (PFA) Guide** *(NCTSN/NCPTSD)* | NCTSN Free Redistribution (no fee, no modification, attribution required) | Not in core ZIM (NC). Contact mbrymer@mednet.ucla.edu for permission. |

### Survival — `MComz-Survival.zim`

| Status | Title & Author | Licence | Notes |
|---|---|---|---|
| 🟡 **SEEK PERMISSION** | **Down But Not Out** *(Canadian National Defence, 1978)* | Crown Copyright (Canada) — NC reproduction permitted; commercial requires DND permission; expires end of 2028 | Contact copyright.droitdauteur@forces.gc.ca for bundling permission, or wait for PD (end of 2028). |
| 🟡 **SEEK PERMISSION** | **Basic Cold Weather Training** *(Canadian Military)* | Crown Copyright (Canada) — same terms | Same action. Verify publication date for expiry calculation. |
| 🟢 **CORE** | **FM 21-76 Survival** *(US Army)* | Public Domain (US Gov) | Shelter, water, fire. Illustrated. |
| 🟢 **CORE** | **AFH 10-644** *(US Air Force)* | Public Domain (US Gov) | Biome-specific survival (jungle, desert, arctic, maritime). Complements FM 21-76 with different biomes. |
| 🟢 **CORE** | **TC 3-25.26 Map Reading and Land Navigation** *(US Army)* | Public Domain (US Gov) | Map, compass, celestial navigation without GPS. |

### Civil Defence — `MComz-Survival.zim`

| Status | Title & Author | Licence | Notes |
|---|---|---|---|
| 🟢 **CORE** | **Are You Ready?** *(US FEMA)* | Public Domain (US Gov) | Urban threats, compromised utilities, structural safety. |
| 🟢 **CORE** | **CERT Basic Training** *(US FEMA)* | Public Domain (US Gov) | Community cooperation, search and rescue, triage. |

### Communications — `MComz-Survival.zim`

| Status | Title & Author | Licence | Notes |
|---|---|---|---|
| 🟢 **CORE** | **MCRP 3-40.3C Antenna Handbook** *(USMC)* | Public Domain (US Gov) | Field-expedient wire antenna construction. |

### Rigging — `MComz-Survival.zim`

| Status | Title & Author | Licence | Notes |
|---|---|---|---|
| 🟢 **CORE** | **Boatswain's Mate Manual** *(US Navy)* | Public Domain (US Gov) | Load-bearing knots and structural rigging. |

### Mechanics — `MComz-Survival.zim`

| Status | Title & Author | Licence | Notes |
|---|---|---|---|
| 🟢 **CORE** | **Basic Machines** *(US Navy)* | Public Domain (US Gov) | Fundamental mechanical principles. Diagrams converted to SVG/embedded images for HTML. |

### Electrical — `MComz-Survival.zim`

| Status | Title & Author | Licence | Notes |
|---|---|---|---|
| 🟢 **CORE** | **NEETS Modules (selected: 1–4, 18)** *(US Navy)* | Public Domain (US Gov) | Core modules on electricity, circuits, troubleshooting, batteries. Full 24-module set available as separate download. Diagrams converted to SVG/embedded images. |

### Water and Sanitation — `MComz-Survival.zim`

| Status | Title & Author | Licence | Notes |
|---|---|---|---|
| 🟡 **SEEK PERMISSION** | **WHO Guidelines for Drinking-Water Quality** *(4th ed.)* | CC BY-NC-SA 3.0 IGO | Not in core ZIM (NC). See Medical section. Cross-listed for discoverability. |
| 🟡 **SEEK PERMISSION** | **WHO Guidelines for Safe Use of Wastewater, Excreta and Greywater** *(Vols 1–4)* | CC BY-NC-SA 3.0 IGO (verify) | Not in core ZIM (NC). Covers wastewater reuse in agriculture/aquaculture — critical for long-term Sustainable Survival. |
| 🟡 **SEEK PERMISSION** | **WHO Sanitation Safety Planning** *(2nd ed.)* | CC BY-NC-SA 3.0 IGO (verify) | Not in core ZIM (NC). Systematic approach to managing sanitation risks. |
| 🟡 **SEEK PERMISSION** | **Sphere Handbook** *(4th ed., 2018)* | Verify terms (freely available PDF at spherestandards.org) | Not in core ZIM pending licence check. Definitive humanitarian standards covering WASH, shelter, food, health. **Action:** Check redistribution licence on spherestandards.org. |
| 🟡 **SEEK PERMISSION** | **Oxfam WASH Technical Briefing Notes** (selected set) | Verify Oxfam terms | Not in core ZIM pending licence check. Practical field guides on water treatment, hand-dug wells, spring protection, drainage, sanitation. Available as free PDFs from oxfamwash.org. **Action:** Contact Oxfam to verify redistribution terms for bundling. |
| 🟢 **CORE** | **On the Mode of Communication of Cholera** *(John Snow, 1855)* | Public Domain (copyright expired) | Historic but practically useful text on waterborne disease transmission. Foundational to understanding why water quality matters. |
| 🟢 **CORE** | **Excreta Disposal for Rural Areas and Small Communities** *(Wagner & Lanoix, WHO, 1958)* | Public Domain (copyright expired, 1958 WHO publication) | Practical sanitation guidance for rural communities. Verify PD status given WHO publication. |
| 🟢 **CORE** | **CD3WD selected content** (water purification, basic sanitation, basic construction) | Public Domain / various open | Selected PDFs from CD3WD collection, bundled as-is into the ZIM as downloadable PDFs. The collection consists of scanned 1980s–90s technical documents — programmatic PDF-to-HTML conversion produces unreadable output and manual conversion is not feasible. Kiwix serves non-HTML files as downloads; users open them in their device's PDF viewer. |

*Martin's full water engineering bibliography (7 Zotero collections, ~150 items) has been assessed. Commercial textbooks (Metcalf & Eddy, Twort's, White's Handbook, etc.) are excluded as copyrighted. The WHO publications, Sphere Handbook, and Oxfam WASH resources are the highest-value candidates pending licence verification. See Overnight Instructions for the detailed Zotero workflow.*

### Foraging (Regional ZIMs) — not in core image

| Status | Title & Author | Licence | Region |
|---|---|---|---|
| 🟡 **ADD IF UK/EUROPE** | **Field and Woodland Plants** *(W.S. Furneaux)* | Public Domain (copyright expired) | UK/Europe |
| 🟡 **ADD IF UK/EUROPE** | **The Book of Herbs** | Public Domain (copyright expired) | UK/Europe |
| 🟡 **ADD IF N. AMERICA** | **Useful Wild Plants of the US/Canada** *(C.F. Saunders)* | Public Domain (copyright expired) | North America |
| 🟡 **ADD IF AUSTRALIA** | **Useful Native Plants of Australia** *(J.H. Maiden)* | Public Domain (copyright expired) | Australia |
| 🟡 **ADD IF PACIFIC/TROPICS** | **Emergency Food Plants of the Pacific** *(US War Dept)* | Public Domain (US Gov) | Pacific/Tropics |

### Reference (user-added ZIMs) — not in core image

| Status | Title | Licence | Notes |
|---|---|---|---|
| 🟡 **SEPARATE ZIM** | **Wikipedia (English)** | CC BY-SA 4.0 | ~110 GB. Available from Kiwix. |
| 🟡 **SEPARATE ZIM** | **WikiMed (English, full)** | CC BY-SA 4.0 | ~2.2 GB. Available from Kiwix. |
| 🟡 **SEPARATE ZIM** | **USDA Home Canning Guide** | Public Domain (US Gov) | Requires specific pressure equipment. |

---

## Excluded Items

**Exclusion principles:** Items are excluded due to copyright restrictions, scope misalignment with Sustainable Survival, or hardware constraints.

| Title | Reason |
|---|---|
| **Ship Captain's Medical Guide** *(23rd/24th ed.)* | TSO copyright; contains third-party IP; redistribution explicitly prohibited. 22nd edition being investigated as alternative (see Medical section). |
| **FM 3-05.70 / ATP 3-50.21** *(US Army)* | Combat evasion and military rescue focus. Excluded under Sustainable Survival principles — content serves military extraction scenarios, not community resilience. |
| **SAS Survival Handbook** *(J. Wiseman)* **and similar** | Strictly copyrighted. No redistribution rights. This exclusion applies to all commercially published survival handbooks without explicit open licensing (e.g. Bushcraft 101, Build the Perfect Bug Out Bag, etc.). |
| **"Survivor Library" ZIM** *(Community)* | ~250 GB exceeds hardware limits; rendering issues on low-power ARM devices. |
| **Mathematical / logarithm tables** | MComzOS runs on a computer. Use a calculator. |

---

## Gaps and Future Work

### Known gaps

| Area | Gap | Candidate solutions |
|---|---|---|
| **Prolonged remote medical care** | SOF Handbook assumes medevac access. No current text covers 5+ day isolated medical management. | Ship Captain's Medical Guide (22nd ed. under investigation); WHO emergency surgery guides (licence TBC). |
| **Agriculture and food preservation** | No seed saving, permaculture, or food preservation guides. | USDA Canning Guide (🟡 as separate ZIM); seek PD/CC guides on seed saving and basic agriculture. |
| **Water and sanitation** | Core gap — critical for Sustainable Survival. | WHO GDWQ (🟡 SEEK PERMISSION); CD3WD selections (🟢); Martin's library assessment pending. |
| **Non-Western literature** | Library is heavily Western/Anglophone. | Arabian Nights added. Seeking further PD translations of quality non-Western classics that are accessible and engaging. |
| **Modern literature** | All literature is pre-1930. Very little modern fiction exists under CC0 or equivalent open licences. | Continue monitoring Unglue.it and similar platforms for quality CC-licensed fiction. |
| **Disability accessibility** | No resources for assisting individuals with disabilities in off-grid scenarios. | Seek PD or CC-licensed guides. |
| **Basic first aid (non-military)** | SOF Handbook is written for Special Operations medics. | Scouting for Boys (added) covers basic first aid. Seek a more comprehensive PD civilian first aid text. |

### Open questions

1. **ZIM compilation timing:** Should we compile draft ZIMs now to show rights holders what we're building when seeking permission? (Recommendation: yes — a working prototype is more persuasive than a document.)

2. **Kiwix library hosting for small custom ZIMs:** Kiwix hosts ZIMs of any size. Regional foraging ZIMs and MComzLibrary ZIMs can be submitted to Kiwix's catalog.

3. **CD3WD integration:** Selected CD3WD PDFs will be bundled directly into `MComz-Survival.zim` as downloadable PDF files, without conversion. The collection consists of scanned 1980s–90s documents; automated PDF-to-HTML produces unreadable garbage and manual conversion is not feasible at scale. Kiwix serves bundled non-HTML files as downloads, so users open them in their device's native PDF viewer.

4. **NC licence policy (decided):** NC-licensed items (Hesperian, WHO GDWQ, PFA, etc.) are **excluded from the core ZIMs** to keep the library fully open and freely shareable. They are listed as strongly recommended additions. We are actively seeking unrestricted permission from each rights holder — if granted, the item moves to 🟢 CORE. This means our three custom ZIMs carry no NC-SA inheritance and can be freely redistributed, remixed, and built upon by anyone.

---

## Action Items — Permission Requests

| # | Rights Holder | Items | Contact | Request |
|---|---|---|---|---|
| 1 | **Hesperian Health Guides** | Where There Is No Doctor, Where There Is No Dentist, Where Women Have No Doctor, A Book for Midwives, Health Actions for Women | permissions@hesperian.org | Digital distribution in an offline OS ZIM file (free download + potential hardware). Emphasise humanitarian/non-profit mission. |
| 2 | **Buddhist Publication Society** | The Dhammapada (Buddharakkhita) | bps@bps.lk | Bundling in free OS image and potentially hardware. |
| 3 | **SikhNet / Dr. Sant Singh Khalsa** | Guru Granth Sahib (Khalsa translation) | sikhnet.com contact | Written permission for OS bundling. |
| 4 | **NCTSN** | PFA Field Operations Guide | mbrymer@mednet.ucla.edu | Confirm bundling in free/hardware OS is acceptable. |
| 5 | **DND Canada** | Down But Not Out, Basic Cold Weather Training | copyright.droitdauteur@forces.gc.ca | Commercial redistribution permission. "Down But Not Out" (1978) enters PD end of 2028. |
| 6 | **TSO / UK MCA** | Ship Captain's Medical Guide | customer.services@tso.co.uk | Redistribution permission for 23rd/24th ed. Also: source archived 22nd edition and verify OGL status. |
| 7 | **Al-Furqan / Book of Signs Foundation** | The Clear Quran (Dr. Mustafa Khattab) | theclearquran.org | Redistribution permission for OS bundling. |
| 8 | **WHO** | GDWQ (4th ed.), Wastewater Guidelines (Vols 1–4), Sanitation Safety Planning | who.int/copyright | Confirm non-commercial OS bundling is acceptable for all WHO publications. Single request covering multiple titles. |
| 9 | **Sphere Association** | Sphere Handbook (4th ed.) | spherestandards.org | Verify redistribution licence for OS bundling. |
| 10 | **Oxfam** | WASH Technical Briefing Notes (selected set) | oxfamwash.org or Oxfam GB permissions | Verify redistribution terms for bundling free PDFs in an OS image. |

---

## Disclaimers

> **Medical:** The medical texts in this library are informational resources for use in austere environments. They do not replace professional medical care. Users must follow local laws regarding medical practice.

> **Foraging:** Historical foraging texts may lack modern toxicology standards. Misidentification risk remains even with guides. Users must obtain texts specific to their region and apply local knowledge. **Never forage mushrooms unless trained by a local expert.**

> **General:** All included materials are verified as public domain or licensed for non-commercial redistribution at minimum.

---

## Licence Definitions

| Shorthand | Meaning |
|---|---|
| **Public Domain (CC0)** | Explicitly dedicated to the public domain by the creator via Creative Commons Zero. No restrictions whatsoever. |
| **Public Domain (copyright expired)** | Copyright term has lapsed under applicable law. No restrictions. |
| **Public Domain (US Gov)** | Work of the US federal government, not subject to copyright under 17 USC §105. |
| **OGL v3.0** | UK Open Government Licence v3.0 (introduced 2014). Free to copy, publish, adapt for any purpose including commercial, with attribution. |
| **CC BY-SA 3.0 / 4.0** | Creative Commons Attribution-ShareAlike. Free for any purpose including commercial; derivatives must use same licence. |
| **CC BY-NC-SA 3.0 IGO / 4.0** | Creative Commons Attribution-NonCommercial-ShareAlike. Free for non-commercial use only. Derivatives must use same licence. ⚠️ If included in a ZIM, the ZIM itself inherits the NC-SA restriction. |
| **Hesperian Open Copyright** | Hesperian's bespoke policy: free non-commercial reproduction with attribution; digital distribution, commercial use, or use by organisations with budget >$1M USD requires written permission. Not a standard CC licence. |
| **BPS Free Distribution** | Buddhist Publication Society: free redistribution in any medium, no fee may be charged, attribution and full licence text required. |
| **NCTSN Free Redistribution** | NCTSN/NCPTSD: free to copy and redistribute unmodified with attribution, no fee. Commercial exploitation prohibited. |
| **Crown Copyright (Canada)** | s.12 Copyright Act R.S.C. 1985: non-commercial reproduction permitted without permission; commercial use requires permission. Expires 50 years from first publication. |
| **Permissive Grant** | Copyright held by author/publisher, but explicit permission granted for free redistribution. No standard licence. Verify terms before bundling. |

---

## Revision History

| Version | Date | Changes |
|---|---|---|
| v0.0.1 | 2026-04-10 | Initial draft produced with Gemini 2.5 Pro and Grok review. |
| v0.0.2 | 2026-04-10 | Comprehensive revision incorporating review by ChatGPT, Le Chat (Mistral), DeepSeek, Perplexity, Copilot, and Claude. Licence verification via web research. NC-licensed items policy clarified. Ship Captain's Medical Guide 22nd ed. investigation added. Hesperian licence corrected from "CC BY-NC-SA 4.0" to "Hesperian Open Copyright". Berean Bible confirmed Public Domain. Yusuf Ali Quran clarified to 1934 text. Licence definitions standardised and moved to appendix. Disclaimers added. Category naming standardised. "Morale management" replaced with "psychological resilience". Status labels made self-explanatory. ZIM architecture clarified (three core ZIMs + user-added). Regional ZIM strategy added. Format strategy (HTML-first) documented. Thematic dashboard navigation noted. Geographic balance statement added. Translation/localisation invitation added. Side-by-side translation goal added. Arabian Nights and Scouting for Boys added. WikiMed Mini moved to CORE. CD3WD integration approach clarified. Mathematical tables excluded. Action Items table with contacts. Gaps and future work section. NC licence implications for ZIM licensing noted. Overnight refinement instructions produced. |
| v0.0.3 | 2026-04-10 | Three fixes from Gemini 2.5 Pro review: WikiMed Mini added to Medical table as 🟢 DOWNLOADED (was described in prose but absent from table). CD3WD strategy corrected from "convert to HTML" to "bundle as-is PDF downloads" (scanned 1980s–90s docs; automated conversion produces unreadable output). Where Women Have No Doctor (Hesperian) added to Medical table and Action Items (clinical companion to Where There Is No Doctor; distinct from Health Actions for Women). |

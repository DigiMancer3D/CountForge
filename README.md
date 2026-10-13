<div align="center">
  <img src="assets/countforge-256.png" alt="CountForge: classical columns and jade sigma emblem" width="124" />

# 𝚺 CountForge

### *The calculator is the desk. The ledger remembers.*

**Dockable Calculator-Inventory Desk • Expandable Ledgers & Windows • One Calculation Engine • Offline & Portable**

**v0.3.0-alpha.3 · Public-release candidate · Single-file, local-first HTML**

[**Open the app**](CountForge_v0.3.0-alpha.3.html) · [**Linux desktop setup**](#desktop-installation-linux) · [**Data formats**](#files-that-travel-with-your-inventory) · [**Discovery Museum ↓**](#the-discovery-museum-how-we-got-here)

</div>

---

CountForge is a **calculator-led inventory system**. It is not a stock table with an unrelated pocket calculator. Choose an item, build an exact numerical expression, translate packs/cases/pallets into single units, then create an auditable stock receipt. Keep the calculator floating, dock it alongside the ledger, open its expandable 9×9 item selector, or send live panels to additional browser windows.

> **Alpha notice:** local-first prototype, not a multi-user or encrypted accounting product. The supplied example records are synthetic. Browser and OS behavior can differ, and this build should undergo manual LibreWolf testing before a final public announcement.

![CountForge desktop preview](previews/CountForge_DESKTOP.png)

## ✦ In the forge

| Work surface | What it contributes |
|:--|:--|
| **Exact calculator** | BigInt integer expressions; base conversions (2–109); result-to-stock actions; Pallet / Case / Pack / Single insert keys |
| **Four-point inventory** | Individually configurable pack, case, and pallet capacities; normalized single-unit stock and physical-count variance |
| **Receipt ledger** | Inventory is derived from recorded movements; a correction is a new reversing event rather than silent deletion |
| **Dockable workbench** | Click a **⠿ six-dot handle** to send its in-page column to the **first (top-left) position**; fold columns into bottom folder tabs; float individual desks |
| **Map81 selector** | 9×9 visual item selection; grows with records; more maps appear after 81 items; separate ledgers get separate map pages |
| **Multiple ledgers** | Add named ledgers as needed; tabs appear only when more than one exists |
| **Data editors** | Auto-discovered/category/location/status/SKU/notes filters and user-defined report cards |
| **Portable exchanges** | CSV snapshots, movement CSV, readable metadata-backed PNG+CSV, smallest tested compact machine backups |

### The movement language

- **Click ⠿ on any in-page column:** send it to the **first** desk position—no imprecise drag-and-drop target.
- **Floating panel:** drag its column header to move it; dragging does *not* reorder in-page columns.
- **Calculator ↓ / ↑:** insert it as a page column or pop it out again. Hide it with **×**; the floating **∑ Calculator** FAB returns it.
- **Calculator 9×9 ▸:** open the selected ledger's visual inventory selector beside the calculator. It also works in floating mode.
- **Top action order:** Ledger · 4-Live · 9×9 · Calculator · Smallest backup · Import · External windows.
- **External windows:** click to open/return external workspaces. **Hold for 3.14 seconds** to *add one more* (up to six). Each window has a **Move live panel here** selector. Windows contain transferred live UI elements, not duplicated inventory copies. Popups may require permission and cannot guarantee always-on-top behavior.

On the calculator, toggle **4-point keys** to replace the normal action buttons with **Pallets**, **Cases**, **Packs** and **Singles**. Each key uses the *currently selected item's* configuration; the optional automatic switch-back after `=` is enabled by default.

## Start using it

**Browser-only:** open `CountForge_v0.3.0-alpha.3.html` in LibreWolf, Firefox or Chromium. No server is normally required. You can carry this HTML onto another machine, but the existing browser's data is *not automatically embedded in the HTML*; use a machine backup for transfer.

**Optional local server:** from the app folder run `python -m http.server 8080`, then visit `http://localhost:8080/CountForge_v0.3.0-alpha.3.html`.

### Desktop installation (Linux)

For CachyOS, Arch Linux and other Linux desktops (including KDE Plasma):

```bash
# Enter the extracted CountForge_v0.3.0-alpha.3 folder
bash ./install_linux.sh install
bash ./install_linux.sh status
```

The installer copies the standalone HTML and local launcher into `~/.local/share/countforge/`, registers a CountForge `.desktop` application entry, and installs scalable/raster artwork. No `sudo` required, and no Python runtime is needed for normal launch. Its browser preference is **LibreWolf → Firefox → Chromium variants → xdg-open**. Some browser/Wayland combinations may still show the browser's taskbar icon instead of a dedicated CountForge window icon.

```bash
bash ./install_linux.sh remove
```

Removal deletes the desktop launcher, copied HTML, and icon files. It **does not erase browser-local inventory data**. For environments that discard executable permissions (such as exFAT external disks), always invoke the installer via `bash` as shown.

## Files that travel with your inventory

| Export | Purpose | Can reconstruct receipt history? |
|--|--|:--:|
| `.cfi` / `.cfigz` | Smallest measured machine-readable backup; compare plain/dictionary-indexed JSON and gzip variants | **Yes** |
| `.csv` inventory | Human/Excel/LibreOffice stock snapshot and ledger labels | No; imports as opening quantities |
| `.csv` movements | Chronological audit/receipt data for external analysis | Export only |
| `.png` Image-CSV v2 | Readable inventory report with exact UTF-8 CSV in standard PNG `iTXt` metadata | No; snapshot only |

> **Image-CSV caution:** screenshotting, re-saving, cropping, sharing on platforms that strip metadata or converting the PNG to JPEG may remove the embedded CSV. Keep the original PNG or a separate CSV. Only the machine backup captures full history and report/filter editor settings. **Compression is not encryption.**

**Migrating from CountForge 0.1 or 0.2:** export the **Smallest backup** from the old release, open 0.3, and import the backup. Do not assume two browsers, installed paths or `file://` pages share local storage. The persistent browser data key is kept compatible with previous alphas when the origin matches.

## Reliability, privacy and limitations

CountForge performs calculations entirely locally; the bundled app has no external runtime assets or telemetry. It stores records using `localStorage`, which can be cleared by private browsing settings, site-data deletion or profile changes. Its stock arithmetic is integer-only and uses JavaScript BigInt to avoid floating-point rounding. SKU references are unique across the catalog; map coordinates are view positions, *not* stable record identifiers. An inventory ledger here is a catalog workspace, not a regulated financial ledger.

No account login, cloud synchronization, cryptographic signing, PQCZIP, browser-independent secure vault, permission management, or multi-user transaction lock is implemented. Back up before upgrading and check important counts before committing movements. Desktop integration and popups need real-user acceptance testing on LibreWolf, Firefox, Chromium and Wayland.

## Project layout

```text
CountForge_v0.3.0-alpha.3/
├── CountForge_v0.3.0-alpha.3.html    # complete offline webapp
├── install_linux.sh                 # install / remove / status
├── assets/                          # emblem PNG + SVG, desktop icons
├── examples/                        # synthetic test exports (from 0.2)
├── previews/                        # desktop and mobile screenshots
├── docs/                            # QA, release notes, installation notes
└── README.md                        # this document
```

## Release checklist

- [x] Static HTML built from v0.2 with no cloud dependencies introduced
- [x] Headless Chromium interaction checks for in-page click-to-front, persistent order, floating drag, multi-window hold and live panel transfer
- [x] JavaScript syntax, installer syntax and sandboxed install/remove smoke checks
- [ ] LibreWolf + KDE Wayland manual test: hold gesture, external popup placement, window close/recovery and desktop taskbar icon
- [ ] Backup your own real records and try a restoration before migration
- [ ] Choose a clear repository license/terms before publishing (not yet supplied or implied)

## The Discovery Museum: How We Got Here

*Welcome to a tour through the strange laboratory of ideas that made a calculator grow an inventory desk.* Each gallery honors an **exploration**, not a claim that all its experimental algorithms were copied into this app or validated as production compression.

### 🏛 Gallery I · The old HTML attic — original experiments revisited

The rediscovered archive contained **Bi-Sectional Distribution Model**, **BSDM v2/v3**, **Sovereignty-HUD**, **3D-HUD**, **LSWgen (WIP)**, **Dumb-Runner** and an early **SuPosXt** variant. The influence here was architectural and visual: block-oriented organization, movable HUD surfaces, compact records and the idea that a self-contained HTML file can act as a private workspace. The old files were inspected—not imported or executed as CountForge dependencies. Their large embedded media also reminded us that portability has a real byte cost.

### 🔣 Gallery II · SuPosXt / SPX, transforms and reference patterns

**SuPosXt (SPX)** investigated patterned symbols, base changes, compact expression recipes and reversible transforms. **Binary Transition Transform (BTT)** describes whether successive bits differ, a reversible XOR-delta transform—not secrecy or encryption. Related **TBPR/MRPS** research asked whether a target could be reconstructed from compact references in a weighted field. These ideas motivated careful attention to exact numerical representation and true file-size measurements, but **CountForge's storage does not depend on unproven SPX or MRPS compression gains**.

### 𐄂 Gallery III · The five-piece MicroString Calculator Lab — October 5, 2026

Five individually launchable HTML calculators turned abstractions into experiments: **Carry-First Transition Transform (base 2–109)**, **Three-Slot Mixed-Radix Mapper**, **Grid81 Keyboard Mapper**, **MicroString Recipe Lab**, and the **Unified MicroString Numerical System Lab**. The crucial connection was that a base converter, a grid selector, and a mixed-radix counter could share the same practical input: a selected inventory item.

### ⚒ Gallery IV · Z0M8I3D Calculator Suite v0.2 — October 5, 2026

Seven additional experiments made the connection explicit: **SPX Parity / CFTT Multi-Base**, **MicroString Compression Workbench**, **Three-Point Inventory Mixed-Radix**, **Practical Inventory Calculator**, **Ultimate Basemancy**, **Ultimate Inventory Grid Calculator**, and **PvtPpr MapBoard Calculator Web Replica**. The suite became the bridge between numerical play and useful stock actions. The first MicroString five were preserved alongside the new experiments, not replaced in historical records.

### 🗂 Gallery V · Thresholds and PvtPpr MapBoard / Count Sheet

The separate **Threshold Calculator Prototype**, **PvtPpr Count Sheet preview**, and the **PvtPpr Inventory MapBoard** desktop alphas explored practical stock thresholds, editable fields, sorted grids, selection binding and precise counting. PvtPpr was a separate **Python/PySide6** project with its own architecture; the HTML web replica was an experiment, not a drop-in port. CountForge simplified these ideas into browser-native ledgers and normalized single-unit counts rather than inheriting native Qt code or experimental Crypto.Chess storage bridges.

### 📚 Gallery VI · Neighboring offline catalogs: RoloDesk and LEGOMAP

Independent single-file catalog projects, **RoloDesk** and **LEGOMAP**, reinforced the value of mobile-friendly entry, understandable names, backup/export flows and nontechnical navigation. They are part of the surrounding design journey—**not** dependencies or claims of shared underlying source code.

### ∑ Gallery VII · CountForge finally takes shape — October 12, 2026

**v0.1.0-alpha.1** united exact BigInt arithmetic, customizable Pallet/Case/Pack/Single conversion, a 9×9 map, receipt-backed stock and export experiments. **v0.2.0-alpha.2** added dockable desk columns, growable multiple ledgers, filter/report editors, four-point calculator keys, a readable `iTXt` PNG-CSV design, and an experimental external panel window. **v0.3.0-alpha.3** replaced fragile page-column dragging with the one-click **first-position handle**, added the hidden **π-inspired 3.14-second extra-window gesture**, sharpened desktop integration and introduced a classical column / jade sigma mark.

> **The lesson of the journey:** make the calculator the instrument, the inventory the memory, and every count a recoverable story. ✨

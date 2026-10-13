<div align="center">
  <img src="assets/countforge-256.png" alt="CountForge: classical columns and jade sigma emblem" width="124" />

# 𝚺 CountForge

### *The Calculator with a Ledger & Quick Actions.*

**Dockable Calculator-Inventory Desk • Expandable Ledgers & Windows • One Calculation Engine • Offline & Portable**


[**Open the app**](CountForge_v0.3.0-alpha.3.html) · [**Linux desktop setup**](#desktop-installation-linux) · [**Data formats**](#files-that-travel-with-your-inventory) 

</div>

---

CountForge is a **calculator-based inventory system**. It is not a stock table with an unrelated pocket calculator. Choose an item, build an exact numerical expression, translate packs/cases/pallets into single units, then create an auditable stock receipt. Keep the calculator floating, dock it alongside the ledger, open its expandable 9×9 item selector, or send live panels to additional browser windows.

> **Alpha notice:** local-first prototype, not a multi-user or encrypted accounting product. The supplied example records are synthetic to show usage at startup.

## ✦ In the forge

| Work surface | What it contributes |
|:--|:--|
| **Calculator** | BigInt integer expressions; base conversions (2–109); result-to-stock actions; Pallet / Case / Pack / Single insert keys |
| **Four-point inventory** | Individually configurable pack, case, and pallet capacities; normalized single-unit stock and physical-count variance |
| **Receipt ledger** | Inventory is derived from recorded movements; a correction is a new reversing event rather than silent deletion |
| **Dockable workbench** | Click a **⠿ six-dot handle** to send its in-page column to the **first (top-left) position**; fold columns into bottom folder tabs; float individual desks |
| **Map81 selector** | 9×9 visual item selection; grows with records; more maps appear after 81 items; separate ledgers get separate map pages |
| **Multiple ledgers** | Add named ledgers as needed; tabs appear only when more than one exists |
| **Data editors** | Auto-discovered/category/location/status/SKU/notes filters and user-defined report cards |
| **Portable exchanges** | CSV snapshots, movement CSV, readable metadata-backed PNG+CSV, smallest tested compact machine backups |

### The movement language

- **Click ⠿ on any in-page column:** send it to the **first** desk position, no imprecise drag-and-drop target.
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

> **Image-CSV caution:** screenshotting, re-saving, cropping, sharing on platforms that strip metadata or converting the PNG to JPEG may remove the embedded CSV. Keep the original PNG or a separate CSV. Only the machine backup captures full history and report/filter editor settings. 

## Reliability, privacy and limitations

CountForge performs calculations entirely locally; the bundled app has no external runtime assets or telemetry. It stores records using `localStorage`, which can be cleared by private browsing settings, site-data deletion or profile changes. Its stock arithmetic is integer-only and uses JavaScript BigInt to avoid floating-point rounding. SKU references are unique across the catalog; map coordinates are view positions, *not* stable record identifiers. An inventory ledger here is a catalog workspace, not a regulated financial ledger.

No account login, cloud synchronization, cryptographic signing, PQCZIP, browser-independent secure vault, permission management, or multi-user transaction lock is implemented. Back up before upgrading and check important counts before committing movements. Desktop integration and popups need real-user acceptance testing on LibreWolf, Firefox, Chromium and Wayland.

---


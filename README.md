# English Myanmar Dictionary — ShweWords

Offline-first Flutter dictionary app with SQLite FTS5 search for English ↔ Myanmar lookups.

## Features

- Offline dictionary with FTS5 full-text search
- English autocomplete, Myanmar meaning search, synonym search
- First-launch download from GitHub Releases (gzip + checksum validation)
- Word detail with selectable text, copy, share, favorites
- Recent searches and favorites (Hive)
- Dark mode, Myanmar typography (Noto Sans Myanmar)
- Tablet-friendly wide layout

## Tech Stack

- Flutter + Riverpod
- Drift (read-only SQLite)
- FTS5 with trigram tokenizer
- Dio (resumable download)
- go_router navigation

## Getting Started

### Prerequisites

- Flutter stable (3.11+)
- Xcode / Android Studio for mobile targets

### Install

```bash
cd dictionary
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### Local development (bundled database)

Debug builds copy the bundled database from `assets/dev/dictionary.db` on first launch.

To refresh the bundled asset from the crawler:

```bash
cp ../dictionary_crawler/output/dictionary.db assets/dev/dictionary.db
```

### Run

```bash
flutter run
```

## Dictionary Data Pipeline

The dictionary is built by the sibling [`dictionary_crawler`](../dictionary_crawler) project:

```bash
cd ../dictionary_crawler
PYTHONPATH=. python3 scripts/export_sqlite.py --gzip
```

This produces:

- `output/dictionary.db`
- `output/dictionary.db.gz`
- `output/metadata.json`
- `output/checksum.sha256`

## Dictionary Hosting

The app needs two HTTPS URLs in [`lib/core/config/app_config.dart`](lib/core/config/app_config.dart):

- `metadataUrl` — JSON with version, size, and SHA256 (see crawler `output/metadata.json`)
- `databaseDownloadUrl` — the gzip database file

**GitHub user-attachments** (e.g. from a release or issue upload) work fine; each file has its own URL, so set both constants explicitly:

```dart
static const metadataUrl =
    'https://github.com/user-attachments/files/28405503/metadata.json';
static const databaseDownloadUrl =
    'https://github.com/user-attachments/files/28405504/dictionary.db.gz';
```

**GitHub Releases** (optional): if assets share one folder, you can use
`https://github.com/ORG/REPO/releases/download/v1.0.0/metadata.json` and
`.../dictionary.db.gz` the same way.

The app fetches `metadata.json` first, validates SHA256 after download, decompresses gzip, and runs `PRAGMA integrity_check`.

## Project Structure

```text
lib/
├── core/           # config, theme, router, utils
├── data/           # database, datasources, repositories
├── domain/         # entities, repository interfaces
└── features/       # splash, download, search, detail, history, settings
```

## Search Modes

| Mode | FTS target | Notes |
|------|------------|-------|
| English | `word:query*` | Prefix autocomplete |
| Myanmar | `meanings_my:query` | Trigram partial match |
| Synonym | `synonyms:query*` | Prefix match on synonyms |

## Tests

```bash
flutter test
```

Integration tests use `../dictionary_crawler/output/dictionary.db` when available.

## CI

GitHub Actions workflow at [`.github/workflows/ci.yml`](.github/workflows/ci.yml) runs analyze, tests, and debug APK build.

## App Identity

- **Name:** English Myanmar Dictionary - ShweWords
- **Package:** `com.shwewords.shwewords`
- **Min Android SDK:** 24

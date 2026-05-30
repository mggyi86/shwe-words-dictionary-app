# Flutter Offline Dictionary App — Cursor Plan Mode Prompts

## Overview

Build a production-grade offline Flutter dictionary app with:

- Flutter
- SQLite + FTS5
- Drift or sqflite
- Offline-first architecture
- Multilingual support
- English ↔ Myanmar search
- Future AI-powered features

---

# PHASE 1 — PROJECT ARCHITECTURE

## Prompt 1 — System Architecture Planning

```text
You are a senior Flutter architect.

I want to build a production-grade offline Flutter dictionary app.

Tech stack:
- Flutter
- SQLite
- FTS5
- sqflite or drift
- Offline-first
- No backend server

Main dictionary:
English ↔ Myanmar

Future support:
- German
- French
- Thai
- Japanese
- Multi-language dictionaries

Database:
dictionary.db downloaded as dictionary.db.gz.

Requirements:
1. First launch:
   - check if dictionary.db exists
   - if not:
     - download dictionary.db.gz
     - decompress locally
     - open database

2. Offline search:
   - exact word lookup
   - autocomplete
   - Myanmar search
   - synonym search
   - multilingual support

3. SQLite schema:

TABLE entries (
  id INTEGER PRIMARY KEY,
  word TEXT NOT NULL,
  language TEXT NOT NULL,
  dictionary_slug TEXT,
  data JSON NOT NULL,
  UNIQUE(word, language)
)

VIRTUAL TABLE entries_fts USING fts5(
  word,
  meanings_my,
  examples_en,
  synonyms,
  language UNINDEXED,
  tokenize='trigram'
)

entries_fts.rowid joins entries.id

4. JSON structure:
{
  "word": "water",
  "language": "en",
  "dictionary_slug": "english",
  "definitions": [
    {
      "pos": "noun",
      "meanings": ["ရေ"],
      "examples": []
    }
  ],
  "synonyms": ["H2O"]
}

Please create:
- scalable folder structure
- clean architecture
- feature modules
- repository pattern
- local database layer
- search service design
- download manager design
- state management recommendation
- performance optimization plan
- offline-first strategy
- multilingual strategy
- FTS5 strategy
- large database handling strategy

Do NOT generate code yet.

First provide:
1. High-level architecture
2. Folder structure
3. Recommended packages
4. Data flow
5. Search flow
6. Database initialization flow
7. Future scalability considerations
```

---

# PHASE 2 — PACKAGE SETUP

## Prompt 2 — Generate Flutter Dependencies

```text
Now generate the pubspec.yaml dependencies for the architecture.

Requirements:
- Flutter stable
- sqflite or drift (recommend best choice)
- dio or http
- path_provider
- archive/gzip decompression
- riverpod or bloc
- freezed/json_serializable if useful
- sqlite FTS5 compatible

Also explain:
- why each package is chosen
- performance considerations
- Android/iOS compatibility
```

---

# PHASE 3 — DATABASE DESIGN

## Prompt 3 — SQLite + FTS5 Database Layer

```text
Generate the complete SQLite database layer.

Requirements:
- use drift if better for large projects
- support external prebuilt database
- open existing dictionary.db
- support FTS5 queries
- support exact search
- support autocomplete
- support Myanmar partial search
- support synonym search
- support language filtering

Need:
1. Database service
2. Connection management
3. Query APIs
4. FTS5 query methods
5. Exact lookup methods
6. Pagination support
7. Error handling
8. Performance optimizations

Important:
- database is prebuilt externally
- app does NOT create tables
- app only reads/searches
- must support large databases efficiently

Also explain:
- why trigram tokenizer is useful for Myanmar
- limitations of FTS5 with Myanmar
- possible normalization strategies
```

---

# PHASE 4 — DOWNLOAD + GZIP SYSTEM

## Prompt 4 — Dictionary Download Manager

```text
Create a production-grade dictionary download system.

Requirements:
1. On first launch:
   - check if dictionary.db exists
   - if not:
     - download dictionary.db.gz
     - show progress
     - resume if interrupted
     - decompress
     - validate DB
     - delete gzip after extraction

2. Future:
   - support dictionary updates
   - version checking
   - multiple dictionaries

Need:
- clean architecture
- service classes
- repository layer
- progress stream
- retry handling
- cancellation support
- checksum validation
- decompression implementation
- disk space considerations

Use:
- dio
- path_provider
- archive package

Also generate:
- download state model
- UI state flow
- error recovery strategy
```

---

# PHASE 5 — SEARCH ENGINE

## Prompt 5 — Advanced Search System

```text
Build the search engine layer.

Requirements:

Search types:
1. Exact lookup
SELECT data FROM entries WHERE word=? AND language=?

2. English autocomplete
FTS MATCH on word

3. Myanmar search
FTS MATCH on meanings_my

4. Myanmar autocomplete/prefix search

5. Synonym search
FTS MATCH on synonyms

6. Multi-language filtering

Need:
- repository APIs
- search ranking strategy
- debounce strategy
- pagination
- isolate/background processing if useful
- optimized SQL queries
- query sanitization
- prefix matching
- typo tolerance ideas
- result prioritization

Also explain:
- best FTS5 MATCH syntax
- trigram tokenizer behavior
- how to improve Myanmar search quality
- future semantic search possibilities
```

---

# PHASE 6 — DATA MODELS

## Prompt 6 — Generate Models

```text
Generate all Dart models.

Need:
- Entry model
- Definition model
- Example model
- Synonym model
- Download status model
- Search result model

Requirements:
- immutable models
- JSON serialization
- freezed if useful
- clean domain entities
- mapper layers if needed

Also generate:
- sample parsing code
- validation logic
```

---

# PHASE 7 — STATE MANAGEMENT

## Prompt 7 — Riverpod Architecture

```text
Build scalable Riverpod architecture for the app.

Need:
- providers
- repository providers
- database providers
- search controller
- download controller
- initialization controller
- caching strategy
- async loading states
- error states

Requirements:
- production-grade
- testable
- modular
- future-proof
```

---

# PHASE 8 — UI/UX DESIGN

## Prompt 8 — Flutter UI Architecture

```text
Design modern dictionary app UI.

Screens:
1. Splash/init screen
2. Download screen
3. Home search screen
4. Search results
5. Word detail page
6. History/favorites
7. Settings

Requirements:
- multilingual-ready
- responsive
- dark mode
- tablet support
- fast search UX
- keyboard optimized
- offline indicators

Need:
- widget tree structure
- reusable components
- sliver usage
- lazy loading
- performance optimization
- accessibility support

Do NOT generate final code yet.
First generate UI architecture plan.
```

---

# PHASE 9 — SEARCH UI IMPLEMENTATION

## Prompt 9 — Search Screen Implementation

```text
Generate production-grade Flutter search screen.

Requirements:
- realtime search
- debounce
- search suggestions
- recent searches
- search by:
  - English
  - Myanmar
  - synonym
- loading states
- empty states
- error states
- smooth scrolling
- optimized rebuilds

Use:
- Riverpod
- clean architecture
- best Flutter performance practices
```

---

# PHASE 10 — WORD DETAIL PAGE

## Prompt 10 — Dictionary Entry Detail UI

```text
Generate dictionary detail page.

Display:
- word
- pronunciation placeholder
- language
- parts of speech
- meanings
- examples
- synonyms

Requirements:
- beautiful typography
- Myanmar font rendering considerations
- selectable text
- copy support
- favorites support
- share support
- expandable sections
- optimized rendering
```

---

# PHASE 11 — DATABASE EXPORT PIPELINE

## Prompt 11 — External SQLite Builder

```text
Create external dictionary database generation pipeline.

Input:
- JSON dictionary files

Output:
- dictionary.db
- dictionary.db.gz

Requirements:
- generate entries table
- generate FTS5 table
- populate meanings_my
- populate examples_en
- populate synonyms
- optimize indexes
- WAL considerations
- compression optimization

Need:
- Python scripts OR Dart scripts
- bulk insert optimization
- transaction batching
- validation
- duplicate handling
- normalization strategy

Also explain:
- best way to preprocess Myanmar text
- trigram tokenizer optimization
- database size optimization
```

---

# PHASE 12 — PERFORMANCE OPTIMIZATION

## Prompt 12 — Scalability + Optimization Audit

```text
Audit the entire architecture for performance.

Target:
- 100k–1M+ dictionary entries

Need analysis:
1. SQLite performance
2. FTS5 performance
3. memory usage
4. startup speed
5. decompression speed
6. query latency
7. pagination strategy
8. isolate usage
9. caching strategy
10. Android low-memory behavior
11. iOS considerations

Also recommend:
- PRAGMA settings
- SQLite tuning
- indexing improvements
- lazy loading improvements
- search optimization
```

---

# PHASE 13 — PRODUCTION RELEASE

## Prompt 13 — Production Release Preparation

```text
Prepare the app for production release.

Need:
- Android optimizations
- iOS optimizations
- app size reduction
- obfuscation
- database protection
- crash reporting
- analytics
- CI/CD suggestions
- GitHub Actions
- Firebase App Distribution

Also include:
- Play Store considerations
- App Store considerations
- offline-first UX considerations
```

---

# IMPORTANT FTS5 NOTE

```text
IMPORTANT:
This app uses SQLite FTS5 virtual tables.

Do NOT use LIKE '%query%' searches.

Use proper FTS5 MATCH queries.

Database is prebuilt externally.

App only reads/searches data.

FTS table:
entries_fts(rowid, word, meanings_my, examples_en, synonyms, language)

entries_fts.rowid = entries.id

Use optimized MATCH queries and JOIN with entries.
```

---

# IMPORTANT MYANMAR SEARCH NOTE

```text
Myanmar language search must support:
- partial matching
- prefix matching
- no-space text patterns

Prefer:
tokenize='trigram'

Consider:
- normalized Myanmar text
- alternate spellings
- Unicode normalization
- Zawgyi/Unicode conversion strategy

Search quality is more important than exact linguistic correctness.
```

---

# RECOMMENDED STACK

| Layer | Recommendation |
|---|---|
| DB | SQLite + FTS5 |
| ORM | Drift |
| State | Riverpod |
| HTTP | Dio |
| Compression | archive |
| Models | freezed |
| Architecture | Clean Architecture |

---

# ADVANCED FUTURE PROMPTS

## AI-powered Search

```text
How can we later add:
- semantic search
- embeddings
- typo correction
- transliteration search
- phonetic search
- AI explanations
- OCR dictionary lookup
- camera translate

without breaking current architecture?
```

---

## Dictionary Update System

```text
Design scalable dictionary update system.

Requirements:
- delta updates
- patch downloads
- versioned dictionaries
- multiple dictionary packs
- language pack installation
- rollback support
```
App Name Will be - English Myanmar Dictionary - ShweWords

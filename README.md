# PI Research Assistant

An AI-powered private investigation research assistant that compiles thorough background reports on people and organizations using open-source intelligence (OSINT) techniques.

Built for use with [Claude Code](https://claude.com/claude-code).

## How It Works

1. Provide a subject name and location (person) or organization name.
2. The assistant dispatches parallel research agents to search public records, news, corporate filings, social media, and more.
3. Findings are compiled into a professional PDF report using a [Typst](https://typst.app/) template.

## Project Structure

```
CLAUDE.md              # Agent instructions and research methodology
report-template.typ    # Typst report template with cover page, styling, and utility components
```

## Requirements

- [Claude Code](https://claude.com/claude-code) CLI
- [Typst](https://typst.app/) (`typst` CLI) for PDF compilation

### Install Typst

```bash
# macOS
brew install typst

# Linux (cargo)
cargo install typst-cli

# Or download from https://github.com/typst/typst/releases
```

## Usage

From this directory, start Claude Code and provide your research request:

```
claude

> Run a background report on Jane Doe in Austin, TX
```

The assistant will:
- Search multiple public data sources in parallel
- Cross-reference findings across sources
- Generate a `.typ` report file and compile it to PDF
- Deliver the PDF with an executive summary

## Report Features

- Professional cover page with subject details
- Table of contents
- Numbered sections with inline source citations
- Color-coded finding callouts (info, concern, red-flag, positive)
- Information gap tracking
- Confidence assessment
- Standard legal disclaimer

## Template Components

The `report-template.typ` provides these components for use in reports:

| Component | Description |
|-----------|-------------|
| `report(subject, subject-type, date, case-ref)` | Main document template |
| `finding(severity)[content]` | Highlighted finding box (`info`, `concern`, `red-flag`, `positive`) |
| `source-note(url, label)` | Inline citation link |
| `gap-note[content]` | Marks missing information |
| `timeline-entry(date, description)` | Formatted timeline row |

## Research Sources

The assistant searches across many public source categories including:

- **Professional**: LinkedIn, company websites, press releases
- **Corporate filings**: State SOS databases, SEC EDGAR, OpenCorporates
- **Public records**: Court records, property records, liens, judgments
- **Media**: News articles, interviews, press coverage
- **Digital footprint**: Social media, GitHub, personal websites
- **Licenses & credentials**: State licensing portals, professional associations
- **Nonprofit**: IRS 990 filings via ProPublica Nonprofit Explorer

## Limitations

- Uses only publicly available information
- Cannot access paywalled databases (PACER, LexisNexis, etc.) — these are flagged for manual follow-up
- Social media platforms with login walls are searched via snippets only
- Common names may require additional identifiers for disambiguation

// Private Investigation Background Report Template
// Usage: Import this template in your report file — do not copy its contents. See examples at the bottom.

#let report(
  subject: "",
  subject-type: "Person", // "Person" or "Organization"
  date: datetime.today().display("[month repr:long] [day], [year]"),
  case-ref: "",
  body,
) = {
  assert(subject != "", message: "subject is required")
  assert(subject-type in ("Person", "Organization"), message: "subject-type must be 'Person' or 'Organization'")
  set document(title: "Background Report: " + subject)
  set page(
    paper: "us-letter",
    margin: (top: 1.2in, bottom: 1in, left: 1in, right: 1in),
    header: context {
      if counter(page).get().first() > 1 [
        #set text(8pt, fill: luma(120))
        #grid(
          columns: (1fr, 1fr),
          align: (left, right),
          [CONFIDENTIAL — Background Report: #subject],
          if case-ref != "" [#case-ref],
        )
        #line(length: 100%, stroke: 0.5pt + luma(180))
      ]
    },
    footer: context {
      set text(8pt, fill: luma(120))
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [Prepared #date],
        [Page #counter(page).display("1 of 1", both: true)],
      )
    },
  )
  set text(font: "New Computer Modern", size: 10.5pt)
  set par(justify: true, leading: 0.65em)
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    v(0.8em)
    block(
      width: 100%,
      below: 0.6em,
      {
        set text(13pt, weight: "bold")
        it
        v(-0.3em)
        line(length: 100%, stroke: 0.8pt + luma(100))
      },
    )
  }

  show heading.where(level: 2): set text(11pt, weight: "bold")
  show heading.where(level: 3): set text(10.5pt, weight: "bold", style: "italic")

  // --- Cover / Title Block ---
  v(1.5in)
  align(center)[
    #block(
      width: 85%,
      inset: 1.5em,
      stroke: 1.5pt + luma(60),
      radius: 2pt,
      {
        set text(fill: luma(30))
        text(10pt, tracking: 0.15em, upper[Confidential])
        v(0.6em)
        text(22pt, weight: "bold", subject)
        v(0.4em)
        text(12pt)[Background Investigation Report]
        v(0.3em)
        line(length: 60%, stroke: 0.5pt + luma(150))
        v(0.3em)
        text(10pt)[Subject Type: #subject-type]
        v(0.2em)
        text(10pt)[Date: #date]
        if case-ref != "" {
          v(0.2em)
          text(10pt)[Reference: #case-ref]
        }
      },
    )
  ]
  v(1in)

  pagebreak()

  // --- Table of Contents ---
  heading(numbering: none, outlined: false)[Table of Contents]
  outline(indent: 1.5em, depth: 3)

  pagebreak(weak: true)

  body
}

// --- Utility components ---

#let finding(severity: "info", body) = {
  let colors = (
    info: (bg: rgb("#e8f4f8"), border: rgb("#2196F3")),
    concern: (bg: rgb("#fff3e0"), border: rgb("#FF9800")),
    red-flag: (bg: rgb("#ffebee"), border: rgb("#F44336")),
    positive: (bg: rgb("#e8f5e9"), border: rgb("#4CAF50")),
  )
  let c = colors.at(severity, default: colors.info)
  block(
    width: 100%,
    inset: 0.8em,
    fill: c.bg,
    stroke: (left: 3pt + c.border),
    radius: (right: 2pt),
    body,
  )
}

#let source-note(url, label: none) = {
  let display = if label != none { label } else { url }
  text(8pt, fill: luma(100))[(Source: #link(url)[#display])]
}

#let gap-note(body) = {
  block(
    width: 100%,
    inset: 0.6em,
    fill: luma(245),
    stroke: (left: 2pt + luma(180)),
    radius: (right: 2pt),
    {
      text(style: "italic")[#sym.quest.double Gap: #body]
    },
  )
}

#let timeline-entry(date, description) = {
  block(below: 0.4em,
    grid(
      columns: (8em, 1fr),
      column-gutter: 1em,
      text(weight: "bold", date),
      description,
    )
  )
}

// ============================================================
// HOW TO USE THIS TEMPLATE
// ============================================================
// In your report file, import and use like this:
//
//   #import "report-template.typ": report, finding, source-note, gap-note, timeline-entry
//
//   #show: report.with(
//     subject: "Subject Name",
//     subject-type: "Person",  // or "Organization"
//     date: "March 15, 2026",
//     case-ref: "CASE-2026-001",  // optional
//   )
//
//   = Executive Summary
//   ...
//
// Available components:
//   - finding(severity: "info"|"concern"|"red-flag"|"positive")[content]
//   - source-note("https://url") or source-note("https://url", label: "display text")
//   - gap-note[description of missing information]
//   - timeline-entry([date range], [description])

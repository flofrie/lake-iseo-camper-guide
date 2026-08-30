// Lake Iseo brochure-style Typst template for Quarto.
// Based on Quarto 1.10's default Typst article partial (MIT licensed),
// with publication styling tailored to this guide.

#let lake = rgb("#0b7285")
#let deep = rgb("#084c57")
#let sand = rgb("#f6eee0")
#let sun = rgb("#d48b3f")
#let ink = rgb("#263238")
#let rule = rgb("#dbe6e8")

#let article(
  title: none,
  subtitle: none,
  authors: none,
  keywords: (),
  date: none,
  abstract-title: none,
  abstract: none,
  thanks: none,
  cols: 1,
  lang: "en",
  region: "US",
  font: none,
  fontsize: 10pt,
  title-size: 1.5em,
  subtitle-size: 1.25em,
  heading-family: none,
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: deep,
  heading-line-height: 0.72em,
  mathfont: none,
  codefont: none,
  linestretch: 1.1,
  sectionnumbering: none,
  linkcolor: none,
  citecolor: none,
  filecolor: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.4em,
  doc,
) = {
  set document(title: title, keywords: keywords)
  set document(
    author: authors.map(author => content-to-string(author.name)).join(", ", last: " & "),
  ) if authors != none and authors != ()

  set par(justify: true, leading: linestretch * 0.68em)
  set text(lang: lang, region: region, size: fontsize, fill: ink)
  set text(font: font) if font != none
  show math.equation: set text(font: mathfont) if mathfont != none
  show raw: set text(font: codefont) if codefont != none
  set heading(numbering: sectionnumbering)

  show link: set text(fill: rgb(content-to-string(linkcolor))) if linkcolor != none
  show ref: set text(fill: rgb(content-to-string(citecolor))) if citecolor != none
  show link: this => {
    if filecolor != none and type(this.dest) == label {
      text(this, fill: rgb(content-to-string(filecolor)))
    } else {
      text(this)
    }
  }

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    block(
      width: 100%,
      above: 0.5em,
      below: 1.15em,
      inset: (top: 4pt, bottom: 5pt),
      stroke: (top: 3pt + lake),
    )[
      #text(size: 18pt, weight: "bold", fill: deep)[#it.body]
    ]
  }

  show heading.where(level: 2): it => block(
    width: 100%,
    above: 2.4em,
    below: 1.05em,
  )[
    #text(size: 12.5pt, weight: "bold", fill: lake)[#it.body]
  ]

  show heading.where(level: 3): it => block(
    above: 1.6em,
    below: 0.9em,
  )[
    #text(size: 10.5pt, weight: "bold", fill: deep)[#it.body]
  ]

  show quote: it => block(
    width: 100%,
    fill: sand,
    stroke: (left: 2.5pt + sun),
    inset: (left: 11pt, right: 9pt, top: 7pt, bottom: 7pt),
    radius: (right: 7pt),
    above: 0.7em,
    below: 0.8em,
  )[
    #set text(fill: rgb("#3f4f54"))
    #it.body
  ]

  let has-title-block = title != none or (authors != none and authors != ()) or date != none or abstract != none

  if has-title-block {
    block(
      width: 100%,
      height: 112mm,
      fill: deep,
      radius: 10pt,
      inset: (left: 25pt, right: 25pt, top: 28pt, bottom: 24pt),
    )[
      #set text(fill: white)
      #set par(justify: false, leading: 0.78em)

      #text(size: 10pt, weight: "bold", fill: rgb("#bfe7e9"))[
        PERSONALISED TRAVEL GUIDE
      ]
      #v(17pt)

      #if title != none {
        text(size: 34pt, weight: "bold")[#title]
      }
      #if subtitle != none {
        parbreak()
        v(5pt)
        text(size: 17pt, weight: "regular", fill: rgb("#d8f1f2"))[#subtitle]
      }

      #v(1fr)
      #line(length: 100%, stroke: 2pt + sun)
      #v(8pt)

      #grid(
        columns: (1fr, auto),
        align: (left, right),
        [#text(size: 9.5pt)[Camper Van · Lakefront Camping · SUP Rental]],
        [#if date != none { text(size: 9.5pt, weight: "bold")[#date] }],
      )
    ]
    pagebreak()
  }

  if toc {
    block(width: 100%, below: 1.2em)[
      #text(size: 19pt, weight: "bold", fill: deep)[Contents]
      #v(6pt)
      #line(length: 100%, stroke: 1pt + sun)
      #v(10pt)
      #outline(title: none, depth: toc_depth, indent: toc_indent)
    ]
    pagebreak()
  }

  doc
}

#set table(
  inset: (x: 5pt, y: 4pt),
  stroke: (x: none, y: 0.45pt + rule),
)

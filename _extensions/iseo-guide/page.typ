#set page(
  paper: $if(papersize)$"$papersize$"$else$"a4"$endif$,
$if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$else$
  margin: (x: 17mm, y: 18mm),
$endif$
  numbering: $if(page-numbering)$"$page-numbering$"$else$"1"$endif$,
  columns: 1,
  header: context {
    if counter(page).get().first() > 1 {
      align(right)[
        #text(size: 7pt, fill: rgb("#60747b"))[
          LAKE ISEO  ·  CAMPER + SUP GUIDE
        ]
      ]
    }
  },
)

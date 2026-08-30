QUARTO ?= quarto

.PHONY: all html pdf preview clean

all: html pdf

html:
	$(QUARTO) render guide.qmd --to html

pdf:
	$(QUARTO) render guide.qmd --to iseo-guide-typst

preview:
	$(QUARTO) preview guide.qmd --to html

clean:
	rm -rf _output .quarto

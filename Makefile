.DEFAULT_GOAL := all

TEXINPUTS = TEXINPUTS="template/:`kpsewhich -var-value TEXINPUTS`"
TEX = $(TEXINPUTS) xelatex
BIB = biber
NAME = cv
NAME_BR = cv-br

.PHONY: pdf bib all clean

pdf: cv.tex cv-br.tex
	$(TEX) $(NAME)
	$(TEX) $(NAME_BR)

bib: cv.tex cv-br.tex bibliography.bib
	$(BIB) $(NAME)
	$(BIB) $(NAME_BR)

clean:
	/usr/bin/env bash scripts/clean.sh $(NAME)

all: 
	make pdf && make bib && make pdf


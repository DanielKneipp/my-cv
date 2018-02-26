.DEFAULT_GOAL := all

TEXINPUTS = TEXINPUTS="template/:`kpsewhich -var-value TEXINPUTS`"
TEX = $(TEXINPUTS) xelatex
BIB = biber
NAME = cv


.PHONY: pdf bib all clean

pdf: cv.tex
	$(TEX) $(NAME)

bib: cv.tex bibliography.bib
	$(BIB) $(NAME)

clean:
	/usr/bin/env bash scripts/clean.sh $(NAME)

all: 
	make pdf && make bib && make pdf


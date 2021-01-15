.DEFAULT_GOAL := all

TEXINPUTS = TEXINPUTS="template/:`kpsewhich -var-value TEXINPUTS`"
TEX = $(TEXINPUTS) xelatex
BIB = biber
NAME = cv
NAME_BR = cv-br

.PHONY: pdf bib all clean docker-build docker-run

pdf: cv.tex cv-br.tex
	$(TEX) $(NAME)
	$(TEX) $(NAME_BR)

bib: cv.tex cv-br.tex bibliography.bib
	$(BIB) $(NAME)
	$(BIB) $(NAME_BR)

docker-build:
	docker build -t danielkneipp/xelatex .

docker-run:
	docker run --rm -v $(shell pwd):/data danielkneipp/xelatex make $(TARGETS)

clean:
	/usr/bin/env bash scripts/clean.sh $(NAME)

all: 
	make pdf && make bib && make pdf


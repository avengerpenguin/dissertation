.PHONY: pdf

pdf: report.pdf

report.pdf: $(shell find . -iname '*.tex' | grep -v '#') diagrams/component.png diagrams/usecase.png diagrams/component.png diagrams/component2.png
	pdflatex -halt-on-error -shell-escape -interaction=nonstopmode report.tex || (which notify-send && notify-send "PDF build failed")
	bibtex report.aux	
	pdflatex -halt-on-error -shell-escape -interaction=nonstopmode report.tex
	pdflatex -halt-on-error -shell-escape -interaction=nonstopmode report.tex
	which notify-send && notify-send "PDF build successful" || true
	(which mupdfwrap && mupdfwrap report.pdf) || (which open && open report.pdf) || true

diagrams/%.png: diagrams/%.puml
	plantuml -pipe <$< >$@

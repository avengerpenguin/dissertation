.PHONY: pdf

pdf: report.pdf

report.pdf: report.tex diagrams/component.png
	pdflatex -halt-on-error -shell-escape -interaction=nonstopmode report.tex
	bibtex report.aux	
	pdflatex -halt-on-error -shell-escape -interaction=nonstopmode report.tex
	pdflatex -halt-on-error -shell-escape -interaction=nonstopmode report.tex

diagrams/%.png: diagrams/%.puml
	plantuml -pipe <$< >$@

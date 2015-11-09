.PHONY: pdf

pdf: report.pdf

report.pdf: report.tex
	pdflatex -halt-on-error -shell-escape -interaction=nonstopmode report.tex

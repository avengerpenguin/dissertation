.PHONY: pdf

pdf: paper.pdf

paper.pdf: paper.tex
	pdflatex -halt-on-error -shell-escape -interaction=nonstopmode paper.tex || (which notify-send && notify-send "PDF build failed")
	bibtex paper.aux	
	pdflatex -halt-on-error -shell-escape -interaction=nonstopmode paper.tex
	pdflatex -halt-on-error -shell-escape -interaction=nonstopmode paper.tex
	which notify-send && notify-send "PDF build successful"
	which mupdfwrap && mupdfwrap paper.pdf

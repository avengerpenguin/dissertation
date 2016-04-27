.PHONY: pdf

pdf: paper.pdf

paper.pdf: paper.tex sig-alternate-05-2015.cls acmcopyright.sty
	pdflatex -halt-on-error -shell-escape -interaction=nonstopmode paper.tex || (which notify-send && notify-send "PDF build failed")
	bibtex paper.aux || true
	pdflatex -halt-on-error -shell-escape -interaction=nonstopmode paper.tex
	pdflatex -halt-on-error -shell-escape -interaction=nonstopmode paper.tex
	which notify-send && notify-send "PDF build successful"
	which mupdfwrap && mupdfwrap paper.pdf

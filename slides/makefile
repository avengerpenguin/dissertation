.PHONY: pdf

pdf: slides.pdf

slides.pdf: slides.tex
	pdflatex -halt-on-error -shell-escape -interaction=nonstopmode slides.tex || (which notify-send && notify-send "Slides PDF build failed")
	which notify-send && notify-send "Slides PDF build successful" || true
	which mupdfwrap && mupdfwrap slides.pdf || true
	which open && open slides.pdf || true

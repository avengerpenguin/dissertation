pdf: out/report.pdf

out/report.pdf: report.tex
	mkdir -p out
	pdflatex -halt-on-error -shell-escape -output-directory=out report.tex

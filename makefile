.PHONY: report proposal watch default github paper slides

default: github

slides:
	cd slides && $(MAKE)

paper:
	cd paper && $(MAKE)

report: paper
	cd report && $(MAKE)

proposal:
	cd proposal && $(MAKE)

bin/guard: Gemfile
	bundle install --path bundle
	bundle binstub guard

watch: bin/guard
	bin/guard

venv/bin/pip:
	virtualenv -p python2 venv

venv/bin/pip-sync venv/bin/pip-compile: venv/bin/pip
	venv/bin/pip install --upgrade pip
	venv/bin/pip install pip-tools ez_setup

requirements.txt: requirements.in venv/bin/pip-compile
	venv/bin/pip-compile requirements.in

venv/pip.touch: venv/bin/pip-sync requirements.txt
	venv/bin/pip-sync && touch $@

out/report.pdf: report
	mkdir -p out
	cp report/report.pdf out/report.pdf

out/paper.pdf: paper
	mkdir -p out
	cp paper/paper.pdf out/paper.pdf

out/slides.pdf: slides
	mkdir -p out
	cp slides/slides.pdf out/slides.pdf

github: out/report.pdf out/paper.pdf venv/pip.touch out/slides.pdf
	venv/bin/ghp-import -n -p out

count:
	@echo "Word counts:"
	@echo "Chapter 1: `sh wordcount.sh report/chapters/01-*.tex`\t/   500 -   750"
	@echo "Chapter 2: `sh wordcount.sh report/chapters/02-*.tex`\t/  1500 -  2250"
	@echo "Chapter 3: `sh wordcount.sh report/chapters/03-*.tex`\t/  2500 -  3750"
	@echo "Chapter 4: `sh wordcount.sh report/chapters/04-*.tex`\t/  2500 -  3750"
	@echo "Chapter 5: `sh wordcount.sh report/chapters/05-*.tex`\t/  2500 -  3750"
	@echo "Chapter 6: `sh wordcount.sh report/chapters/06-*.tex`\t/   500 -   750"
	@echo "Chapter 7: `sh wordcount.sh report/chapters/07-*.tex`\t/   500 -   750"
	@echo "Total    : `sh wordcount.sh report/report.tex report/chapters/*.tex`/ 10000 - 15000"

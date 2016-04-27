.PHONY: report proposal watch default github paper

default: github

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

github: out/report.pdf out/paper.pdf venv/pip.touch
	venv/bin/ghp-import -n -p out

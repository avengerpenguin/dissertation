.PHONY: report proposal watch default github

default: github

report:
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

github: out/report.pdf venv/pip.touch
	venv/bin/ghp-import -n -p out

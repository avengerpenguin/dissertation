.PHONY: report proposal watch default

default: proposal report

report:
	cd report && $(MAKE)

proposal:
	cd proposal && $(MAKE)

bin/guard: Gemfile
	bundle install --path bundle
	bundle binstub guard

watch: bin/guard
	bin/guard

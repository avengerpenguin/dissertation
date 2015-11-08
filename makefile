.PHONY: report proposal watch

report:
	cd report && $(MAKE)

proposal:
	cd proposal && $(MAKE)

bundle/up2date: Gemfile
	bundle install --path bundle
	touch bundle/up2date

watch: bundle/up2date
	bundle exec guard

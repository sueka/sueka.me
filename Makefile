BUNDLE      := bundle
JEKYLL      := $(BUNDLE) exec jekyll
RSPEC       := $(BUNDLE) exec rspec
RUBOCOP     := $(BUNDLE) exec rubocop
HTMLPROOFER := $(BUNDLE) exec htmlproofer

sources = $(shell find source -type f)
specs = $(shell find spec -type f)

.DEFAULT_GOAL = build

.PHONY : build source-check check serve prepare clean clobber

build : _site
_site : vendor/bundle $(sources)
	$(JEKYLL) build

source-check : vendor/bundle $(sources) $(specs)
	$(RUBOCOP)
	$(RSPEC) --exclude-pattern spec/browser/**/*.rb

check : vendor/bundle _site $(specs)
	$(HTMLPROOFER) _site/ --disable-external --check-html --log-level :warn
	$(RSPEC) --pattern spec/browser/**/*.rb

serve : vendor/bundle
	$(JEKYLL) serve

prepare : vendor/bundle
vendor/bundle : Gemfile Gemfile.lock
	$(BUNDLE) install --path $@

clean :
	rm -rf .sass-cache
	rm -rf _site

clobber :
	rm -rf .sass-cache
	rm -rf _site
	rm -rf vendor/bundle
	rmdir vendor

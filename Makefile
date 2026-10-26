.PHONY: demo serve build clean

demo:
	./build-demo.sh

serve:
	@if [ -f Gemfile ] && command -v bundle >/dev/null 2>&1; then bundle exec jekyll serve; \
	elif command -v jekyll >/dev/null 2>&1; then jekyll serve; \
	else echo "Error: Jekyll is not installed." >&2; exit 1; fi

build:
	@if [ -f Gemfile ] && command -v bundle >/dev/null 2>&1; then bundle exec jekyll build; \
	elif command -v jekyll >/dev/null 2>&1; then jekyll build; \
	else echo "Error: Jekyll is not installed." >&2; exit 1; fi

clean:
	rm -rf _site .jekyll-cache .jekyll-metadata

.PHONY: build clean publish setup watch

build:
	@bundle exec middleman build

publish: build
	@aws --profile personal s3 sync ./build/ s3://joshbassett.info/ --acl public-read --delete --cache-control 'max-age=300'

clean:
	@rm -rf build

setup:
	@bundle install

watch:
	@./bin/middleman

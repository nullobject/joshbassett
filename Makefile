.PHONY: build clean publish setup start

build:
	@bundle exec middleman build

publish: build
	@aws s3 sync ./build/ s3://joshbassett.info/ --acl public-read --delete --cache-control 'max-age=300'

clean:
	@rm -rf build

setup:
	@bundle install

start:
	@./bin/middleman

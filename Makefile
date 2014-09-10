.PHONY: build clean publish setup watch

build:
	@bundle exec middleman build

publish: build
	@s3cmd sync -H -P --delete-removed --add-header='Cache-Control:max-age=300' ./build/ s3://joshbassett.info/

clean:
	@rm -rf build

setup:
	@bundle install

watch:
	@bundle exec middleman

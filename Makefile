start:
	@middleman

all: build sync

build:
	@middleman build

sync:
	@middleman sync

clean:
	@rm -rf build

.PHONY: clean sync

OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')

CWD=$(shell pwd)

# https://github.com/whosonfirst/go-whosonfirst-exportify#wof-as-featurecollection
AS_FEATURECOLLECTION=$(shell which wof-as-featurecollection)

current:
	mkdir -p work
	$(AS_FEATURECOLLECTION) \
		-iterator-uri 'repo://?include=properties.mz:is_current=1' \
		$(CWD) > work/exhibition.geojson

x:
	wof-exportify -s data -i $(ID)

prune:
	git gc --aggressive --prune=now
	git repack -Adf --depth=50 --window-memory=100m

rm-empty:
	find data -type d -empty -print -delete

scrub: rm-empty prune

is_current:
	python utils/python/validate_is_current -d data

fm:
	git grep $(ID) | grep exhibition_id

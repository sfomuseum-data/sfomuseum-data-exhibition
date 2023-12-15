OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')

x:
	wof-exportify -s data -i $(ID)

metafiles:
	if test ! -d meta; then mkdir meta; fi
	utils/$(OS)/wof-build-metafiles -out meta .

prune:
	git gc --aggressive --prune

rm-empty:
	find data -type d -empty -print -delete

scrub: rm-empty prune

is_current:
	python utils/python/validate_is_current -d data

stats:
	if test ! -d docs/stats; then mkdir -p docs/stats; fi
	utils/$(OS)/wof-stats-counts -pretty -custom 'properties.sfomuseum:placetype' -custom 'properties.sfomuseum:exhibition_type' -out docs/stats/counts.json ./
	utils/$(OS)/wof-stats-du -pretty > docs/stats/diskusage.json ./

fm:
	git grep $(ID) | grep exhibition_id

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

stats:
	if test ! -d docs/stats; then mkdir -p docs/stats; fi
	utils/$(OS)/wof-stats-counts -pretty -out docs/stats/counts.json ./
	utils/$(OS)/wof-stats-du -pretty > docs/stats/diskusage.json ./

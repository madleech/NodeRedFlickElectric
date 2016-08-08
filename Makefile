PATH := ./node_modules/.bin:${PATH}

.PHONY : init build dist publish

init:
	npm install

clean:
	rm -rf lib/

build:
	coffee -o flick-electric-price/ -c flick-electric-price/src/

dist: clean init build

publish: dist
	npm publish

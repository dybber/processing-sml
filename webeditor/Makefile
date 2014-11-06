
all: build

build: src/smltojs0.mlb src/Editor.sml src/index.html
	mkdir -p output
	mkdir -p src/build
	cp -r src/css output/
	cp -r src/js output/
	cd src && SML_LIB=~/git/mlkit/js smltojs -export_basis_js -aopt -o build/compiler smltojs0.mlb
	./compress.sh
	cp src/build/compiler.js output/js/
	cp src/build/libraries.js output/js/
	cp -r src/MLB output/
	cp src/index.html output/index.html

clean:
	rm -rf output/*
	rm -rf src/build/*

deploy: build
	scp -r output/* dybber@ask.diku.dk:./public_html/processing-sml


#	awk 'inhead { system("cat output/compiler.html"); inhead=0; } /<head>/ { inhead=1; } { print }' src/template.html > output/index.html

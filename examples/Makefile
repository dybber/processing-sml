
all: index.html

example1.html: Example1.mlb Example1.sml
	SML_LIB=~/git/mlkit/js smltojs -o example1 Example1.mlb

index.html: example1.html template.html
	awk 'inhead { system("cat example1.html"); inhead=0; } /<head>/ { inhead=1; } { print }' template.html > index.html

clean:
	rm index.html
	rm example1.html
	rm -rf MLB/

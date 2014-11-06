#!/bin/bash
cd src
var=`perl -ne 'if(m/src="(.*?)"/){ print $1 . "\n"; }' build/compiler.html`
cat $var > build/compiler.js
cd libraries
cat $(cat list) > ../build/libraries.js

all: processing-sml

processing-sml: JsUtil.sml Processing.sml Processing.sig Processing.mlb Drawing.sig
	SML_LIB=~/git/mlkit/js smltojs -export_basis_js -c Processing.mlb

clean:
	rm -rf MLB/

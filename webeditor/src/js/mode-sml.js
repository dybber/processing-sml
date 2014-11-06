ace.define('ace/mode/sml', function(require, exports, module) {

var oop = require("ace/lib/oop");
var TextMode = require("ace/mode/text").Mode;
var Tokenizer = require("ace/tokenizer").Tokenizer;
var SMLHighlightRules = require("ace/mode/sml_highlight_rules").SMLHighlightRules;

var Mode = function() {
  this.$tokenizer = new Tokenizer(new SMLHighlightRules().getRules());
};
oop.inherits(Mode, TextMode);

(function() {
  this.blockComment = {start: "(*", end: "*)"};

    // Extra logic goes here. (see below)
}).call(Mode.prototype);

  
exports.Mode = Mode;
});

ace.define('ace/mode/sml_highlight_rules', function(require, exports, module) {

  var oop = require("ace/lib/oop");
  var TextHighlightRules = require("ace/mode/text_highlight_rules").TextHighlightRules;

  var SMLHighlightRules = function() {

    var keywords = (
        "abstype|and|andalso|as|case|datatype|do|else|eqtype|end|"    +
        "exception|fn|fun|functor|handle|if|in|include|infix|infixr|" +
        "let|local|nonfix|of|op|open|orelse|raise|rec|sharing|sig|"   +
        "signature|struct|structure|then|type|val|where|while|with|"  +
        "withtype"
    );

    var builtinConstants = ("true|false");

    var builtinFunctions = ("");

    var keywordMapper = this.createKeywordMapper({
        "variable.language": "this",
        "keyword": keywords,
        "constant.language": builtinConstants,
        "support.function": builtinFunctions
    }, "identifier");

    var decimalInteger = "(?:(?:[1-9]\\d*)|(?:0))";
    var octInteger = "(?:0[oO]?[0-7]+)";
    var hexInteger = "(?:0[xX][\\dA-Fa-f]+)";
    var binInteger = "(?:0[bB][01]+)";
    var integer = "(?:" + decimalInteger + "|" + octInteger + "|" + hexInteger + "|" + binInteger + ")";

    var exponent = "(?:[eE][+-]?\\d+)";
    var fraction = "(?:\\.\\d+)";
    var intPart = "(?:\\d+)";
    var pointFloat = "(?:(?:" + intPart + "?" + fraction + ")|(?:" + intPart + "\\.))";
    var exponentFloat = "(?:(?:" + pointFloat + "|" +  intPart + ")" + exponent + ")";
    var floatNumber = "(?:" + exponentFloat + "|" + pointFloat + ")";

    this.$rules = {
        "start" : [
            {
                token : "comment",
                regex : '\\(\\*.*?\\*\\)\\s*?$'
            },
            {
                token : "comment",
                regex : '\\(\\*.*',
                next : "comment"
            },
            {
                token : "string", // single line
                regex : '["](?:(?:\\\\.)|(?:[^"\\\\]))*?["]'
            },
            {
                token : "string", // single char
                regex : "'.'"
            },
            {
                token : "string", // " string
                regex : '"',
                next  : "qstring"
            },
            {
                token : "constant.numeric", // imaginary
                regex : "(?:" + floatNumber + "|\\d+)[jJ]\\b"
            },
            {
                token : "constant.numeric", // float
                regex : floatNumber
            },
            {
                token : "constant.numeric", // integer
                regex : integer + "\\b"
            },
            {
                token : keywordMapper,
                regex : "[a-zA-Z_$][a-zA-Z0-9_$]*\\b"
            },
            {
                token : "keyword.operator",
                regex : "\\+\\.|\\-\\.|\\*\\.|\\/\\.|#|;;|\\+|\\-|\\*|\\*\\*\\/|\\/\\/|%|<<|>>|&|\\||\\^|~|<|>|<=|=>|==|!=|<>|<-|="
            },
            {
                token : "paren.lparen",
                regex : "[[({]"
            },
            {
                token : "paren.rparen",
                regex : "[\\])}]"
            },
            {
                token : "text",
                regex : "\\s+"
            }
        ],
      "comment" : [
            {
                token : "comment", // closing comment
                regex : ".*?\\*\\)",
                next : "start"
            },
            {
                token : "comment", // comment spanning whole line
                regex : ".+"
            }
        ],
        "qstring" : [
            {
                token : "string",
                regex : '"',
                next : "start"
            }, {
                token : "string",
                regex : '.+'
            }]};
  };

  oop.inherits(SMLHighlightRules, TextHighlightRules);

  exports.SMLHighlightRules = SMLHighlightRules;
});

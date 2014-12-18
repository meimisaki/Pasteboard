'use strict';

var editor = 'pre code[contenteditable]';

function length(node) {
    return node.textContent.length;
}

function range(node, offset) {
    var range = document.createRange();
    range.setStart(node, offset);
    range.setEnd(node, offset);
    return range;
}

function select(node, offset) {
    for (var child = node.firstChild ; child ; child = child.nextSibling) {
        var len = length(child);
        if (len < offset) offset -= len;
        else if (child.nodeType == document.TEXT_NODE) return range(child, offset);
        else return select(child, offset);
    }
}

function execCommand(cmd, val) {
    document.designMode = 'on';
    document.execCommand(cmd, false, val || null);
    document.designMode = 'off';
}

$(document).ready(function () {
    var key;
    $(editor).on('keydown', function (event) {
        if ((key = event.which) != 9) return ;
        event.preventDefault();
        execCommand('insertText', '    ');
        $(this).trigger('input');
    }).on('input', function () {
        var elem = this;
        if (!$(elem).data('lang')) return ;
        setTimeout(function () {
            var selection = window.getSelection();
            var range = selection.rangeCount ? selection.getRangeAt(0) : null;
            var focus = range && $(range.commonAncestorContainer).closest(editor).toArray().indexOf(elem) != -1;
            var offset = 0;
            if (focus) {
                var node = range.startContainer;
                if (node == elem) {
                    var child = node.firstChild;
                    for (var i = 0 ; i < range.startOffset ; ++i) {
                        offset += length(child);
                        child = child.nextSibling;
                    }
                }
                else {
                    offset = range.startOffset;
                    for (; node != elem ; node = node.parentNode) {
                        var child = node;
                        do {
                            child = child.previousSibling;
                            if (!child) break;
                            offset += length(child);
                        }while (true);
                    }
                }
                if (key == 13) ++offset;
                key = null;
                offset = Math.min(offset, length(elem));
            }
            elem.innerText = elem.innerText;
            hljs.highlightBlock(elem);
            if (focus) {
                range = select(elem, offset);
                selection = window.getSelection();
                selection.removeAllRanges();
                selection.addRange(range);
                elem.focus();
            }
        }, 0);
    });
});

app.controller('editCtrl', function ($scope) {
    $scope.langs = {"Python":["python","py","gyp"],"Python profiler results":["profile"],"Ruby":["ruby","rb","gemspec","podspec","thor","irb"],"Haml":["haml"],"Perl":["perl","pl"],"PHP":["php","php3","php4","php5","php6"],"Scala":["scala"],"Groovy":["groovy"],"Go":["go","golang"],"Gradle":["gradle"],"HTML, XML":["xml","html","xhtml","rss","atom","xsl","plist"],"Lasso":["lasso","ls","lassoscript"],"CSS":["css"],"SCSS":["scss"],"Less":["less"],"Stylus":["stylus","styl"],"Markdown":["markdown","md","mkdown","mkd"],"AsciiDoc":["asciidoc"],"Django":["django","jinja"],"Twig":["twig","craftcms"],"Handlebars":["handlebars","hbs","html.hbs","html.handlebars"],"Dust":["dust","dst"],"JSON":["json"],"Mathematica":["mathematica","mma"],"JavaScript":["javascript","js"],"TypeScript":["typescript","ts"],"CoffeeScript":["coffeescript","coffee","cson","iced"],"Dart":["dart"],"LiveScript":["livescript","ls"],"ActionScript":["actionscript","as"],"Haxe":["haxe","hx"],"VBScript":["vbscript","vbs"],"VB.Net":["vbnet","vb"],"Protocol Buffers":["protobuf"],"Cap’n Proto":["capnproto","capnp"],"Thrift":["thrift"],"HTTP":["http"],"Lua":["lua"],"Delphi":["delphi"],"Oxygene":["oxygene"],"Java":["java","jsp"],"Processing":["processing"],"AspectJ":["aspectj"],"C++":["cpp","c","h","c++","h++"],"Objective C":["objectivec","m","mm","objc","obj-c"],"Vala":["vala"],"C#":["cs","csharp"],"F#":["fsharp","fs"],"OCaml":["ocaml","ml"],"D":["d"],"RenderMan RSL":["rsl"],"RenderMan RIB":["rib"],"Maya Embedded Language":["mel"],"SQL":["sql"],"Smalltalk":["smalltalk","st"],"Lisp":["lisp"],"Clojure":["clojure","clj"],"Scheme":["scheme"],"Ini":["ini"],"Apache":["apache","apacheconf"],"Nginx":["nginx","nginxconf"],"Diff":["diff","patch"],"DOS":["dos","bat","cmd"],"PowerShell":["powershell","ps"],"Bash":["bash","sh","zsh"],"Makefile":["makefile","mk","mak"],"CMake":["cmake","cmake.in"],"Nix":["nix"],"NSIS":["nsis"],"Axapta":["axapta"],"Oracle Rules Language":["ruleslanguage"],"1C":["1c"],"x86 Assembly":["x86asm"],"AVR assembler":["avrasm"],"VHDL":["vhdl"],"Parser3":["parser3"],"LiveCode Server":["livecodeserver"],"TeX":["tex"],"Haskell":["haskell","hs"],"Erlang":["erlang","erl"],"Elixir":["elixir"],"Rust":["rust","rs"],"Matlab":["matlab"],"Scilab":["scilab","sci"],"R":["r"],"OpenGL Shading Language":["glsl"],"AppleScript":["applescript","osascript"],"Vim Script":["vim"],"Brainfuck":["brainfuck","bf"],"Mizar":["mizar"],"AutoHotkey":["autohotkey"],"Monkey":["monkey"],"FIX":["fix"],"Gherkin":["gherkin"],"Nimrod":["nimrod"],"Swift":["swift"],"G-Code":["gcode","nc"],"Q":["k","kdb"],"Tcl":["tcl","tk"],"Puppet":["puppet","pp"],"Stata":["stata"],"XL":["xl","tao"],"Roboconf":["graph","instances"],"STEP Part 21":["p21","step","stp"],"Mercury":["mercury"],"Smali":["smali"],"Verilog":["verilog","v"],"Dockerfile":["dockerfile","docker"]};
    $scope.$watch('lang', function (lang) {
        var elem = $(editor);
        $.each($scope.langs, function () {
            $.each(this, function () {
                elem.removeClass(this);
            });
        });
        elem.data('lang', lang).addClass(lang).trigger('input');
    });
});

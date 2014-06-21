" Vim syntax file
" Language:	    HTML5 New Stuff
" Maintainer:	othree <othree@gmail.com>
" URL:		    http://github.com/othree/html5-syntax.vim
" Last Change:  2011-05-27
" License:      MIT
" Changes:      

syn region string start=+"+ skip=+\\\\\|\\"+ end=+"+
syn keyword javaScriptDomElemAttrs go var func defer if else import package struct interface
syn keyword javaScriptDomElemAttrs int int16 int64 int32 float64 complex string


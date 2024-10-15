# Vinyl - A hypoallergenic latex template

Which do you hate more, computer modern, or having the same 100 line Latex
preamble included in almost every document you've every written? If you ask me,
they're both as annoying as each other.

Well, this is _vinyl_, a Latex template for the allergic.

**Design Intentions**

 - Typographically pleasing
 - Promotes simplistic Latex code
 - Requires minimal (read: _no_) extra configuration
 - Scalable from small notes to large theses

**Desired Compatability**

 - Compatable with all Latex compilers (**however** `lualatex` is a strong
   preference)
 - Allow empty pages (to create equations alone)
 - Tight and pleasant integration with Emacs org-mode with minimal extra
   configuration required
 
## Document Classes

This template actually provides four document classes, `empty`, `note`, `paper`
(default) and `book`. To choose a template simply add
```latex
\documentclass[note]{vinyl}
```
changing `note` to whichever you want.

 - `empty`: used to produce an empty page containing only the given latex
   expression. Used to produce org-previews and the like.
 - `note`: used to make short notes that get straight to the point.
 - `paper`: slightly beefier than a note. Great for drafting papers.
 - `thesis`: this is the real deal, the big kahuna.
 
Examples are each can be seen in `examples/`.

## Macros and Theorems

By default, `vinyl` loads in a personal set of macros and preferred theorem
environments, defined in `vinylmacros` and `vinyltheorems`. But you can turn
them off with the class options `nomacros` and `notheorems`.

## Installation

The easiest way to install is to simply copy the class and style files into the
directory of the file your working on. Otherwise, you can install it into your
`texmf` tree for easy use with any tex file. An example is shown in `setup`,
however this uses sym links so dont delete the original.


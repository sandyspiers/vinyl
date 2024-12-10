\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{vinyl}[2024/10/15 A latex template for the allergic.]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% A latex template for the allergic.
% Provides 4 document classes, selectable as options:
%  - empty
%  - note
%  - paper (default)
%  - book
%
\newif\ifempty\emptyfalse
\newif\ifnote\emptyfalse
\newif\ifpaper\papertrue % default
\newif\ifbook\bookfalse
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% KOMA
% All except empty use KOMA script to create their template.
\newif\ifusekoma\usekomatrue

\DeclareOption{empty}{
	\emptytrue\paperfalse\usekomafalse
	\PassOptionsToClass{
		\CurrentOption
	}{article}
}

\DeclareOption{note}{
	\notetrue\paperfalse
	\PassOptionsToPackage{
		DIV  = 12,
	}{typearea}
	\PassOptionsToClass{
		a4paper,
		12pt,
	}{scrartcl}
}

\DeclareOption{paper}{
	\PassOptionsToPackage{
		DIV  = 12,
	}{typearea}
	\PassOptionsToClass{
		a4paper,
		12pt,
		abstract=on,
	}{scrartcl}
}

\DeclareOption{book}{
	\booktrue\paperfalse
	\paperfalse\booktrue
	% Page setup settings
	\PassOptionsToPackage{
		DIV  = 12,
		BCOR = 10mm,
	}{typearea}

	% KOMA-book settings
	\PassOptionsToClass{
		a4paper,
		twoside,
		12pt,
		cleardoublepage=empty,
		numbers=noenddot,
		titlepage,
		toc=bibliography,
		toc=index,
	}{scrbook}
}

% Process options
\ProcessOptions\relax
% Load right base class
\ifempty
	\LoadClass{article}
\fi
\ifnote
	\LoadClass{scrartcl}
\fi
\ifpaper
	\LoadClass{scrartcl}
\fi
\ifbook
	\LoadClass{scrbook}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Compiler and Font
% Automatically determines compiler and uses correct fonter
\RequirePackage{iftex}
\newif\ifxetexorluatex\xetexorluatexfalse
\ifxetex
	\xetexorluatextrue
\fi
\ifluatex
	\xetexorluatextrue
\fi

\ifxetexorluatex
	\RequirePackage{fontspec}
	\RequirePackage{unicode-math}
	\RequirePackage{microtype}
	\setmainfont{Libertinus Serif}
	\setmathfont{Libertinus Math}
	\setsansfont[Scale=MatchLowercase]{Libertinus Sans}
	\setmonofont[Scale=MatchLowercase]{Roboto Mono}
\else
	\RequirePackage[T1]{fontenc}
	\RequirePackage[utf8]{inputenc}
	\RequirePackage{amssymb}
	\RequirePackage{libertinus}
\fi

% Line spacing
\renewcommand{\baselinestretch}{1.1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% APA-like Referencing
\RequirePackage{csquotes}
\RequirePackage[english]{babel}
\RequirePackage[style=apa]{biblatex}
\AtEveryBibitem{%
	\clearfield{note}%
	\clearfield{url}%
}
\renewcommand{\cite}[1]{\textcite{#1}}
\newcommand{\citep}[1]{\parencite{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Colours
\RequirePackage[dvipsnames]{xcolor}
\definecolor{accent}{HTML}{C80F19}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Graphics
\RequirePackage{graphicx}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{tikz}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Tables
\RequirePackage{booktabs}
\RequirePackage{makecell}
\RequirePackage{multirow}
\RequirePackage{longtable}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Hyperlinks & Bookmarks
\RequirePackage[%
	colorlinks = true,
	citecolor  = accent,
	linkcolor  = accent,
	urlcolor   = accent,
	unicode,
]{hyperref}
\RequirePackage{bookmark}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Mathematics
\RequirePackage{amsmath}
\RequirePackage{amsthm}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Algorithms
\RequirePackage{amsmath}
\RequirePackage[noend,ruled,vlined,linesnumbered]{algorithm2e}
\DontPrintSemicolon
\SetKwProg{Function}{function}{:}{}
\SetKw{Continue}{continue}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Utils
\RequirePackage{enumitem}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Footnotes
%% Make bar full length
\renewcommand{\footnoterule}{\noindent\smash{\rule[3pt]{\textwidth}{0.4pt}}}
\ifbook
	%% Macro for chapter with footnote
	\newcommand{\chapterfootnote}[2]{\chapter[#1]{#1\footnote{#2}}}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Typefaces for parts, chapters, and sections (if KOMA)
\ifusekoma
    % Headers, sectioners and page layout
	\RequirePackage{scrlayer-scrpage}
	\pagestyle{scrheadings}
	\renewcommand{\partformat}{\huge\partname~\thepart\autodot}
	\renewcommand{\raggedpart}{\flushleft}

	\setkomafont{part}{\normalfont\huge\scshape}
	\setkomafont{sectioning}{\normalfont\scshape}
	\setkomafont{descriptionlabel}{\normalfont\bfseries}
	\setkomafont{caption}{\small}
	\setkomafont{captionlabel}{\usekomafont{caption}}

	\ifbook
		% Large number for chapter
		\renewcommand*{\chapterformat}{%
			\color{accent}\fontsize{50}{55}\selectfont\thechapter\autodot\enskip
		}
	\fi

	% colour the section number
	\let\oldsectionformat\sectionformat
	\renewcommand*{\sectionformat}{\color{accent}\oldsectionformat}
	\let\oldsubsectionformat\subsectionformat
	\renewcommand*{\subsectionformat}{\color{accent}\oldsubsectionformat}
	\let\oldsubsubsectionformat\subsubsectionformat
	\renewcommand*{\subsubsectionformat}{\color{accent}\oldsubsubsectionformat}

	% Smallcaps for titles
	\newcommand{\titlesc}[1]{\textsc{\Huge #1}}

	% Add subsubsections
	\setcounter{secnumdepth}{\subsubsectionnumdepth}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Empty class
\ifempty
	\pagestyle{empty} % do not remove
	% The settings below are copied from fullpage.sty
	\setlength{\textwidth}{\paperwidth}
	\addtolength{\textwidth}{-3cm}
	\setlength{\oddsidemargin}{1.5cm}
	\addtolength{\oddsidemargin}{-2.54cm}
	\setlength{\evensidemargin}{\oddsidemargin}
	\setlength{\textheight}{\paperheight}
	\addtolength{\textheight}{-\headheight}
	\addtolength{\textheight}{-\headsep}
	\addtolength{\textheight}{-\footskip}
	\addtolength{\textheight}{-3cm}
	\setlength{\topmargin}{1.5cm}
	\addtolength{\topmargin}{-2.54cm}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Environments
\ifbook
	%% Prepages
	\newenvironment{prepage}[1]{
		\begin{center}
			\titlesc{#1}
		\end{center}
		\quotation
		\noindent\ignorespaces
	}{
		\endquotation
		\clearpage
	}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Macos and Theorems
\RequirePackage{vinylmacros}
\RequirePackage{vinyltheorems}

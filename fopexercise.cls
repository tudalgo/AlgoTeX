% FOP Exercise template class
% Author: Kim Berninger
% Überarbeitet von: Ruben Deisenroth
\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{fopexercise}[2021/09/06 Edited Version of 2020/08/08 FOP Exercise template class]

\RequirePackage{kvoptions}
\RequirePackage[table]{xcolor}
\PassOptionsToPackage{bookmarksnumbered}{hyperref} % Praktischer
\RequirePackage{pagecolor} % Used for dark Mode
\DeclareStringOption[3]{maxdifficulty}[3]
\DeclareStringOption{inlineshortcut}[java]
\DeclareStringOption[tuda_logo]{logopath}[tuda_logo]
\DeclareBoolOption[true]{showpoints}
\DeclareBoolOption[true]{fopdesign}
\DeclareBoolOption[false]{dark_mode}
\DeclareBoolOption[true]{shell_escape}
\ProcessKeyvalOptions*
\DeclareComplementaryOption{hidepoints}{showpoints}
\DeclareComplementaryOption{corporatedesign}{fopdesign}
\ProcessKeyvalOptions*

% Used by CI/CD to inject options
\IfFileExists{options.cfg}{\input{options.cfg}}{}

\iffopexercise@fopdesign
    \LoadClass[12pt, a4paper]{article}
\else
    \LoadClass[
        ngerman,
        color=7b,
        colorback=false
    ]{tudaexercise}
\fi

\RequirePackage{tcolorbox}
\tcbuselibrary{skins}

% \RequirePackage[utf8]{inputenc}
\RequirePackage[german, ngerman]{babel}

% \RequirePackage{parskip}

\iffopexercise@fopdesign
    \RequirePackage[
        left=2.5cm, right=2.5cm, top=3.5cm, bottom=2cm,
        headheight=1cm, headsep=1.5cm,
        footnotesep=0.3cm, footskip=1cm]{geometry}
\fi
\RequirePackage{graphicx}

\iffopexercise@fopdesign
    \RequirePackage{fancyhdr}

    \pagestyle{fancy}
    \fancyhf{}
    \fancyhead[L]{Funktionale und objektorientierte Programmierkonzepte}
    \fancyhead[R]{\@title}
    \fancyfoot[C]{\thepage}
\fi

\RequirePackage{pifont}

\newcommand\fopexercise@stars[2]{
    \newcount\currentstar
    \currentstar=0
    \loop \ifnum \currentstar < #2 \ifnum \currentstar < #1 \ding{72} \else \ding{73} \fi
    \advance \currentstar 1 \repeat}

\iffopexercise@showpoints
    \newcommand{\fopexercise@points}[1]{#1 Punkt\ifnum #1=\@ne\else{e}\fi}
\else
    \newcommand{\fopexercise@points}[1]{? Punkte}
\fi

\RequirePackage{listings}

\lstloadlanguages{Java}

\lstdefinelanguage{Racket}{%
    alsoletter=+-*/?\=<>!~\#,%
    morekeywords={%                                                                                                                                                          
            empty, true, \#true, \#t, false, \#false, \#f%
        },%
    morekeywords={%                                                                                                                                                          
            lambda, define-datatype, begin, begin0, set!, delay, shared, recur,%
            case, match, when, unless%
        },%
    morekeywords={%                                                                                                                                                          
            local, letrec, let*, let, time, define, define-struct, cond, else, if,%
            and, or, check-expect, check-random, check-satisfied, check-within,%
            check-error, check-member-of, check-range, require%
        },%
    morekeywords={%                                                                                                                                                          
            -, <, <=, =, >, >=, abs, acos, add1, angle, asin, atan, ceiling,%
            complex?, conjugate, cos, cosh, current-seconds, denominator, e, even?,%
            exact->inexact, exact?, exp, expt, floor, gcd, imag-part,%
            inexact->exact, inexact?, integer->char, integer-sqrt, integer?, lcm,%
            log, magnitude, make-polar, make-rectangular, max, min, modulo,%
            negative?, number->string, number?, numerator, odd?, pi, positive?,%
            quotient, random, rational?, real-part, real?, remainder, round, sgn,%
            sin, sinh, sqr, sqrt, sub1, tan, zero?%
        },%
    morekeywords={%                                                                                                                                                          
            boolean->string, boolean=?, boolean?, false?, not%
        },%
    morekeywords={%                                                                                                                                                          
            symbol->string, symbol=?, symbol%
        },%
    morekeywords={%                                                                                                                                                          
            append, assoc, assq, caaar, caadr, caar, cadar, cadddr, caddr, cadr,%
            car, cdaar, cdadr, cdar, cddar, cdddr, cddr, cdr, cons, cons?, eighth,%
            empty?, fifth, first, for-each, fourth, length, list, list*, list-ref,%
            list?, make-list, member, member?, memq, memq?, memv, null, null?,%
            range, remove, remove-all, rest, reverse, second, seventh, sixth, third%
        },%
    morekeywords={%
            make-posn, posn-x, posn-y, posn?, set-posn-x!, set-posn-y!%
        },%
    morekeywords={%
            char->integer, char-alphabetic?, char-ci<=?, char-ci<?, char-ci=?,%
            char-ci>=?, char-ci>?, char-downcase, char-lower-case?, char-numeric?,%
            char-upcase, char-upper-case?, char-whitespace?, char<=?, char<?,%
            char=?, char>=?, char>?, char?%
        },%
    morekeywords={%
            explode, format, implode, int->string, list->string, make-string,%
            replicate, string, string->int, string->list, string->number,%
            string->symbol, string-alphabetic?, string-contains-ci?,%
            string-contains?, string-copy, string-downcase, string-ith,%
            string-length, string-lower-case?, string-numeric?, string-ref,%
            string-upcase, string-upper-case?, string-whitespace?, string?,%
            substring%
        },%
    morekeywords={%
            image=?, image?%
        },%
    morekeywords={%
            =~, current-milliseconds, eof, eof-object?, eq?, equal?, equal~?, eqv?,%
            error, exit, force, gensym, identity, promise?, sleep, struct?, void,%
            void?%
        },%
    morekeywords={%
            +, *, /
        },%
    morekeywords={%
            string-append, string-ci<=?, string-ci<?, string-ci=?, string-ci>=?,%
            string-ci>?, string<=?, string<?, string=?, string>=?, string>?%
        },%
    morekeywords={%
            posn%
        },%
    morekeywords={%
            andmap, apply, argmax, argmin, build-list, build-string, compose,%
            filter, foldl, foldr, map, memf, ormap, procedure?, quicksort, sort%
        },%
    morekeywords={%
            display, newline, pretty-print, print, printf, read,%
            with-input-from-file, with-input-from-string, with-output-to-file,%
            with-output-to-string, write%
        },%
    morekeywords={%
            build-vector, list->vector, make-vector, vector, vector->list,%
            vector-length, vector-ref, vector-set!, vector?%
        },%
    morekeywords={%
            box, box?, set-box!, unbox
        },%
    morekeywords={%
            hash-copy, hash-count, hash-eq?, hash-equal?, hash-eqv?, hash-for-each,%
            hash-has-key?, hash-map, hash-ref, hash-ref!, hash-remove,%
            hash-remove!, hash-set, hash-set!, hash-update, hash-update!, hash?,%
            make-hash, make-hasheq, make-hasheqv, make-immutable-hash,%
            make-immutable-hasheq, make-immutable-hasheqv
        },%
    morecomment=[l]{;},%
    morecomment=[s]{\#|}{|\#},%
    morestring=[b]{"}%
}

\lstalias{Scheme}{Racket}

\RequirePackage{xcolor}

\definecolor{fopexercise@codekeyword}{rgb}{0.13,0.13,1}
\definecolor{fopexercise@codestring}{rgb}{0.9,0,0}
\definecolor{fopexercise@codecomment}{rgb}{0,0.5,0}
\definecolor{fopexercise@codegray}{rgb}{0.46,0.45,0.48}
\definecolor{fopexercise@codebackground}{rgb}{0.90,0.92,0.95}

\lstset{
    basicstyle=\footnotesize\ttfamily,
    keywordstyle=\color{fopexercise@codekeyword},
    stringstyle=\color{fopexercise@codestring},
    commentstyle=\color{fopexercise@codecomment},
    showstringspaces=false,
    breaklines,
    breakatwhitespace,
    keepspaces,
    numbers=left,
    numberstyle=\tiny,
    numbersep=5pt,
    backgroundcolor=\color{fopexercise@codebackground},
    frame=single
}

\lstdefinestyle{racket}{
    language=Racket,
    moredelim=[is][\textcolor{fopexercise@codegray}]{/*}{*/},
    moredelim=[is][\underline]{/*!}{*/},
    literate={\_}{}{0\discretionary{-}{}{}} {\-}{}{0\discretionary{-}{}{-}}
}

\lstdefinestyle{java}{
    language=Java,
    moredelim=[is][\textcolor{fopexercise@codegray}]{\#|}{|\#},
    moredelim=[is][\underline]{\#|!}{|\#}
}

\newcommand{\inlineracket}[1]{\lstinline[style=racket]{#1}}
\newcommand{\inlinejava}[1]{\lstinline[style=java]{#1}}

\lstnewenvironment{racket}[1][]{\lstset{style=racket, #1}}{}
\lstnewenvironment{java}[1][]{\lstset{style=java, #1}}{}

\if\relax\fopexercise@inlineshortcut\relax
\else
    \lstMakeShortInline[language=\fopexercise@inlineshortcut]´
\fi

\RequirePackage[inline]{enumitem}


\iffopexercise@fopdesign
    \renewcommand\and{\item}
    \renewcommand\author[1]{%
        \renewcommand\@author{%
            \begin{itemize*}[label={}, afterlabel={}, itemjoin={,\ }, itemjoin*={\ und\ }]%
                \and#1%
            \end{itemize*}}}
\else
    % TODO: Figure out how to support \and when the corporate design is used
    % \renewcommand\author[1]{%
    %     \renewcommand\@author{
    %         \textbf{\fopexercise@supervisor} \\
    %         {\normalfont #1}
    %     }
    % }

    \renewcommand\author[1]{%
        \renewcommand\@author{%
            \fopexercise@supervisor\\#1
        }
    }

    \renewcommand\title[1]{
        \newcommand{\originalTitle}{#1}
        \renewcommand{\@title}{%
            Funktionale und objektorientierte Programmierkonzepte\\
            #1
        }
    }
\fi

\newcommand\supervisor[1]{\renewcommand\fopexercise@supervisor{#1}}
\newcommand\fopexercise@supervisor{%
    \ClassError{fopexercise}
    {Kein Veranstalter angegeben}
    {Verwenden Sie den Befehl \@backslashchar supervisor{<veranstalter>} um einen Veranstalter festzulegen.}
}

\newcommand\semester[1]{\renewcommand\fopexercise@semester{#1}}
\newcommand\fopexercise@semester{%
    \ClassError{fopexercise}
    {Kein Semester angegeben}
    {Verwenden Sie den Befehl \@backslashchar semester{<semester>} um ein Semester festzulegen.}
}

\newcommand\version[1]{\renewcommand\fopexercise@version{#1}}
\newcommand\fopexercise@version{%
    \ClassError{fopexercise}
    {Keine Versionsnummer angegeben}
    {Verwenden Sie den Befehl \@backslashchar version{<versionsnummer>} um eine Versionsnummer festzulegen.}
}

\newcommand\topics[1]{\renewcommand\fopexercise@topics{#1}}
\newcommand\fopexercise@topics{%
    \ClassError{fopexercise}
    {Keine Themen angegeben}
    {Verwenden Sie den Befehl \@backslashchar topics{<themen>} um eine Versionsnummer festzulegen.}
}

\newcommand\slides[1]{\renewcommand\fopexercise@slides{#1}}
\newcommand\fopexercise@slides{%
    \ClassError{fopexercise}
    {Kein Foliensatz angegeben}
    {Verwenden Sie den Befehl \@backslashchar slides{<foliennummern>} um einen relevanten Foliensatz festzulegen.}
}

\newcommand\duedate[1]{\renewcommand\fopexercise@duedate{#1}}
\newcommand\fopexercise@duedate{%
    \ClassError{fopexercise}
    {Kein Abgabedatum angegeben}
    {Verwenden Sie den Befehl \@backslashchar duedate{<datum>} um ein Abgabedatum festzulegen.}
}

\iffopexercise@fopdesign
    \renewcommand{\maketitle}{%
        \vspace*{-7\baselineskip}
        \begin{center}
            \begin{minipage}{0.7\textwidth}
                \begin{flushleft}
                    \Large\textbf{Funktionale und objektorientierte Programmierkonzepte}
                \end{flushleft}
            \end{minipage}%
            \begin{minipage}{0.3\textwidth}
                \begin{flushright}
                    \includegraphics[trim=13 8 20 7, clip, width=\textwidth]{\fopexercise@logopath}\\[7.5mm]
                \end{flushright}
            \end{minipage}

            \vspace{2mm}

            \begin{minipage}[t]{0.6\textwidth}
                \begin{flushleft} \large
                    \@author\\(Gesamtleitung: \fopexercise@supervisor{})
                \end{flushleft}
            \end{minipage}%
            \begin{minipage}[t]{0.4\textwidth}
                \begin{flushright}
                    \large \fopexercise@semester\\v\fopexercise@version
                \end{flushright}
            \end{minipage}

            \rule{\linewidth}{0.2mm}\\[4mm]
            {\LARGE\bfseries\@title}\\
            \rule{\linewidth}{0.2mm}\\[5mm]

            {\large Themen:\hfill\fopexercise@topics}

            \vspace{3mm}

            {\large Relevante Foliensätze:\hfill\fopexercise@slides}

            \vspace{3mm}

            {\large Abgabe der Hausübung:\hfill\fopexercise@duedate}

            \rule{\linewidth}{0.2mm}\\[4mm]
        \end{center}

        \thispagestyle{plain}

        \global\let\thanks\relax
        \global\let\maketitle\relax
        \global\let\@maketitle\relax
        \global\let\@thanks\@empty
        \global\let\@author\@empty
        \global\let\@date\@empty
        \global\let\fopexercise@supervisor\relax
        \global\let\fopexercise@semester\relax
        \global\let\fopexercise@version\relax
        \global\let\fopexercise@topics\relax
        \global\let\fopexercise@slides\relax
        \global\let\fopexercise@duedate\relax
        \global\let\title\relax
        \global\let\author\relax
        \global\let\date\relax
        \global\let\and\relax
        \global\let\supervisor\relax
        \global\let\semester\relax
        \global\let\version\relax
        \global\let\topics\relax
        \global\let\slides\relax
        \global\let\duedate\relax
    }
\else
    \let\corporateDesignHeader\maketitle
    \renewcommand{\maketitle}{%
    \renewcommand{\@title}{%
        Funktionale und objektorientierte Programmierkonzepte\\
\originalTitle
        % {\large \qquad v\fopexercise@version}
        % Test {\large \qquad v\fopexercise@version}
    }
    % \renewcommand{\@title}{%
    %     Funktionale und objektorientierte Programmierkonzepte\\
    %     \originalTitle \hfill {\large v\fopexercise@version}
    % }
    \corporateDesignHeader
    % \vspace*{-4.8\baselineskip}
    % {\null\hfill v\fopexercise@version}\\ \\
    \vspace*{-1.8\baselineskip}
    {\fopexercise@semester \hfill v\fopexercise@version}\\
    {Themen:\hfill\fopexercise@topics}\\
    {Relevante Foliensätze:\hfill\fopexercise@slides}\\
    {Abgabe der Hausübung:\hfill\fopexercise@duedate}\\
    \rule{\linewidth}{0.2mm}\\[4mm]
    \vspace*{-2\baselineskip}

    \thispagestyle{plain}

    \global\let\thanks\relax
    \global\let\maketitle\relax
    \global\let\@maketitle\relax
    \global\let\@thanks\@empty
    \global\let\@author\@empty
    \global\let\@date\@empty
    \global\let\fopexercise@supervisor\relax
    \global\let\fopexercise@semester\relax
    \global\let\fopexercise@version\relax
    \global\let\fopexercise@topics\relax
    \global\let\fopexercise@slides\relax
    \global\let\fopexercise@duedate\relax
    \global\let\title\relax
    \global\let\author\relax
    \global\let\date\relax
    \global\let\and\relax
    \global\let\supervisor\relax
    \global\let\semester\relax
    \global\let\version\relax
    \global\let\topics\relax
    \global\let\slides\relax
    \global\let\duedate\relax
    }
\fi

\newcounter{vues}
\newcounter{vue}[vues]
\newcounter{vueaufgabe}[vue]
\newcounter{hue}
\newcounter{hueaufgabe}[hue]
\newcounter{hueteilaufgabe}[hueaufgabe]

\renewcommand\thevues{V}
\renewcommand\thevue{V\@arabic\c@vue}
\renewcommand\thevueaufgabe{V\@arabic\c@vue.\@arabic\c@vueaufgabe}
\renewcommand\thehue{H}
\renewcommand\thehueaufgabe{H\@arabic\c@hueaufgabe}
\renewcommand\thehueteilaufgabe{H\@arabic\c@hueaufgabe.\@arabic\c@hueteilaufgabe}

\newcommand\vues[0]{
    \@startsection{vues}{1}{\z@}%
    {-3.5ex \@plus -1ex \@minus -.2ex}%
    {2.3ex \@plus .2ex}%
    {\normalfont\Large\bfseries}{Vorbereitende Übungen}}

\newcommand\vue[2]{
    \@startsection{vue}{2}{\z@}%
    {-3.25ex \@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus .2ex}%
    {\normalfont\large\bfseries}[#1]{#1\hfill\fopexercise@stars{#2}{\fopexercise@maxdifficulty}}}

\newcommand\vueaufgabe{
    \@startsection{vueaufgabe}{3}{\z@}%
    {-3.25ex \@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus .2ex}%
    {\normalfont\large\bfseries}}

\newcommand\hue[3]{
    \@startsection{hue}{1}{\z@}%
    {-3.5ex \@plus -1ex \@minus -.2ex}%
    {2.3ex \@plus .2ex}%
    {\normalfont\Large\bfseries}[#1 -- #2]{#1\hfill Gesamt \fopexercise@points{#3}\\\textit{#2}}}

\newcommand\hueaufgabe[2]{
    \@startsection{hueaufgabe}{2}{\z@}%
    {-3.25ex \@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus .2ex}%
    {\normalfont\large\bfseries}[#1]{#1\hfill \fopexercise@points{#2}}}

\newcommand\hueteilaufgabe[2]{
    \@startsection{hueteilaufgabe}{3}{\z@}%
    {-3.25ex\@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus .2ex}%
    {\normalfont\normalfont\bfseries}[#1]{#1\hfill \fopexercise@points{#2}}}

\let\vuesmark\@gobble
\let\vuemark\@gobble
\let\vueaufgabemark\@gobble
\let\huemark\@gobble
\let\hueaufgabemark\@gobble
\let\hueteilaufgabemark\@gobble

\providecommand*{\toclevel@vues}{1}
\providecommand*{\toclevel@vue}{2}
\providecommand*{\toclevel@vueaufgabe}{3}
\providecommand*{\toclevel@hue}{1}
\providecommand*{\toclevel@hueaufgabe}{2}
\providecommand*{\toclevel@hueteilaufgabe}{3}

\newcommand*\l@vues[2]{%
    \ifnum \c@tocdepth >\z@
        \addpenalty\@secpenalty
        \addvspace{1.0em \@plus\p@}%
        \setlength\@tempdima{1.5em}%
        \begingroup
        \parindent \z@ \rightskip \@pnumwidth
        \parfillskip -\@pnumwidth
        \leavevmode \bfseries
        \advance\leftskip\@tempdima
        \hskip -\leftskip
        #1\nobreak\hfil
        \nobreak\hb@xt@\@pnumwidth{\hss #2%
            \kern-\p@\kern\p@}\par
        \endgroup
    \fi}
\newcommand*\l@hue[2]{%
    \ifnum \c@tocdepth >\z@
        \addpenalty\@secpenalty
        \addvspace{1.0em \@plus\p@}%
        \setlength\@tempdima{1.5em}%
        \begingroup
        \parindent \z@ \rightskip \@pnumwidth
        \parfillskip -\@pnumwidth
        \leavevmode \bfseries
        \advance\leftskip\@tempdima
        \hskip -\leftskip
        #1\nobreak\hfil
        \nobreak\hb@xt@\@pnumwidth{\hss #2%
            \kern-\p@\kern\p@}\par
        \endgroup
    \fi}
\newcommand*\l@vue{\@dottedtocline{2}{1.5em}{2.3em}}
\newcommand*\l@vueaufgabe{\@dottedtocline{3}{3.8em}{3.2em}}
\newcommand*\l@hueaufgabe{\@dottedtocline{2}{1.5em}{2.3em}}
\newcommand*\l@hueteilaufgabe{\@dottedtocline{3}{3.8em}{3.2em}}

%-- Rubos Modifications --%
\RequirePackage{amssymb}
\RequirePackage{caption}
\RequirePackage{cprotect}
\RequirePackage{subcaption}

\usetikzlibrary{3d, angles, animations, arrows, arrows.meta, arrows.spaced, automata, babel, backgrounds, bending, calc, calendar, chains, circuits.ee.IEC, circuits.logic.CDH, circuits.logic.IEC, circuits.logic.US, datavisualization, datavisualization.formats.functions, datavisualization.polar, decorations, decorations.footprints, decorations.fractals, decorations.markings, decorations.pathmorphing, decorations.pathreplacing, decorations.shapes, decorations.text, er, external, fadings, fit, fixedpointarithmetic, folding, fpu, graphs, graphs.standard, intersections, lindenmayersystems, math, matrix, patterns, patterns.meta, perspective, petri, plotmarks, positioning, quotes, rdf, scopes, shadings, shadows, shadows.blur, shapes, shapes.arrows, shapes.callouts, shapes.gates.logic.IEC, shapes.gates.logic.US, shapes.geometric, shapes.misc, shapes.multipart, shapes.symbols, spy, svg.path, through, tikzmark, topaths, trees, turtle, views}
\@ifundefined{\string\color@accentcolor}{\definecolor{accentcolor}{RGB}{0, 157, 129}}{}
\ExplSyntaxOn

\prg_new_conditional:Nnn \__ptxcd_if_corporatedesign: {T,F,TF} {
    \iffopexercise@fopdesign
        \prg_return_false:
    \else
        \prg_return_true:
    \fi
}

\cs_set_eq:NN\IfCorporateDesignT \__ptxcd_if_corporatedesign:T
\cs_set_eq:NN\IfCorporateDesignF \__ptxcd_if_corporatedesign:F
\cs_set_eq:NN\IfCorporateDesignTF \__ptxcd_if_corporatedesign:TF


\IfCorporateDesignT{
    % Discover tudaci-Version
    \exp_args:NNnx \seq_set_split:Nnn \g_tuda_version_seq { ~ } { \use:c {ver@tudaexercise.cls} }
    \tl_set:Nx \g_tudaci_version_tl { \seq_item:Nn \g_tuda_version_seq { 2 } }
    \tl_set:Nx \g_tudaci_version_tl {\tl_tail:N \g_tudaci_version_tl}
    \regex_replace_once:nnN { [a-z] } { } \g_tudaci_version_tl

    \newcommand{\getTudaciVersion}[1]{
        \tl_use:N \g_tudaci_version_tl
    }
    \newcommand{\IfTudaciVersionAtLeastTF}[3]{
        \fp_compare:nTF {\getTudaciVersion{} >= #1}{#2}{#3}
    }
    \newcommand{\IfTudaciVersionBetweenTF}[4]{
        \fp_compare:nTF {#1<=\getTudaciVersion{}<=#2}{#3}{#4}
    }

    % Compatibility with newer TUDA-Versions
    \IfTudaciVersionAtLeastTF{3.12}{
        \clist_map_inline:nn {vues,vue,vueaufgabe,hue,hueaufgabe,hueteilaufgabe} {
            \bool_new:c	{g__ptxcd_ruled_#1_bool}
            \bool_gset_true:c {g__ptxcd_ruled_#1_bool}
        }
    }{}
}

\prg_new_conditional:Nnn \__ptxcd_if_dark_mode: {T,F,TF} {
    \iffopexercise@dark_mode
    \prg_return_true:
    \else
    \prg_return_false:
    \fi
}

\prg_new_conditional:Nnn \__rubos_if_shell_escape: {T,F,TF} {
    \iffopexercise@shell_escape
    \sys_if_shell_unrestricted:TF
    {\prg_return_true:}
    {\prg_return_false:}
    \else
    \prg_return_false:
    \fi
}

\cs_set_eq:NN\IfShellEscapeT \__rubos_if_shell_escape:T
\cs_set_eq:NN\IfShellEscapeF \__rubos_if_shell_escape:F
\cs_set_eq:NN\IfShellEscapeTF \__rubos_if_shell_escape:TF

\cs_set_eq:NN\IfDarkModeT \__ptxcd_if_dark_mode:T
\cs_set_eq:NN\IfDarkModeF \__ptxcd_if_dark_mode:F
\cs_set_eq:NN\IfDarkModeTF \__ptxcd_if_dark_mode:TF

\IfDarkModeT{
    \pagecolor{black}
    \color{white}
    \selectcolormodel{RGB}
    \IfTudaciVersionAtLeastTF{3.12}{
        \IfFileExists{tuda_logo_inverted.pdf}{\tl_gset:Nn \g_ptxcd_logofile_tl {tuda_logo_inverted.pdf}}{}
    }{
        \IfFileExists{tuda_logo_inverted.pdf}{\tl_gset:Nn \g_TUDa_logofile_tl {tuda_logo_inverted.pdf}}{}
    }
    \lstset{
        keywordstyle=\color{cyan!70!blue},
    }
}

\IfCorporateDesignT{
    % Custom Headline Style
    \IfTudaciVersionAtLeastTF{3.0}{
        \clist_map_inline:nn {odd, even, oneside} {
            \keys_define:nn {ptxcd/exercise/headline} {
                #1 .choice:,
                #1 / title-name-id .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {
                    \g_ptxcd_shorttitle_tl\par
                    \StudentName\StudentID},
                #1 / title-name .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {
                    \g_ptxcd_shorttitle_tl\par
                    \smallskip
                    \StudentName},
                #1 / title .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {\g_ptxcd_shorttitle_tl},
                #1 / name-id .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {\StudentName\StudentID},
                #1 / name .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {\StudentName},
                #1 / aud .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {
                    \textbf{AuD\space{}}im\space\textbf{\fopexercise@semester}\space{}bei\space\textbf{Prof.~Dr.~rer.~nat.~Karsten~Weihe}\hfill \originalTitle\par
                    \StudentName\StudentID},
            }
        }
    }{
        \clist_map_inline:nn {odd, even, oneside} {
            \tl_gclear_new:c {g_TUDa_ex_headline_#1_tl}
            \keys_define:nn {TUDa/exercise/headline} {
                #1 .choice:,
                #1 / title-name-id .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {
                    \g_TUDa_shorttitle_tl\par
                    \StudentName\StudentID},
                #1 / title-name .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {
                    \g_TUDa_shorttitle_tl\par
                    \smallskip
                    \StudentName},
                #1 / title .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {\g_TUDa_shorttitle_tl},
                #1 / name-id .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {\StudentName\StudentID},
                #1 / name .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {\StudentName},
                #1 / aud .code:n= \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {
                    \textbf{AuD\space{}}im\space\textbf{\fopexercise@semester}\space{}bei\space\textbf{Prof.~Dr.~rer.~nat.~Karsten~Weihe}\hfill \originalTitle\par
                    \StudentName\StudentID
                },
                #1 / unknown .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {##1}
            }
        }
    }
}


\ExplSyntaxOff

% Boxes and Environments

\def\boxarc{0pt}% No boxarc default
\RequirePackage{pdftexcmds}
% A Gray Info Box (gray bar on the Left+ light gray background)
\newtcolorbox{grayInfoBox}[1][]{
    colback=\IfDarkModeTF{white!10!black}{gray!10}, %Hintergrundfarbe
    % colback=fgcolor!10!\thepagecolor, %Hintergrundfarbe
    coltext=.,
    colframe=gray, % Randfarbe
    frame hidden,
    title style=black!80,
    arc=\boxarc,
    boxrule=0pt,
    left=5pt, % Links Platz lassen
    enhanced, % Erlaubt uns, den ramen zu zeichnen
    fonttitle=\sffamily, % Titelschriftart auf 
    overlay={ % Für Grauen Bereich links
            \begin{tcbclipinterior}
                \fill[gray] (frame.south west) rectangle ([xshift=4pt]frame.north west); % Zeilennummernbereich färben
            \end{tcbclipinterior}
        },
    #1 % Weitere Argumente zulassen
}

% A Normal Information Box (Accentcolor bar on the left)
\newtcolorbox{infoBox}[1][]{
    colback=\thepagecolor, %Hintergrundfarbe
    colframe=accentcolor, % Randfarbe
    coltext=.,
    frame hidden,
    title style=gray,
    arc=\boxarc,
    boxrule=0pt,
    left=5pt, % Links Platz lassen
    enhanced, % Erlaubt uns, den ramen zu zeichnen
    fonttitle=\sffamily, % Titelschriftart auf 
    overlay={ % Für Grauen Bereich links
            \begin{tcbclipinterior}
                \fill[accentcolor] (frame.south west) rectangle ([xshift=4pt]frame.north west); % Zeilennummernbereich färben
            \end{tcbclipinterior}
        },
    #1 % Weitere Argumente zulassen
}

% An Important Information Box (Accentcolor bar on the left+ light Accentcolor BG)
\newtcolorbox{defBox}[1][]{
    colback=\IfDarkModeTF{accentcolor!20!\thepagecolor}{accentcolor!10!\thepagecolor}, %Hintergrundfarbe
    colframe=accentcolor, % Randfarbe
    coltext=.,
    frame hidden,
    title style=accentcolor,
    arc=\boxarc,
    boxrule=0pt,
    left=5pt, % Links Platz lassen
    enhanced, % Erlaubt uns, den ramen zu zeichnen
    fonttitle=\sffamily, % Titelschriftart auf 
    overlay={ % Für Grauen Bereich links
            \begin{tcbclipinterior}
                \fill[accentcolor] (frame.south west) rectangle ([xshift=4pt]frame.north west); % Zeilennummernbereich färben
            \end{tcbclipinterior}
        },
    #1 % Weitere Argumente zulassen
}

\IfShellEscapeTF{

    \tcbuselibrary{minted}

    % Minted Line Number Styling
    \renewcommand{\theFancyVerbLine}{\tikz{\coordinate(a);\node[text width=5mm,inner sep=0pt,align=center]{\ttfamily\textcolor{white}{\scriptsize\arabic{FancyVerbLine}}};}}

    % Environment für meinen Code-Style (Arg 1 = minted Options, Arg 2 = tcolorbox Options)
    \definecolor{codebg}{RGB}{22,43,58}
    \newtcblisting{codeBlock}[2][]{
        listing engine=minted, % Minted verwenden
        colback=\IfDarkModeTF{codebg}{black!10!\thepagecolor}, %Hintergrundfarbe
        colframe=black!70, % Randfarbe
        coltext=.,
        listing only,  % Sonst will er den Plain Text nach dem Minted Listing noch anfügen
        frame hidden,
        boxrule=0pt,
        arc=\boxarc,
        %hbox, % This option could be used to limit the Length of Code Blocks automatically, but does not work with the minted Line Numbers
        title style=\IfDarkModeTF{accentcolor!60!black}{black!90},
        minted style=\IfDarkModeTF{paraiso-dark}{default}, %Sieht actually worse aus imo
        minted language=java, % Sprache setzen
        minted options={ %Minted Optionen
                linenos=true,
                numbersep=3mm,
                texcl=true,
                #1 % weitere optionen für Minted zulassen
            },
        left=7.1mm, % Links Platz lassen
        enhanced, % Erlaubt uns, den ramen zu zeichnen
        fonttitle=\sffamily, % Titelschriftart auf 
        overlay={ % Für Grauen Bereich links
                \begin{tcbclipinterior}
                    \fill[black!70] (frame.south west) rectangle ([xshift=5mm]frame.north west); % Zeilennummernbereich färben
                \end{tcbclipinterior}
            },
        #2 % Weitere Argumente zulassen
    }

}{
    \lstnewenvironment{codeBlock}[2][]{}{}%
}
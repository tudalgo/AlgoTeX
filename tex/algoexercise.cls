% FOP and AuD Exercise template class
% Author: Ruben Deisenroth
\def\fileversion{2.2.7}
\def\filedate{2022/08/27}

% Sets the LaTeX version for the package to work.
\NeedsTeXFormat{LaTeX2e}

% LateX 3 Syntax
\RequirePackage{expl3}

% Identification of the class and its date and version.
\ProvidesExplClass{algoexercise}{\filedate}
{\fileversion}{Exercise sheet template class for FOP and AuD}

% Used by CI/CD to inject options
\IfFileExists{options.cfg}{\input{options.cfg}}{}

% Environment options
% hidepoints
\sys_get_shell:nnN { kpsewhich ~ --var-value ~ HIDE_POINTS } { } \l_hide_points_env_var_tl
\tl_trim_spaces:N \l_hide_points_env_var_tl
\tl_if_eq:NnT \l_hide_points_env_var_tl {1} {\PassOptionsToClass{hidepoints}{algoexercise}}
% showtotalpoints
\sys_get_shell:nnN { kpsewhich ~ --var-value ~ SHOW_TOTAL_POINTS } { } \l_show_total_points_env_var_tl
\tl_trim_spaces:N \l_show_total_points_env_var_tl
\tl_if_eq:NnT \l_show_total_points_env_var_tl {1} {\PassOptionsToClass{showtotalpoints}{algoexercise}}
% solution
\sys_get_shell:nnN { kpsewhich ~ --var-value ~ SOLUTION } { } \l_solution_env_var_tl
\tl_trim_spaces:N \l_solution_env_var_tl
\tl_if_eq:NnT \l_solution_env_var_tl {1} {\PassOptionsToClass{solution=true}{algoexercise}}

\RequirePackage[minted_workaround,caption_workaround]{algo-common}

% Packages that need to be loaded before TUDA-Exercise Class
\PassOptionsToPackage{bookmarksnumbered}{hyperref} % Nummerierte Bookmarks

\prop_new:N \g_algo_ex_opts_prop
\bool_gset_true:N \g_algo_ex_corporate_design_bool

\tl_gclear_new:N \g_algoexercise_keys_tl
\tl_gset:Nn \g_algoexercise_keys_tl {
    boxarc .code:n = \PassOptionsToPackage{\CurrentOption}{algo-common},
    dark_mode .code:n = \PassOptionsToPackage{\CurrentOption}{algo-common},
    load_common .bool_gset:N = \g_algo_ex_load_common_bool,
    load_common .initial:n = false,
    load_common . default:n = true,
    fancy_row_color .code:n = \PassOptionsToPackage{\CurrentOption}{algo-common},
    shell_escape .code:n = \PassOptionsToPackage{\CurrentOption}{algo-common},
    manual_term .bool_gset:N = \g_manual_term_bool,
    manual_term .initial:n = false,
    manual_term .default:n = true,
    maxdifficulty .code:n = \prop_gput:Nnn \g_algo_ex_opts_prop {maxdifficulty} {#1},
    maxdifficulty .initial:n = {3},
    maxdifficulty .default:n = {3},
    inlineshortcut .code:n = \prop_gput:Nnn \g_algo_ex_opts_prop {inlineshortcut} {#1},
    inlineshortcut .initial:n = {java},
    inlineshortcut .default:n = {java},
    logopath .code:n = \prop_gput:Nnn \g_algo_ex_opts_prop {logopath} {#1},
    logopath .initial:n = {tuda_logo},
    logopath .default:n = {tuda_logo},
    showpoints .bool_gset:N = \g_algo_ex_show_points_bool,
    showpoints .initial:n = true,
    showpoints .default:n = true,
    % corporatedesign .bool_gset:N = \g_algo_ex_corporate_design_bool,
    % corporatedesign .initial:n = false,
    % corporatedesign .default:n = true,
    hidepoints .bool_gset_inverse:N = \g_algo_ex_show_points_bool,
    hidepoints .initial:n = false,
    hidepoints .default:n = true,
    showtotalpoints .bool_gset:N = \g_algo_ex_show_total_points_bool,
    showtotalpoints .initial:n = true,
    showtotalpoints .default:n = true,
    hidetotalpoints .bool_gset_inverse:N = \g_algo_ex_show_total_points_bool,
    hidetotalpoints .initial:n = false,
    hidetotalpoints .default:n = true,
    titleprefix .tl_gset:N = \g_algo_ex_title_prefix_tl,
    titleprefix .default:n = {},
    titleprefix .initial:n = {},
    template .code:n = \prop_gput:Nnn \g_algo_ex_opts_prop {template} {#1},
    template .default:n = {},
    template .initial:n = {},
    fop .meta:n = {template=fop},
    aud .meta:n = {template=aud},
}
% Additional Class Options
\exp_args:Nno \keys_define:nn {ptxcd/exercise} { \g_algoexercise_keys_tl }
\exp_args:Nno \keys_define:nn {algo/exercise} { \g_algoexercise_keys_tl }
% Compatibility with older versions (We can't use version check makros before loading the class)
\exp_args:Nno \keys_define:nn {TUDa/pub} { \g_algoexercise_keys_tl }
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{tudaexercise}}
\ProcessOptions\relax
% \ProcessKeysOptions{algo/exercise}

\bool_if:NTF \g_algo_ex_corporate_design_bool {
    \LoadClass[
        colorback=false,
        points=true,
        footsepline=.5pt,
        parskip,
        color=3b,
        T1,
    ]{tudaexercise}
}{
    \DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
    \ProcessOptions\relax
    \LoadClass[12pt, a4paper]{article}
}

\RequirePackage{algo-snippets}
\RequirePackage{tcolorbox}
\tcbuselibrary{skins}
\RequirePackage{enumitem}
\RequirePackage{amssymb}
\RequirePackage{caption}
\RequirePackage{cprotect}
\RequirePackage{subcaption}
\RequirePackage{nameref}
\RequirePackage{fontawesome5}
\RequirePackage{regexpatch}

\ifPDFTeX
    \RequirePackage[utf8]{inputenc}
\fi
\RequirePackage{csquotes}
\RequirePackage[german, ngerman]{babel}

\prg_new_conditional:Nnn \__ptxcd_if_corporatedesign: {T,F,TF} {
    \bool_if:NTF \g_algo_ex_corporate_design_bool {
        \prg_return_true:
    } {
        \prg_return_false:
    }
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

    \tl_gclear_new:N \g_tuda_pkg_prefix_tl
    \IfTudaciVersionAtLeastTF{3.0}{
        \tl_gset:Nn \g_tuda_pkg_prefix_tl {ptxcd}
    }{
        \tl_gset:Nn \g_tuda_pkg_prefix_tl {TUDa}
    }
    \DeclareDocumentCommand{\tudaPkgPrefix}{}{
        \tl_use:N \g_tuda_pkg_prefix_tl
    }
}

% \RequirePackage{parskip}

% \RequirePackage{pifont}

%%--Document Properties--%%
% Datesubject
\tl_gclear_new:N \datename
\tl_gset:Nn \datename {Datum}
\tl_gclear_new:N \printDate
\renewcommand*{\date}[1]{
    \tl_gset:Nn \@date {#1}
    \tl_if_empty:NF \@date {\tl_gset:Nn \printDate {\textsf{\textbf{\datename{}:~}}\@date}}
}

\tl_gclear_new:N \printAuthor
\renewcommand*{\author}[1]{
    \exp_args:Nc \seq_gset_split:Nnn {g_ \tudaPkgPrefix _author_seq} {\and} {#1}
    \seq_if_empty:cF {g_ \tudaPkgPrefix _author_seq} {\tl_gset:Nn \printAuthor {\int_compare:nTF{\seq_count:c {g_ \tudaPkgPrefix _author_seq} > 1}{Übungsblattbetreuer}{Übungsblattbetreuer}:~\hfill\seq_use:cnnn {g_ \tudaPkgPrefix _author_seq} {~\authorandname{}~} {,~} {~\authorandname{}~}\par}}
}

\DeclareDocumentCommand{\sheetnumber}{s O{2} m}{
    \bool_if:nTF {#1} {
        \tl_gset:cx { g_ \tudaPkgPrefix _ex_sheetnum_tl} {#3}
    }{
        \tl_gset:cx { g_ \tudaPkgPrefix _ex_sheetnum_tl} {\padzeroes[#2]{#3}}
    }
}
% Sheet number
\newcommand*{\getSheetnumber}{
    \tl_use:c { g_ \tudaPkgPrefix _ex_sheetnum_tl }
}
\newcommand*{\printSheetNumber}{\tl_if_empty:cF {g_ \tudaPkgPrefix _ex_sheetnum_tl} {\sffamily\textbf{Übungsblatt\space{}Nummer:}\space\getSheetnumber}}

% Sheet Version
\DeclareDocumentProperty{version}[1.0][v*]

% Short title
\newcommand*{\getShorttitle}{
    \tl_use:c {g_ \tudaPkgPrefix _shorttitle_tl}
}

% Semester
\DeclareDocumentProperty{semester}[][*]

% Fachbereich
\DeclareDocumentProperty{fachbereich}[][\textsf{\textbf{Fachbereich:~}*}]

% Fach
\DeclareDocumentProperty*{fach}[][\textsf{\textbf{Fach:~}*}]

% Supervisor (Sheet maintainer)
\DeclareDocumentProperty{supervisor}[][Übungsblatt-Betreuer:\hfill *]

% Topics
\DeclareDocumentProperty{topics}[][Themen:\hfill *]

% Slides
\DeclareDocumentProperty{slides}[][Relevante~Foliensätze:~\hfill *]

% Duedate
\DeclareDocumentProperty{duedate}[][Abgabe~der~Hausübung:\hfill *]

% Dozent
\DeclareDocumentProperty{dozent}[][\textsf{\textbf{Dozent:~}*}]

%%--Templates--%%
\str_case_e:nnTF {\prop_item:Nn \g_algo_ex_opts_prop {template}} {
    {fop} {
        % \setkomavar{subject}[Funktionale~und~objektorientierte~Programmierkonzepte]{FOP}
        \fach[Funktionale~und~objektorientierte~Programmierkonzepte]{FOP}
        \tl_gset:Nn \g_algo_ex_title_prefix_tl {\getFach*{}}
    }
    {aud} {
        % \setkomavar{subject}[Algorithmen~und~Datenstrukturen]{AuD}
        \fach[Algorithmen~und~Datenstrukturen]{AuD}
        \tl_gset:Nn \g_algo_ex_title_prefix_tl {\getFach*{}}
    }
} {%⟨true code ⟩
    \bool_if:NF \g_algo_ex_corporate_design_bool  {
        \RequirePackage[
            left=2.5cm, right=2.5cm, top=3.5cm, bottom=2cm,
            headheight=1cm, headsep=1.5cm,
            footnotesep=0.3cm, footskip=1cm]{geometry}
    }
    \RequirePackage{graphicx}

    \bool_if:NF \g_algo_ex_corporate_design_bool  {
        \RequirePackage{fancyhdr}

        \pagestyle{fancy}
        \fancyhf{}
        \fancyhead[L]{\usekomavar*{subject}}
        \fancyhead[R]{\@title}
        \fancyfoot[C]{\thepage}
    }
} {%⟨false code ⟩

}

\newcommand\algoexercise@stars[2]{
    \newcount\currentstar
    \currentstar=0
    \loop \ifnum \currentstar < #2
    \ifnum
        \currentstar < #1 \ding{72}
    \else
        \ding{73}
    \fi
    \advance \currentstar 1 \repeat
}

\clist_new:N \g_rubos_ex_term_order_clist
\clist_gset:Nn \g_rubos_ex_term_order_clist {printSemester,printContributor,printVersion,quad,quad,printDate,printFachbereich}
\newcommand*{\termOrder}[1]{\tl_gset:Nn \g_rubos_ex_term_order_clist {#1}}

\tl_gclear_new:c { g_ \tudaPkgPrefix _ex_term_style_tl }
\newcommand*{\termStyle}[1]{\tl_gset:cn { g_ \tudaPkgPrefix _ex_term_style_tl } {#1}}
\termStyle{left-right}
\seq_gclear_new:c { g_ \tudaPkgPrefix _term_left_seq }
\seq_gclear_new:c { g_ \tudaPkgPrefix _term_right_seq }
\newcommand{\termLeft}[1]{
    \clist_gclear_new:c { g_ \tudaPkgPrefix _temp_clist }
    \tl_gset:cn { g_ \tudaPkgPrefix _temp_clist } {#1}
    \clist_map_inline:cn { g_ \tudaPkgPrefix _temp_clist } {
        \tl_if_empty:cF {##1} {
            \seq_put_right:cn { g_ \tudaPkgPrefix _term_left_seq } {\use:c {##1}}
        }
    }
}
\newcommand{\termRight}[1]{
    \clist_gclear_new:c { g_ \tudaPkgPrefix _temp_clist }
    \tl_gset:cn { g_ \tudaPkgPrefix _temp_clist } {#1}
    \clist_map_inline:cn { g_ \tudaPkgPrefix _temp_clist } {
        \tl_if_empty:cF {##1} {
            \seq_put_right:cn { g_ \tudaPkgPrefix _term_right_seq } {\use:c {##1}}
        }
    }
}

\termStyle{left-right-manual}
% \termOrder{printAuthor,printSheetNumber,printGroupNumber,printContributor,printVersion,,printSemester,printDate,printFachbereich}
\termLeft{}
\termRight{}
\term{
    \printAuthor{}
    \printSemester{}\hfill\printVersion{}\\
    \printTopics{}\\
    \printSlides{}\\
    \printDuedate{}
}

\renewcommand*{\@maketitle}{%
    % \maketerm{}% Might Move Term Creation here soon
    \global\@topnum=\z@
    \setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
    \vspace*{-\dim_eval:n {
            \headheight
            - \dim_use:c { c_ \tudaPkgPrefix _largerule_dim } - \dim_use:c { c_ \tudaPkgPrefix _rulesep_dim }
            +\headsep
            +\ht\strutbox
            +\p@
        }
    }
    \par
    \nointerlineskip
    \begingroup
    \setlength{\fboxsep}{\z@}
    \dim_zero_new:N \l_tmpa_logo_height_dim
    \dim_set:Nn \l_tmpa_logo_height_dim {\dim_use:c { c_ \tudaPkgPrefix _logoheight_dim }}
    \bool_if:cT {g_ \tudaPkgPrefix _colorback_bool} {\colorbox{accentcolor}}{\parbox[t]{\linewidth}{
            \rule{0pt}{\bool_if:cTF {g_ \tudaPkgPrefix _smalltitle_bool} {.25} {.5}\l_tmpa_logo_height_dim}
            \par\nointerlineskip
            \raisebox{-\height}{%
                \begin{minipage}[t]{\dimexpr\linewidth-2.2\l_tmpa_logo_height_dim-1ex}
                    \bool_if:cT {g_ \tudaPkgPrefix _colorback_bool}  {
                        \begin{addmargin}{3mm}}
                            \raggedright
                            \bool_if:cT {g_ \tudaPkgPrefix _colorback_bool} {\color{textonaccentcolor}}
                            \tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
                            \leavevmode\usekomafont{title}%
                            {\usekomafont{title}\bool_if:cTF {g_ \tudaPkgPrefix _smalltitle_bool} {\LARGE} {\huge} {\tl_if_blank:nF {\g_algo_ex_title_prefix_tl} {\g_algo_ex_title_prefix_tl\par}\@title\par}}%
                            \vskip 1em
                            \bool_if:cF {g_ \tudaPkgPrefix _ex_compatibility_bool}
                            {
                                {\ifx
                                        \@subtitle\@empty
                                    \else
                                        \usekomafont{subtitle}\@subtitle\par
                                    \fi
                                }%
                                \gdef\@subtitle{}
                                \vskip .5em
                            }
                            % Standart Author Position
                            % {
                            %   \xdef\@author {\@author}
                            %   \ifx\@author\@empty\else\usekomafont{author}\@author\par\fi
                            % }
                            % \usekomafont{author}Rückfragen~zu~diesem~Übungsblatt~vorzugsweise~im~\\~moodle-Forum~zu~diesem~Blatt!\par
                            \vskip .5em
                            \bool_if:cTF {g_ \tudaPkgPrefix _colorback_bool} {
                        \end{addmargin}
                    } {\par}
                \end{minipage}
            }
            \tl_if_empty:cF {g_ \tudaPkgPrefix _logofile_tl} {
                \hfill\raisebox{\dim_eval:n {
                        \bool_if:cTF {g_ \tudaPkgPrefix _colorback_bool}
                        {-\height}
                        {-.9\l_tmpa_logo_height_dim}
                    }}
                [0pt]
                [\dim_eval:n {
                        \bool_if:cTF {g_ \tudaPkgPrefix _smalltitle_bool}
                        {\bool_if:cTF {g_ \tudaPkgPrefix _colorback_bool} {1.15}{1}}
                        {\bool_if:cTF {g_ \tudaPkgPrefix _colorback_bool} {1.5}{1.3}
                        }\l_tmpa_logo_height_dim}]
                {\makebox[2.2\l_tmpa_logo_height_dim][l]{\includegraphics[height=\l_tmpa_logo_height_dim]{\tl_use:c {g_ \tudaPkgPrefix _logofile_tl}}}}
            }
            \par\medskip
        }
    }
    \par
    \nointerlineskip
    \rule{\linewidth}{\dim_use:c {g_ \tudaPkgPrefix _titlerule_dim}}
    % subtitle fields if not compat
    \exp_args:Nf \tl_if_empty:nF {\seq_use:cnnn {g_ \tudaPkgPrefix _author_seq} {~\authorandname{}~} {,~} {~\authorandname{}~}\tl_use:c {g_ \tudaPkgPrefix _ex_sheetnum_tl} \@date \tl_use:c {g_ \tudaPkgPrefix _ex_term_tl} \use:c {@subsubtitle} \@subtitle}{
        \par\nointerlineskip
        \bool_if:cT {g_ \tudaPkgPrefix _colorback_bool} {\colorbox{accentcolor}}{
            \parbox{\linewidth}{
                \begin{minipage}{\linewidth}
                    \bool_if:cT {g_ \tudaPkgPrefix _colorback_bool} {
                        \color{textonaccentcolor}
                        \begin{addmargin}{3mm}
                            }
                            \null\par
                            % Term
                            \bool_if:NTF \g_manual_term_bool{
                                \tl_use:c {g_ \tudaPkgPrefix _ex_term_tl}
                            }
                            {
                                \str_case_e:nnF {\tl_use:c {g_ \tudaPkgPrefix _ex_term_style_tl}} {
                                    {manual} {
                                        \tl_use:c {g_ \tudaPkgPrefix _ex_term_tl}
                                    }
                                }{
                                    \def\ptxcd_nextsep{}
                                    \bool_gset_true:N \g_tmpa_left_bool
                                    \clist_map_inline:Nn \g_rubos_ex_term_order_clist {
                                        % Process different term Styles
                                        \str_case_e:nnF {\tl_use:c {g_ \tudaPkgPrefix _ex_term_style_tl}} {
                                            {left} {
                                                \tl_if_empty:cF {##1} {
                                                    \seq_put_right:cn {\bool_if:nTF \g_tmpa_left_bool {g_ \tudaPkgPrefix _term_left_seq} {g_ \tudaPkgPrefix _term_right_seq}} {\use:c {##1}}
                                                }
                                            }
                                            {center} {
                                                \tl_if_empty:cF {##1} {
                                                    \seq_put_right:cn {\bool_if:nTF \g_tmpa_left_bool {g_ \tudaPkgPrefix _term_left_seq} {g_ \tudaPkgPrefix _term_right_seq}} {\use:c {##1}}
                                                }
                                            }
                                            {left-right} {
                                                \tl_if_empty:cF {##1} {
                                                    \seq_put_right:cn {\bool_if:nTF \g_tmpa_left_bool {g_ \tudaPkgPrefix _term_left_seq} {g_ \tudaPkgPrefix _term_right_seq}} {\use:c {##1}}\bool_set:Nn \g_tmpa_left_bool {!\g_tmpa_left_bool}
                                                }
                                            }
                                            {left-right-manual} {
                                                % Do Nothing lol
                                            }
                                        }
                                        {
                                            \ClassError{rubos_tuda_template}{Unknown Term style Option: \tl_use:c {g_ \tudaPkgPrefix _ex_term_style_tl}}{Available options are: left, center, left-right (default)}
                                        }
                                    }
                                    % Left Side
                                    \begin{minipage}[t]{\seq_if_empty:cF {g_ \tudaPkgPrefix _term_right_seq}{.6}\linewidth}
                                        \str_if_eq:eeT{\tl_use:c {g_ \tudaPkgPrefix _ex_term_style_tl}} {center} {\centering}
                                        \seq_use:cnnn {g_ \tudaPkgPrefix _term_left_seq} {\mbox{}\par} {\mbox{}\par} {\mbox{}\par}
                                        \gdef\ptxcd_nextsep{\par}
                                    \end{minipage}
                                    \seq_if_empty:cF {g_ \tudaPkgPrefix _term_right_seq}{
                                        \begin{minipage}[t]{.4\linewidth}
                                            \raggedleft
                                            \begin{flushright}
                                                \seq_use:cnnn {g_ \tudaPkgPrefix _term_right_seq} {\mbox{}\par} {\mbox{}\par} {\mbox{}\par}
                                            \end{flushright}
                                            \gdef\ptxcd_nextsep{\par}
                                        \end{minipage}
                                    }
                                    % \vspace{-\abovedisplayskip}
                                    \bool_if:nT { !\seq_if_empty_p:c {g_ \tudaPkgPrefix _term_left_seq} || !\seq_if_empty_p:c {g_ \tudaPkgPrefix _term_right_seq} } {
                                        \vspace*{\lineskip}
                                        \par
                                    }
                                    \tl_if_empty:cF {g_ \tudaPkgPrefix _ex_term_tl} {\tl_use:c {g_ \tudaPkgPrefix _ex_term_tl}}
                                    % \clist_map_inline:nn {@subtitle, @subsubtitle, g_ptxcd_ex_term_tl} {
                                    %   \tl_if_empty:cF {##1} {\ptxcd_nextsep\use:c {##1}\def\ptxcd_nextsep{\\}}
                                    % }
                                    % \tl_if_empty:NF \g_ptxcd_ex_sheetnum_tl {\ptxcd_nextsep\sheetname\sheetsep\g_ptxcd_ex_sheetnum_tl}
                                }
                            }

                            \bool_if:cT {g_ \tudaPkgPrefix _colorback_bool} {
                        \end{addmargin}
                    }
                \end{minipage}
                \vspace*{\dp\strutbox}
            }
        }
        \par\nointerlineskip
        \rule{\linewidth}{\dim_use:c {g_ \tudaPkgPrefix _titlerule_dim}}
    }
    \par
    \bool_if:cT  {g_ \tudaPkgPrefix _headontitle_bool} {
        \if@twoside
            \box_use:c {g_ \tudaPkgPrefix _ex_headline_odd_box}
        \else
            \box_use:c {g_ \tudaPkgPrefix _ex_headline_oneside_box}
        \fi
        \par
        \rule{\linewidth}{\dim_use:c {g_ \tudaPkgPrefix _titlerule_dim}}
        \par
    }
    \endgroup
    % \vskip 2em
    \ConfigureHeadline{}
}%

\IfDarkModeT{
    \IfFileExists{tuda_logo_inverted.pdf}{\tl_gset:cn {g_ \tudaPkgPrefix _logofile_tl} {tuda_logo_inverted.pdf}}{}
}

\IfCorporateDesignT{
    % Custom Headline Style
    \clist_map_inline:nn {odd, even, oneside} {
        \exp_args:Nf \keys_define:nn {\tudaPkgPrefix/exercise/headline} {
            #1 .choice:,
            #1 / title-name-id .code:n = \tl_gset:cn {g_ \tudaPkgPrefix _ex_headline_#1_tl} {
                \getShorttitle
                \par
                \StudentName
                \StudentID
            },
            #1 / title-name .code:n = \tl_gset:cn {g_ \tudaPkgPrefix _ex_headline_#1_tl} {
                \getShorttitle\par
                \smallskip
                \StudentName
            },
            #1 / title .code:n = \tl_gset:cn {g_ \tudaPkgPrefix _ex_headline_#1_tl} {\getShorttitle},
            #1 / fulltitle-centered .code:n = \tl_gset:cn {g_ \tudaPkgPrefix _ex_headline_#1_tl} {
                \centering
                \textbf{\textsf{\@title}
                }
            },
            #1 / name-id .code:n = \tl_gset:cn {g_ \tudaPkgPrefix _ex_headline_#1_tl} {
                \StudentName
                \StudentID
            },
            #1 / name .code:n = \tl_gset:cn {g_ \tudaPkgPrefix _ex_headline_#1_tl} {
                \StudentName
            },
            #1 / algo .code:n = \tl_gset:cn {g_ \tudaPkgPrefix _ex_headline_#1_tl} {
                \textsf{\textbf{\getFach{}\space{}}
                    im\space\fatsf{\getSemester{}}\space{}
                    bei\space\fatsf{\getDozent{}}\hfill\fatsf{\@title}~--~\getShorttitle\par
                    \StudentName\StudentID}
            },
            #1 / algo-min .code:n = \tl_gset:cn {g_ \tudaPkgPrefix _ex_headline_#1_tl} {
                \textsf{\textbf{\getFach{}\space{}}
                    im\space\fatsf{\getSemester{}}\space{}
                    bei\space\fatsf{\getDozent{}}\hfill\fatsf{\@title}~--~\getShorttitle}
            },
            % Backwards Compatibility
            #1 / aud .meta:n = {#1 / algo = ##1},
            #1 / aud-min .meta:n = {#1 / algo-min = ##1},
        }
    }
}

% Stilistische Anpassungen der Task-Environments
\renewcommand*{\taskformat}{\rmfamily\bfseries \thetask{}} % Taskprefix
\renewcommand*{\subtaskformat}{\thesubtask\enskip} % This looks way cleaner
\tl_gclear_new:c { g_algo_ex_taskgroup_prefix_tl }
\tl_gset:cn { g_algo_ex_taskgroup_prefix_tl } {H}
\int_gzero_new:N \g_algo_ex_taskoffset_int
\DeclareExpandableDocumentCommand{\nextTaskGroup}{m}{
    \tl_gset:cn { g_algo_ex_taskgroup_prefix_tl } {#1}
    \int_gset:Nn \g_algo_ex_taskoffset_int {\value{task}}
}
\renewcommand*{\thetask}{%
    \tl_use:c {g_algo_ex_taskgroup_prefix_tl} \int_eval:n {\value{task} - \g_algo_ex_taskoffset_int}
}
\renewcommand*{\thesubtask}{%
    \tl_use:c {g_algo_ex_taskgroup_prefix_tl} \int_eval:n {\value{task} - \g_algo_ex_taskoffset_int}.\arabic{subtask}%
}
% Point Formating
\cs_set_eq:NN \__old_pointformat \pointformat
\DeclareDocumentCommand{\pointformat}{O{\g_algo_ex_show_points_bool}m}{
    \bool_if:nTF {#1} {
        \__old_pointformat{#2}
    }{
        \bool_if:cTF {l__ \tudaPkgPrefix _points_auto_bool}
        \creditformatsum
        \creditformat
        {
            ??\space\PointsName
        }
    }
}
\renewcommand*{\creditformat}[1]{#1}
\renewcommand*{\subtaskformat}{\thesubtask{} :\enskip}

% Section Fonts
\setkomafont{section}{\large\bfseries\sffamily}
\setkomafont{subsection}{\normalsize\bfseries\sffamily}
\setkomafont{subsubsection}{\normalsize\bfseries\sffamily}
% Task Fonts
\setkomafont{task}{\normalfont\large\bfseries}
\setkomafont{subtask}{\normalfont\bfseries}


\fp_gzero_new:c {l_algo_ex_vue_max_difficulty_fp}
\newcommand*{\setmaxdifficulty}[1]{
    \fp_gset:Nn \l_algo_ex_vue_max_difficulty_fp {#1}
}
\setmaxdifficulty{5}
\DeclareDocumentCommand{\vue}{m}{
    \nextTaskGroup{V}
    \fp_gset:Nn \l_algo_ex_vue_max_difficulty_fp {#1}
    \unskip\section*{
            Vorbereitende~Übungen\hfill %\textmd{\textrm{(Bearbeitung~ist~freiwillig)}}
            %\textmd{max.~\fp_to_decimal:c {l_algo_ex_vue_max_difficulty_fp}~Punkte}
        }
}

% #1 Hausübungsnummer
% #2 Hausübungstitel
% #3 Gesamtpunktzahl
% #4 Optional: Punktzahlformat (* wird mit Gesamtpuntzahl replaced)
\DeclareDocumentCommand{\hue}{mmmO{
        Gesamt:~\pointformat[\g_algo_ex_show_total_points_bool]{*}
    }}{
    \nextTaskGroup{H}
    \tl_clear_new:N \l_algo_ex_hue_totpoints_fp
    \tl_set:Nn \l_algo_ex_hue_totpoints_fp {#3}
    \tl_set:Nn \l_algo_ex_hue_pointformat_tl {#4}
    \regex_replace_all:nnN {\*} {\u{l_algo_ex_hue_totpoints_fp}} \l_algo_ex_hue_pointformat_tl
    \unskip\section*{
            #1\hfill \l_algo_ex_hue_pointformat_tl
            \\\textrm{\textit{#2}}
        }
}

% Compatibility with old Sheets
% #1 - Title
% #2 - Points
\DeclareDocumentCommand{\hueaufgabe}{mm}{
    \task[points=#2]{#1}
}

% Compatibility with old Sheets
% #1 - Title
% #2 - Points
\DeclareDocumentCommand{\hueteilaufgabe}{mm}{
    \subtask[points=#2,title={#1}]{}
}

% Description-list styling.
\SetLabelAlign{parright}{\parbox[t]{\labelwidth}{\raggedleft#1}}
\setlist[description]{style = multiline, leftmargin = 4cm, align = parright,font=\mdseries}

\IfTudaciVersionBetweenTF{3.0}{3.26}{
    \DeclareDocumentEnvironment{subtask*}{om}{
        \begingroup
        \IfNoValueF{#1}{\keys_set:nn {ptxcd/subtask}{#1}}
        \@subtask{#2}
        \tl_gset_eq:NN \g_tmpa_tl \@currentlabel
        \endgroup
        \tl_set_eq:NN \@currentlabel \g_tmpa_tl
    }{}
}{}



% Better Task Titles
\IfTudaciVersionAtLeastTF{3.13}{
    \renewcommand*\sectionlinesformat[4]{%
        \parbox{\linewidth}{
            \bool_if:cT {g__ptxcd_ruled_#1_bool} {
                \rule[5\g_ptxcd_titlerule_dim]{\linewidth}{\g_ptxcd_titlerule_dim}\par\nointerlineskip
            }
            \@hangfrom{%
                \hskip #2#3}{
                \tl_if_eq:nnT {#1} {task} {
                    \exp_args:No \tl_if_empty:nF {#4}
                    {:~}
                    \bool_if:NT \l__ptxcd_points_auto_bool {
                        \exp_args:NNf \prop_get:NnN \g__ptxcd_loaded_points_prop {\thetask} \l_ptxcd_tmp_tl
                        \quark_if_no_value:NF \l_ptxcd_tmp_tl {
                            \fp_set:Nn \l_ptxcd_ex_task_points_fp {\l_ptxcd_tmp_tl}
                        }
                    }
                }
                {#4\ensuremath{\vcenter{\hbox{\tikz{\node[inner~sep=0pt, text~height=1.1em]{};}}}}}% Übungstitel mit Seriefen
                \tl_if_in:nnT {#1} {task} {
                    \hfill\tl_if_empty:cTF{l_ptxcd_ex_#1_credit_tl}
                    {\pointformat{\fp_to_decimal:c {l_ptxcd_ex_#1_points_fp}}}
                    {\creditformat{\tl_use:c {l_ptxcd_ex_#1_credit_tl}}}
                    \fp_compare:nT {\l_algo_ex_vue_difficulty_fp >= 0} {
                        \quad{}\textbf{
                            %Schwierigkeit:~
                            \starrating{\l_algo_ex_vue_difficulty_fp}{\l_algo_ex_vue_max_difficulty_fp}
                        }
                    }
                }
                \rule[-\dp\strutbox]{0pt}{\dp\strutbox}\par}\nointerlineskip
            \skip_vertical:n {\ptxcd_titlerule_sep: -\dp\strutbox}
            \bool_if:cT {g__ptxcd_ruled_#1_bool} {\smash{\rule{\linewidth}{\g_ptxcd_titlerule_dim}}}
        }}
}{}

\AtBeginDocument{
    \regex_match:nVT {SNAPSHOT} \g_rubos_document_version_tl {
        % Make all points red
        \DeclareDocumentCommand{\pointformat}{O{\g_algo_ex_show_points_bool}m}{
            \textcolor{red}{
                \bool_if:nTF {#1} {
                    \__old_pointformat{#2}
                }{
                    \bool_if:cTF {l__ \tudaPkgPrefix _points_auto_bool}
                    \creditformatsum
                    \creditformat
                    {
                        ??\space\PointsName
                    }
                }
            }
        }
        % Add (SNAPSHOT) to the title
        %\tl_clear_new:N \l_old_title_tl
        %\tl_set:Nn \l_old_title_tl {\getTitle}
        %\exp_args:Nf \title[\getShortTitle{}]{\tl_use:c{l_old_title_tl}~\textcolor{red}{(Entwurf)}}
        % CI_RUN environment check (enable if CI_RUN=1)
        \sys_get_shell:nnN { kpsewhich ~ --var-value ~ CI_RUN } { } \l_ci_run_env_var_tl
        \tl_trim_spaces:N \l_ci_run_env_var_tl
        \tl_if_eq:NnT \l_ci_run_env_var_tl {1} {
            \appto\@maketitle{
                \box_clear_new:N \l_entwurf_box
                \vbox_set:Nn \l_entwurf_box {
                    \UseSnippet{entwurf-nicht-abgeben}
                }
                \vspace{-\box_ht:N \l_entwurf_box}
                \box_use:N \l_entwurf_box
            }
        }
        % Make stars red
        \tikzset{
            scorestar/.style={
                draw=red,
                star,
                star~points=5,
                star~point~ratio=2.25,
                inner~sep=1.3pt,
                anchor=outer~point~3,
            },
        }
    }
}

% Difficulty
\keys_define:nn {ptxcd/task}{
    difficulty .choice:,
    difficulty / max .meta:n ={difficulty=\l_algo_ex_vue_max_difficulty_fp},
    difficulty / min .meta:n ={difficulty=0},
    difficulty / unknown .code:n = \fp_set:Nn \l_algo_ex_vue_difficulty_fp {#1},
    difficulty .initial:n = {-1},
    difficulty .default:n = {-1},
}

\keys_define:nn {ptxcd/subtask}{
    difficulty .choice:,
    difficulty / max .meta:n ={difficulty=\l_algo_ex_vue_max_difficulty_fp},
    difficulty / min .meta:n ={difficulty=0},
    difficulty / unknown .code:n = \fp_set:Nn \l_algo_ex_vue_difficulty_fp {#1},
    difficulty .initial:n = {-1},
    difficulty .default:n = {-1},
}

\def\fileversion{1.3.5}
\def\filedate{2021/11/18}

% Sets the LaTeX version for the package to work.
\NeedsTeXFormat{LaTeX2e}

% LateX 3 Syntax
\RequirePackage{expl3}

% Identification of the class and its date and version.
\ProvidesExplClass{fopslides}{\filedate}
{\fileversion}{FOP Beamer Presentation Template}

\RequirePackage[minted_workaround,caption_workaround]{rubos-common}

% \DeclareGraphicsExtensions{.pdf,.png,.jpg}
\RequirePackage[table, dvipsnames]{xcolor}
\RequirePackage{pagecolor} % Used for dark Mode
\bool_gset_false:N \g_is_summary_bool
\bool_gset_false:N \g_is_main_file_bool
\bool_gset_false:N \g_ptxcd_ex_load_common_bool
\bool_gset_true:N \g_ptxcd_ex_fancy_rowcolor_bool
\tl_gclear_new:N \datename
\tl_gset:Nn \datename {Datum}
\tl_gclear_new:N \g_rubos_external_label_prefix_tl
\tl_gset:Nn \g_rubos_external_label_prefix_tl {ext:}

\tl_gclear_new:N \g_rubos_keys_tl
\tl_gset:Nn \g_rubos_keys_tl {
    boxarc .code:n = \PassOptionsToPackage{\CurrentOption}{rubos-common},
    dark_mode .code:n = \PassOptionsToPackage{\CurrentOption}{rubos-common},
    load_common .bool_gset:N = \g_ptxcd_ex_load_common_bool,
    load_common .initial:n = false,
    load_common . default:n = true,
    fancy_row_color .code:n = \PassOptionsToPackage{\CurrentOption}{rubos-common},
    shell_escape .code:n = \PassOptionsToPackage{\CurrentOption}{rubos-common},
    main .bool_gset:N = \g_is_main_file_bool,
    main .initial:n = false,
    main .default:n = true,
}
% Additional Class Options
\exp_args:Nno \keys_define:nn {ptxcd/beamer} { \g_rubos_keys_tl }
% Compatibility with older versions (We can't use version check makros before loading the class)
\exp_args:Nno \keys_define:nn {TUDa/beamer} { \g_rubos_keys_tl }

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{tudabeamer}}
\ProcessOptions\relax
% \ProcessKeyvalOptions{boxarc}\relax
\LoadClass[]{tudabeamer}

%Includes
\RequirePackage[ngerman]{babel}
\RequirePackage{float}
\RequirePackage{fontawesome}
\RequirePackage[babel]{csquotes}
\RequirePackage{media9}
\RequirePackage{animate}
\RequirePackage[overlay]{textpos}
\RequirePackage{tuda-pgfplots}
\RequirePackage{graphicx}
\RequirePackage{subcaption}
\RequirePackage{listings}
% \RequirePackage[style=numeric]{biblatex}
\RequirePackage{amsmath, amsthm, amssymb}
\RequirePackage[squaren]{SIunits}
\RequirePackage[straightvoltages]{circuitikz}
\RequirePackage{caption}[2013/01/01] % needs v3.3 or newer
\RequirePackage{tikz}
\pgfplotsset{compat=1.18}
\RequirePackage{tabularx,colortbl}
\ExplSyntaxOff
\usetikzlibrary{matrix, calc, positioning, chains, shapes, arrows}
\ExplSyntaxOn

\usepackage{linguex}

\let\linguex@footnotetext\@footnotetext
\let\@footnotetext\predefinedfootnotetext
\AtBeginDocument{%
    \let\predefinedfootnotetext\@footnotetext
    \let\@footnotetext\linguex@footnotetext
}

\def\fopexercise@boxarc{\prop_item:Nn \g_rubos_document_opts_prop {boxarc}} % Used for Code Blocks, Info boxes, etc.
\tl_new:N \l_listings_boxed_options_tl
\keys_define:nn { listings/boxed }
{
    caption .tl_set:N = \l_listings_boxed_caption_tl,
    shortcaption .tl_set:N = \l_listings_boxed_shortcaption_tl,
    label .tl_set:N = \l_listings_boxed_label_tl,
    unknown .code:n =
    \tl_put_right:NV \l_listings_boxed_options_tl \l_keys_key_tl
    \tl_put_right:Nn \l_listings_boxed_options_tl { = #1 , },
}
\box_new:N \l_listings_boxed_box

\lstnewenvironment{blstlisting}[1][]
{
    \keys_set:nn { listings/boxed } { #1 }
    \exp_args:NV \lstset \l_listings_boxed_options_tl
    \hbox_set:Nw \l_listings_boxed_box
}
{
    \hbox_set_end:
    \cs_set_eq:cc {c@figure} {c@lstlisting}
    \tl_set_eq:NN \figurename \lstlistingname
    \tl_if_empty:NF \l_listings_boxed_caption_tl
    {
        \tl_if_empty:NTF \l_listings_boxed_shortcaption_tl
        {
            \captionof{figure}{\l_listings_boxed_caption_tl}
        }
        {
            \captionof{figure}[\l_listings_boxed_shortcaption_tl]{\l_listings_boxed_caption_tl}
        }
        \tl_if_empty:NF \l_listings_boxed_label_tl { \label{\l_listings_boxed_label_tl} }
    }
    \leavevmode\box_use:N \l_listings_boxed_box
}

\newcommand{\slidehead}{\frametitle{\insertsectionhead} \framesubtitle{\insertsubsectionhead\int_compare:nF {\exp_args:No \str_count_ignore_spaces:n {\insertsubsubsectionhead}<1} {~---~\insertsubsubsectionhead}}\vspace{3mm}}
\newcommand{\tocslide}{\begin{frame}[t]\frametitle{Inhaltsverzeichnis}\vspace{3mm}{\small\tableofcontents[subsectionstyle=shaded]}\end{frame}}

\IfDarkModeT{
    \cs_if_exist:NT \setbeamercolor {
        \setbeamercolor*{smallrule}{bg=.}
        \setbeamercolor*{normal~text}{bg=,fg=.}
        \setbeamercolor*{background~canvas}{parent=normal~text}
        \setbeamercolor*{section~in~toc}{parent=normal~text}
        \setbeamercolor*{subsection~in~toc}{parent=normal~text,fg=.}
        \setbeamercolor*{footline}{parent=normal~text}
        \setbeamercolor{block~title~alerted}{fg=white,bg=white!20!\thepagecolor}
        \setbeamercolor*{block~body}{bg=black!70!gray!98!blue}
        \setbeamercolor*{block~body~alerted}{bg=\thepagecolor}
    }
    \cs_if_exist:NT \setbeamertemplate {
        \setbeamertemplate{subsection~in~toc~shaded}[default][50]
    }
}
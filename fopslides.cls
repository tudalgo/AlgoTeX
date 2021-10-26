\def\fileversion{1.3.4}
\def\filedate{2021/07/26}

% Sets the LaTeX version for the package to work.
\NeedsTeXFormat{LaTeX2e}
% Identification of the class and its date and version.
\ProvidesClass{fopslides} [\filedate\space\fileversion\space]



% \DeclareGraphicsExtensions{.pdf,.png,.jpg}

\ExplSyntaxOn
\bool_gset_false:N \g_dark_mode_bool
\bool_gset_false:N \g_is_summary_bool
\bool_gset_false:N \g_is_main_file_bool
\bool_gset_false:N \g_ptxcd_ex_load_common_bool
\bool_gset_true:N \g_ptxcd_ex_fancy_rowcolor_bool
\tl_gclear_new:N \datename
\tl_gset:Nn \datename {Datum}
\tl_gclear_new:N \g_rubos_external_label_prefix_tl
\tl_gset:Nn \g_rubos_external_label_prefix_tl {ext:}
\prop_new:N \g_ptxcd_template_opts_prop

\tl_gclear_new:N \g_rubos_keys_tl
\tl_gset:Nn \g_rubos_keys_tl {
    boxarc .code:n = \prop_gput:Nnn \g_ptxcd_template_opts_prop {boxarc} {#1},
    boxarc .initial:n = {0pt},
    boxarc .default:n = {3pt},
    dark_mode .code:n = \pagecolor{rubos@anthrazitgrau}\color{white}\selectcolormodel{RGB}\bool_gset_true:N \g_dark_mode_bool,
    load_common .bool_gset:N = \g_ptxcd_ex_load_common_bool,
    load_common .initial:n = false,
    load_common . default:n = true,
    default_row_color .bool_gset_inverse:N = \g_ptxcd_ex_fancy_rowcolor_bool,
    default_row_color .initial:n = false,
    default_row_color .default:n = true,
    shell_escape .bool_gset:N = \g_rubos_shell_escape_bool,
    shell_escape .initial:n = true,
    shell_escape .default:n = true,
    main .bool_gset:N = \g_is_main_file_bool,
    main .initial:n = false,
    main .default:n = true,
}
% Additional Class Options
\exp_args:Nno \keys_define:nn {ptxcd/exercise} { \g_rubos_keys_tl }
% Compatibility with older versions (We can't use version check makros before loading the class)
\exp_args:Nno \keys_define:nn {TUDa/pub} { \g_rubos_keys_tl }
\ExplSyntaxOff

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{tudabeamer}}
\ProcessOptions\relax
% \ProcessKeyvalOptions{boxarc}\relax
\LoadClass[]{tudabeamer}

%Includes
\RequirePackage{float}
\RequirePackage{minted}
\RequirePackage[babel]{csquotes}
\RequirePackage{media9}
\RequirePackage{animate}
\RequirePackage[overlay]{textpos}
\RequirePackage{tuda-pgfplots}
\RequirePackage[utf8]{inputenc}
\RequirePackage{graphicx}
\RequirePackage{subcaption}
\RequirePackage{listings}
% \RequirePackage[style=numeric]{biblatex}
\RequirePackage{amsmath, amsthm, amssymb}
\RequirePackage[squaren]{SIunits}
\RequirePackage[straightvoltages]{circuitikz}
\RequirePackage{caption}[2013/01/01] % needs v3.3 or newer
\RequirePackage{tikz}
\RequirePackage{tabularx,colortbl}
\usetikzlibrary{matrix, calc, positioning, chains, shapes,arrows}

\ExplSyntaxOn
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

\ExplSyntaxOff

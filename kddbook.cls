%#!ptex2pdf -l -u -ot '--synctex=1' -od '-z 3' readme-kddbook
% #!ptex2pdf -l -u -ot '--synctex=1' -od '-z 3' test-kddbook
%%
%% Copyright (c) 2019 Kindai kagaku sha, Impress Group Company.
%% All rights reserved.
%%
\ifx\epTeXinputencoding\undefined\else
  \epTeXinputencoding utf8
\fi
\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{kddbook}
%% based on 2019/01/01 v5.0 Green Cherry Ltd. A5 book pLaTeX class
%%          ujarticle.cls 2011/05/07 v1.6_u00 Standard upLaTeX class
  [2019/05/17 v0.9 Kindai kagaku sha Digital Book pLaTeX class]

\def\grnchry@error{\ClassError{kddbook}}
\def\grnchry@warning{\ClassWarning{kddbook}}
\def\grnchry@warningnoline{\ClassWarningNoLine{kddbook}}
\def\grnchry@info{\ClassInfo{kddbook}}

%% hook at end of grnchry local
\let\@endofgrnchrylocalhook\@empty
\def\AtEndOfGrnChryLocal{%
  \g@addto@macro\@endofgrnchrylocalhook}
\@onlypreamble\AtEndOfGrnChryLocal

\AtBeginDocument{%%<= for kddbook.cls
%% run \@endofgrnchrylocalhook at the end of local style
\@ifundefined{@endofgrnchrylocalhook}{}{%
\let\AtEndOfGrnChryLocal\@firstofone
\@endofgrnchrylocalhook}
}

%% fixes to LaTeX2e
\RequirePackage{fix-cm}%%\RequirePackage{fix-cm,exscale}
\IfFileExists{latexrelease.sty}{}{\RequirePackage{fixltx2e}}

%% amsmath: override \@ifstar with \new@ifnextchar in amsgen.sty
\let\ltx@ifstar\@ifstar%%as \@ifstar of LaTeX kernel

%% graphicx: added nosetpagesize
\IfFileExists{platexrelease.sty}{%% is bundled in TL16 or higher release version
\PassOptionsToPackage{nosetpagesize}{graphicx}%%for TL16 or higher version
}{}

\RequirePackage{xkeyval}%%,etoolbox

%% useful helpers
\newcount\grnchry@cnta
\newcount\grnchry@cntb
\newcount\grnchry@cntc
\newif\ifgrnchry@swa
\newif\ifgrnchry@swb
\newif\ifgrnchry@swc
\newdimen\grnchry@dima
\newdimen\grnchry@dimb
\newdimen\grnchry@dimc
\newbox\grnchry@boxa
\newbox\grnchry@boxb
\newbox\grnchry@boxc
\newskip\grnchry@skipa
\newskip\grnchry@skipb
\newskip\grnchry@skipc
\newtoks\grnchry@tokena
\newtoks\grnchry@tokenb
\newtoks\grnchry@tokenc

\newcommand\grnchry@get@p@[2]{%
  \edef#2{\expandafter\@grnchry@GET@P@\the#1}}
{\catcode`p=12\catcode`t=12\gdef\@grnchry@GET@P@#1pt{#1}}%

\long\def\@ifempty#1{\@xifempty#1@@..\@nil}
\long\def\@xifempty#1#2@#3#4#5\@nil{%
  \ifx#3#4\expandafter\@firstoftwo\else\expandafter\@secondoftwo\fi}
\long\def\@ifnotempty#1{\@ifempty{#1}{}}
% \newcommand\@nonmath[1]{\toks@\@emptytoks
%   \expandafter\@skipmath\expandafter\@empty#1$$%
%   \edef#1{{\noexpand\protect\the\toks@}}%
% }
% \newcommand{\@skipmath}{}
% \long\def\@skipmath#1$#2${%
%   \@xskipmath#1\(\)%
%   \@ifnotempty{#2}{\toks@\expandafter{\the\toks@$#2$}\@skipmath\@empty}}%
% \newcommand{\@xskipmath}{}
% \long\def\@xskipmath#1\(#2\){%
%   \toks@\expandafter\expandafter\expandafter{\expandafter\the\expandafter\toks@#1}%
%   \@ifnotempty{#2}{\toks@\expandafter{\the\toks@\(#2\)}\@xskipmath\@empty}}%
% \newtoks\@emptytoks

% \newcommand*{\grnchry@DeclareOption}[2]{%
%   \DeclareOptionX{#1}{%
%     \@ifempty{##1}{}{%
%       \ClassError{grnchry}{The option #1 should have no value}{\@ehc}}%
%     #2}}

\newif\if@kddbkfleqn \@kddbkfleqnfalse
\newif\if@kddbkcapnumin \@kddbkcapnumintrue
\newif\if@cameraready \@camerareadyfalse
\newif\if@pdfhyperlink \@pdfhyperlinkfalse
\newif\if@spreadbleedbox \@spreadbleedboxfalse
\newif\if@hanmen \@hanmenfalse
\newif\if@mentuke \@mentukefalse
% \newif\if@restonecol
\newif\if@openright \@openrighttrue
\newif\if@frontmatter \@frontmatterfalse
\newif\if@mainmatter \@mainmattertrue
\newif\if@backmatter \@backmatterfalse
\newif\if@appendix \@appendixfalse
\newif\if@enablejfam \@enablejfamtrue
\DeclareOptionX{spreadbleedbox}{\@spreadbleedboxtrue}
\DeclareOptionX{hanmen}{\@hanmentrue}
\hour\time \divide\hour by 60\relax
\grnchry@cnta\hour \multiply\grnchry@cnta 60\relax
\minute\time \advance\minute-\grnchry@cnta
\DeclareOptionX{tombow}{%
  \tombowtrue \tombowdatetrue
  \setlength{\@tombowwidth}{.1\p@}%
  \@bannertoken{%
     \jobname\space(\number\year-\two@digits\month-\two@digits\day
     \space\two@digits\hour:\two@digits\minute)}%
  \maketombowbox}
\DeclareOptionX{tombo}{%
  \tombowtrue \tombowdatefalse
  \setlength{\@tombowwidth}{.1\p@}%
  \maketombowbox}
\DeclareOptionX{mentuke}{%
  \tombowtrue \tombowdatefalse \@mentuketrue
  \setlength{\@tombowwidth}{\z@}%
  \maketombowbox}
\DeclareOptionX{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOptionX{twoside}{\@twosidetrue \@mparswitchtrue}
\DeclareOptionX{onecolumn}{\@twocolumnfalse}
\DeclareOptionX{twocolumn}{\@twocolumntrue}
% \DeclareOptionX{openright}{\@openrighttrue}
% \DeclareOptionX{openany}{\@openrightfalse}
\DeclareOptionX{fleqn}{\@kddbkfleqntrue}
\DeclareOptionX{nofleqn}{\@kddbkfleqnfalse}
\DeclareOptionX{nocapnumin}{\@kddbkcapnuminfalse}
\DeclareOptionX{disablejfam}{\@enablejfamfalse}
\DeclareOptionX{draft}{\setlength\overfullrule{5\p@}}
\DeclareOptionX{final}{\setlength\overfullrule{0\p@}}
% \DeclareOption{dvipdfmx}{\gdef\pgfsysdriver{pgfsys-dvipdfmx.def}}%Tikz/PGF

%% PDF出力default preview/print/pdf
\DeclareOptionX{cameraready}[print]{\gdef\grnchry@cameraready{#1}}
\DeclareOptionX{media}{\gdef\grnchry@cameraready{#1}}
%% 用紙サイズ default
\DeclareOptionX{paper}[a5]{\gdef\grnchry@paper{#1}}
%% 埋め込む和文書体mapファイルプロファイル default haranoaji/sourcehanjp
\DeclareOptionX{pdf:kanjimap}[haranoaji]{\gdef\grnchry@pdf@kanjimap{#1}}

%% <selector>:break-before=page,left,right
%% 前付け開始直前改丁頁
\DeclareOptionX{frontmatter:break-before}[right]{%
  \gdef\grnchry@frontmatter@@breakbefore{#1}}
%% 本文開始直前改丁頁
\DeclareOptionX{mainmatter:break-before}[right]{%
  \gdef\grnchry@mainmatter@@breakbefore{#1}}
%% 後付け開始直前改丁頁
\DeclareOptionX{backmatter:break-before}[right]{%
  \gdef\grnchry@backmatter@@breakbefore{#1}}
%% 付録開始直前改丁頁
\DeclareOptionX{appendix:break-before}[right]{%
  \gdef\grnchry@appendix@@breakbefore{#1}}
%% 目次開始直前改丁頁
\DeclareOptionX{toc:break-before}[page]{%right
  \gdef\grnchry@toc@@breakbefore{#1}}
%% 索引開始直前改丁頁
\DeclareOptionX{idx:break-before}[page]{%right
  \gdef\grnchry@idx@@breakbefore{#1}}

\ExecuteOptionsX{twoside,onecolumn,fleqn,final,%
  cameraready,paper,pdf:kanjimap,%
  frontmatter:break-before,mainmatter:break-before,backmatter:break-before,%
  appendix:break-before,toc:break-before,idx:break-before}
\ProcessOptionsX\relax

%% compatibility for nxtpubclsbk-a5kdd.cls, nxtpubclsbk-b5kdd.cls
\def\nxtpub@ruby@@fontsizescale{0.5385}


\if@kddbkfleqn
  \input{fleqn.clo}%%has supported latexrelease.sty
  \AtEndOfClass{\mathindent1.5385zw\relax}%%別行立て数式：左寄せ字下げ
  \PassOptionsToPackage{fleqn}{amsmath}%%is loaded from newpxmath
  \def\eqnarray{%
    \stepcounter{equation}%
    \def\@currentlabel{\p@equation\theequation}%
    \global\@eqnswtrue\m@th
    \global\@eqcnt\z@
    \tabskip\mathindent
    \let\\=\@eqncr
    \setlength\abovedisplayskip{\topsep}%
    \ifvmode
      \addtolength\abovedisplayskip{\partopsep}%
    \fi
    \addtolength\abovedisplayskip{\parskip}%
    \setlength\belowdisplayskip{\abovedisplayskip}%
    \setlength\belowdisplayshortskip{\abovedisplayskip}%
    \setlength\abovedisplayshortskip{\abovedisplayskip}%
    $$\everycr{}\halign to\linewidth% $$
    \bgroup
      \hskip\@centering$\displaystyle\tabskip\z@skip{##}$\@eqnsel
      &\global\@eqcnt\@ne \hfil$\displaystyle{{}##{}}$\hfil
      &\global\@eqcnt\tw@
        $\displaystyle{##}$\hfil \tabskip\@centering
      &\global\@eqcnt\thr@@ \hb@xt@\z@\bgroup\hss##\egroup
    \tabskip\z@skip\cr}%
\else
  \def\eqnarray{%
     \stepcounter{equation}%
     \def\@currentlabel{\p@equation\theequation}%
     \global\@eqnswtrue
     \m@th
     \global\@eqcnt\z@
     \tabskip\@centering
     \let\\\@eqncr
     $$\everycr{}\halign to\displaywidth\bgroup
         \hskip\@centering$\displaystyle\tabskip\z@skip{##}$\@eqnsel
        &\global\@eqcnt\@ne \hfil$\displaystyle{{}##{}}$\hfil
        &\global\@eqcnt\tw@ $\displaystyle{##}$\hfil\tabskip\@centering
        &\global\@eqcnt\thr@@ \hb@xt@\z@\bgroup\hss##\egroup
           \tabskip\z@skip
        \cr}%
\fi

\def\grnchry@tmp{preview}\ifx\grnchry@cameraready\grnchry@tmp
  \@camerareadyfalse \@pdfhyperlinkfalse
\else\def\grnchry@tmp{print}\ifx\grnchry@cameraready\grnchry@tmp
  \@camerareadytrue \@pdfhyperlinkfalse
\else\def\grnchry@tmp{pdf}\ifx\grnchry@cameraready\grnchry@tmp
  \@camerareadytrue \@pdfhyperlinktrue
\else
  \grnchry@error{No such value of cameraready: \grnchry@cameraready}%
\fi\fi\fi

\hoffset\z@ \voffset\z@
\newdimen\pdfcutoffset \pdfcutoffset=4mm\relax
\newdimen\pdfpaperwidth  \pdfpaperwidth\paperwidth
\newdimen\pdfpaperheight \pdfpaperheight\paperheight

%% define/set specific paper(s)
\def\grnchry@define@paper#1#2#3{%
  %% \paper@<papername>=> <size>:<width>x<height>+<cutoffset>
  \@namedef{grnchry@paper@#1}{#1:#2x#3+0mm}%
  \@namedef{grnchry@paper@#1+3mm}{#1:#2x#3+3mm}%
  \@namedef{grnchry@paper@#1+3.17mm}{#1:#2x#3+3.17mm}%
  \@namedef{grnchry@paper@#1+4mm}{#1:#2x#3+4mm}%
}
\let\DefinePaper\grnchry@define@paper

\def\grnchry@set@paper#1{%
  \@ifundefined{grnchry@paper@#1}{%
    \grnchry@error{Not define such paper: #1}}\relax
  \expandafter\expandafter\expandafter
    \@grnchry@set@paper\expandafter\expandafter\expandafter
      {\csname grnchry@paper@#1\endcsname}}
\def\@grnchry@set@paper#1{\@@grnchry@set@paper#1\@nil}
\def\@@grnchry@set@paper#1:#2x#3+#4\@nil{%
  \def\grnchry@papersize{#1}%
  \def\grnchry@paperwidth{#2}%
    \setlength\paperwidth{#2}%
  \def\grnchry@paperheight{#3}%
    \setlength\paperheight{#3}%
  \def\grnchry@papercutoffset{#4}%
    \setlength\hoffset{#4}\setlength\voffset{#4}%
  %%
  %% for setting \pdfpaper{width,height}
  \iftombow
    \hoffset\pdfcutoffset \voffset\pdfcutoffset
  \fi
  \setlength\pdfpaperwidth{\dimexpr\paperwidth + 2\hoffset}%
  \setlength\pdfpaperheight{\dimexpr\paperheight + 2\voffset}%
}
\let\SetPaper\grnchry@set@paper

\DefinePaper{a5}{148mm}{210mm}
\DefinePaper{b5}{182mm}{257mm}
\SetPaper{\grnchry@paper}

%% set kihon hanmen + footskip
\def\grnchry@set@kihonhanmen#1{\@grnchry@set@kihonhanmen#1\@nil}
\def\@grnchry@set@kihonhanmen#1:#2:#3:#4;#5:#6\@nil{%
  \gdef\grnchry@Qnum{#1}\gdef\grnchry@Wnum{#2}%
  \gdef\grnchry@Lnum{#3}\gdef\grnchry@Hnum{#4}%
  \gdef\grnchry@head{#5}\gdef\grnchry@gutter{#6}%
}

\newif\if@bvpaper \@bvpaperfalse
\def\grnchry@tmp{a5}\ifx\grnchry@papersize\grnchry@tmp
  \grnchry@set@kihonhanmen{13:33:31:22;23.5mm:25mm}%
  \@bvpaperfalse
  \setlength\footskip{10mm}%%=18.5mm - 8.5mm
\else\def\grnchry@tmp{b5}\ifx\grnchry@papersize\grnchry@tmp
  \grnchry@set@kihonhanmen{13:43:39:22;23.5mm:25mm}%
  \@bvpapertrue
  \setlength\footskip{12.5mm}%%=21.5mm - 9mm
\fi\fi

%% override QWLH, head, gutter

%% calculate font size scaler

\newif\if@grnchry@uptex \@grnchry@uptexfalse
\ifx\ucs\@undefined\else \ifnum\ucs"3000="3000
  \@grnchry@uptextrue
  \PassOptionsToPackage{uplatex}{otf}
\fi\fi
\def\grnchry@JYn{\if@grnchry@uptex JY2\else JY1\fi}%
\def\grnchry@JTn{\if@grnchry@uptex JT2\else JT1\fi}%
\def\grnchry@pfx@{\if@grnchry@uptex up\else \fi}%
\def\grnchry@sfx@{\if@grnchry@uptex \else n\fi}%
\def\grnchry@sc@le{\if@grnchry@uptex 0.924714\else 0.961026\fi}%
\def\grnchry@brsg@pfx@{}%

\PassOptionsToPackage{scale=\grnchry@sc@le}{otf}

\def\grnchry@jisrh{\grnchry@pfx@ jis\if@grnchry@uptex r-h\fi}%
\def\grnchry@jisgh{\grnchry@pfx@ jisg\if@grnchry@uptex -h\fi}%
\def\grnchry@jisrv{\grnchry@pfx@ jis\if@grnchry@uptex r\fi -v}%
\def\grnchry@jisgv{\grnchry@pfx@ jisg-v}%

\newdimen\JQ \JQ=1.08141Q\relax

%% declare static font definitions

%% declare relative font definitions
%% <family>: mc (reserved), gt (reserved), mgt?
%% <series>: m (reserved), bx (reserved), eb?
%% <shape>: n (reserved)
%% JYn
\DeclareFontShape{\grnchry@JYn}{mc}{m}{n}{%
  <-> s * [\grnchry@sc@le] \grnchry@jisrh
}{}
\DeclareFontShape{\grnchry@JYn}{gt}{m}{n}{%
  <-> s * [\grnchry@sc@le] \grnchry@jisgh
}{}
\DeclareFontShape{\grnchry@JYn}{mc}{bx}{n}{<->ssub*gt/m/n}{}
\DeclareFontShape{\grnchry@JYn}{gt}{bx}{n}{<->ssub*gt/m/n}{}
\DeclareFontShape{\grnchry@JTn}{mc}{m}{n}{%
  <-> s * [\grnchry@sc@le] \grnchry@jisrv
}{}
\DeclareFontShape{\grnchry@JTn}{gt}{m}{n}{%
  <-> s * [\grnchry@sc@le] \grnchry@jisgv
}{}
\DeclareFontShape{\grnchry@JTn}{mc}{bx}{n}{<->ssub*gt/m/n}{}
\DeclareFontShape{\grnchry@JTn}{gt}{bx}{n}{<->ssub*gt/m/n}{}

\def\grnchry@ssub@extshape#1{%
  \@for\grnchry@x:={m,bx,ul,el,l,dl,r,mb,db,sb,b,eb,h,eh,u,uh}\do{%
    \@for\grnchry@xx:={it,sl,sc}\do{%
      \DeclareFontShape{\grnchry@JYn}{#1}{\grnchry@x}{\grnchry@xx}{<->ssub*#1/\grnchry@x/n}{}%
      \DeclareFontShape{\grnchry@JTn}{#1}{\grnchry@x}{\grnchry@xx}{<->ssub*#1/\grnchry@x/n}{}%
    }%
  }%
}
\grnchry@ssub@extshape{mc}
\grnchry@ssub@extshape{gt}

\DeclareRobustCommand\rmfamily
  {\not@math@alphabet\rmfamily\mathrm
   \romanfamily\rmdefault\kanjifamily\mcdefault\selectfont}
\DeclareRobustCommand\sffamily
  {\not@math@alphabet\sffamily\mathsf
   \romanfamily\sfdefault\kanjifamily\gtdefault\selectfont}
\DeclareRobustCommand\ttfamily
  {\not@math@alphabet\ttfamily\mathtt
   \romanfamily\ttdefault\kanjifamily\gtdefault\selectfont}

%%[ad-hoc] a trick to put upstyle single quotes literally in PDF
\begingroup
\catcode`'=\active
\catcode``=\active
\g@addto@macro\@noligs{%
  \def\lmtt@textquotesingle{{\useroman{T1}{lmtt}{m}{n}\textquotesingle}}%
  \def\lmtt@textasciigrave{{\useroman{T1}{lmtt}{m}{n}\textasciigrave}}%
  \let'\lmtt@textquotesingle
  \let`\lmtt@textasciigrave}
\endgroup

\DeclareRobustCommand\bfseries
  {\not@math@alphabet\bfseries\mathbf
   \sffamily\fontseries\bfdefault
   \kanjifamily\gtdefault\kanjiseries{bx}\selectfont}

%%do not need below in TeX Live 2010 or higher version
%% \def\textmc#1{\relax\ifmmode\hbox\fi{\mcfamily #1}}
%% \def\textgt#1{\relax\ifmmode\hbox\fi{\gtfamily #1}}

% \DeclareRobustCommand\itshape
%   {\not@math@alphabet\itshape\mathit
%    \fontfamily{xptm}\fontshape\itdefault\selectfont}

\if@enablejfam
  \DeclareSymbolFont{mincho}{\grnchry@JYn}{mc}{m}{n}
  \DeclareSymbolFontAlphabet{\mathmc}{mincho}
  \SetSymbolFont{mincho}{bold}{\grnchry@JYn}{gt}{m}{n}
  \jfam\symmincho
  \DeclareMathAlphabet{\mathgt}{\grnchry@JYn}{gt}{m}{n}
  \AtBeginDocument{%
    \reDeclareMathAlphabet{\mathrm}{\mathrm}{\mathmc}
    \reDeclareMathAlphabet{\mathbf}{\mathbf}{\mathgt}
  }%
\fi
%FIXME: あとで全部 obsolete に変更する
%% obsolete some old font commands for LaTeX 2.09
\DeclareOldFontCommand{\mc}{\normalfont\mcfamily}{\mathmc}
\DeclareOldFontCommand{\gt}{\normalfont\gtfamily}{\mathgt}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*{\cal}{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*{\mit}{\@fontswitch\relax\mathnormal}

%% modified ursfs.fd 1998/03/24 rsfs font definition file (jk)
\DeclareFontFamily{U}{rsfs}{\skewchar\font127 }
\DeclareFontShape{U}{rsfs}{m}{n}{%
  <-6>  rsfs5
  <6-8> rsfs7
  <8->  rsfs10
}{}

%% from mathrsfs.sty 1996/01/01 Math RSFS package v1.0 (jk)
\DeclareSymbolFont{rsfs}{U}{rsfs}{m}{n}
\DeclareSymbolFontAlphabet{\mathscr}{rsfs}

\if@cameraready
%% otf + lmodern
\RequirePackage[T1]{fontenc}\RequirePackage{textcomp}%T1/TS1
\RequirePackage{lmodern}
\input t1lmr.fd
\input t1lmss.fd
\DeclareFontShape{T1}{lmr}{l}{n}{<->sub*lmr/m/n}{}
\DeclareFontShape{T1}{lmss}{eb}{n}{<->sub*lmss/bx/n}{}

\RequirePackage[deluxe,jis2004]{otf}
\grnchry@ssub@extshape{hmc}
\grnchry@ssub@extshape{hgt}
\grnchry@ssub@extshape{mg}

\DeclareRobustCommand\ltseries{\not@math@alphabet\ltseries\relax
  \romanseries\ltdefault\kanjiseries\ltdefault\selectfont}
\DeclareRobustCommand\ebseries{\not@math@alphabet\ebseries\relax
  \romanseries\ebdefault\kanjiseries\ebdefault\selectfont}
\DeclareRobustCommand\mgfamily{\not@math@alphabet\mgfamily\mathmg\relax
  \romanfamily\sfdefault\kanjifamily\mgdefault\selectfont}
\DeclareRobustCommand\textmc[1]{%
    \relax\ifmmode \expandafter\nfss@text \fi{\mcfamily #1}}
\DeclareRobustCommand\textgt[1]{%
    \relax\ifmmode \expandafter\nfss@text \fi{\gtfamily\sffamily #1}}
\DeclareTextFontCommand{\textlt}{\mcfamily\ltseries}
\DeclareTextFontCommand{\texteb}{\gtfamily\sffamily\ebseries}
\DeclareRelationFont{\otf@JYn}{hmc}{l}{}{\otf@OTorT1}{lmr}{l}{}
\DeclareRelationFont{\otf@JTn}{hmc}{l}{}{\otf@OTorT1}{lmr}{l}{}
\DeclareRelationFont{\otf@JYn}{hmc}{m}{}{\otf@OTorT1}{lmr}{m}{}
\DeclareRelationFont{\otf@JTn}{hmc}{m}{}{\otf@OTorT1}{lmr}{m}{}
\DeclareRelationFont{\otf@JYn}{hmc}{bx}{}{\otf@OTorT1}{lmr}{bx}{}
\DeclareRelationFont{\otf@JTn}{hmc}{bx}{}{\otf@OTorT1}{lmr}{bx}{}
\DeclareRelationFont{\otf@JYn}{hgt}{m}{}{\otf@OTorT1}{lmss}{m}{}
\DeclareRelationFont{\otf@JTn}{hgt}{m}{}{\otf@OTorT1}{lmss}{m}{}
\DeclareRelationFont{\otf@JYn}{hgt}{bx}{}{\otf@OTorT1}{lmss}{bx}{}
\DeclareRelationFont{\otf@JTn}{hgt}{bx}{}{\otf@OTorT1}{lmss}{bx}{}
\DeclareRelationFont{\otf@JYn}{hgt}{eb}{}{\otf@OTorT1}{lmss}{bx}{}
\DeclareRelationFont{\otf@JTn}{hgt}{eb}{}{\otf@OTorT1}{lmss}{bx}{}
\DeclareRelationFont{\otf@JYn}{mg}{m}{}{\otf@OTorT1}{lmss}{m}{}
\DeclareRelationFont{\otf@JTn}{mg}{m}{}{\otf@OTorT1}{lmss}{m}{}

%% use newpx
\RequirePackage[scaled=1.05]{newpxtext}%%requires T1/TS1 (fontenc, textcomp)
%% If you wish to use \usepackage{amsthm},
%% place it before loading newtxmath or the result will be
%% ! LaTeX Error: Command \openbox already defined.
\AtBeginDocument{%
\RequirePackage{newpxmath}%%requires amsmath
}
\input t1zpltlf.fd
\DeclareFontShape{T1}{zpltlf}{l}{n}{<->sub*zpltlf/m/n}{}

%FIXME: AJ1 原ノ味フォント に置き換える？
%% load specified kanji map
\AtBeginDvi{\special{pdf:mapfile nxtpub-kddbookcls-\grnchry@pdf@kanjimap}}%
\fi

\renewcommand{\normalsize}{%
  \@setfontsize\normalsize{\grnchry@Qnum\JQ}{\grnchry@Hnum H}%
  \abovedisplayskip .5\Cvs \@plus.125\Cvs \@minus.25\Cvs
  \abovedisplayshortskip \z@ \@plus.15\Cvs
  \belowdisplayshortskip .3\Cvs \@plus.15\Cvs \@minus.15\Cvs
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\interfootnotelinepenalty\@M\relax
\hyphenpenalty\@M\relax
\exhyphenpenalty\@M\relax
\normalsize

\setbox0\hbox{\char\jis"3441}%"
\setlength\Cht{\ht0}
\setlength\Cdp{\dp0}
\setlength\Cwd{\wd0}
\setlength\Cvs{\baselineskip}
\setlength\Chs{\wd0}
\setbox0=\box\voidb@x

\newcommand{\small}{%
  \@setfontsize\small{11\JQ}{17H}%
  \abovedisplayskip .4\Cvs \@plus.15\Cvs \@minus.2\Cvs
  \abovedisplayshortskip \z@ \@plus.1\Cvs
  \belowdisplayshortskip .2\Cvs \@plus.1\Cvs \@minus.1\Cvs
  \def\@listi{\leftmargin\leftmargini
              \topsep .15\Cvs \@plus.05\Cvs \@minus.1\Cvs
              \parsep .1\Cvs \@plus.05\Cvs \@minus.05\Cvs
              \itemsep \parsep}%
  \belowdisplayskip \abovedisplayskip}
\newcommand{\footnotesize}{%
  \@setfontsize\footnotesize{10\JQ}{15H}
  \abovedisplayskip .3\Cvs \@plus.1\Cvs \@minus.2\Cvs
  \abovedisplayshortskip \z@ \@plus.05\Cvs
  \belowdisplayshortskip .15\Cvs \@plus.05\Cvs \@minus.1\Cvs
  \def\@listi{\leftmargin\leftmargini
              \topsep .1\Cvs \@plus.05\Cvs \@minus.05\Cvs
              \parsep .1\Cvs \@plus.05\Cvs \@minus.05\Cvs
              \itemsep \parsep}%
  \belowdisplayskip \abovedisplayskip}
\newcommand{\scriptsize}{\@setfontsize\scriptsize{9\JQ}{11H}}
\newcommand{\tiny}{\@setfontsize\tiny{6\JQ}{7H}}
\newcommand{\large}{\@setfontsize\large{18\JQ}{27H}}
\newcommand{\Large}{\@setfontsize\Large{20\JQ}{30H}}
\newcommand{\LARGE}{\@setfontsize\LARGE{24\JQ}{36H}}
\newcommand{\huge}{\@setfontsize\huge{28\JQ}{42H}}
\newcommand{\Huge}{\@setfontsize\Huge{32\JQ}{48H}}

\def\displaymath@smallskip@setup{%
  \abovedisplayskip .225\Cvs \@plus.1\Cvs \@minus.1\Cvs
  \abovedisplayshortskip .125\Cvs \@plus.1\Cvs
  \belowdisplayshortskip .175\Cvs \@plus.1\Cvs \@minus.1\Cvs
  \belowdisplayskip \abovedisplayskip
}

\newdimen\hanmenwidth
\newdimen\hanmenheight

%% 上
\setlength\topskip{\Cwd}
\setlength\headheight{12mm}%%= 23.5mm - 10.5mm
\setlength\headsep{14mm}%%=23.5mm - 7mm - 2.5mm(10Q)
%% 下
%%\setlength\footskip{10mm}%%<= already given
\setlength\maxdepth{\dimexpr1.5\Cwd - \topskip\relax}

%% 字詰め数、行数
\setlength\textwidth{\grnchry@Wnum\Cwd}
\setlength\textheight{\grnchry@Lnum\Cvs}
\addtolength\textheight{-\Cvs}\addtolength\textheight{\Cwd}
\addtolength\textheight{1H}%

\setlength\hanmenwidth{\textwidth}
\setlength\hanmenheight{\textheight}

%% no supported marginpar parameters
\setlength\marginparsep{2zw}%{\z@}
\setlength\marginparwidth{10zw}%{\z@}
\setlength\marginparpush{10H}%{\z@}

%% save original \textwidth, \hanmenwidth, \marginparsep, \marginparwidth
\newdimen\clone@textwidth          \setlength\clone@textwidth{\textwidth}
\newdimen\clone@hanmenwidth        \setlength\clone@hanmenwidth{\hanmenwidth}
\newdimen\clone@marginparsep       \setlength\clone@marginparsep{\marginparsep}
\newdimen\clone@marginparwidth     \setlength\clone@marginparwidth{\marginparwidth}

%% ノド、小口
\setlength\oddsidemargin{\grnchry@gutter}%ノド
\addtolength\oddsidemargin{-1in}
\setlength\evensidemargin{\paperwidth}
\addtolength\evensidemargin{-2in}
\addtolength\evensidemargin{-\oddsidemargin}
\addtolength\evensidemargin{-\textwidth}

%% 天、地
\setlength\topmargin{\grnchry@head}%天
\addtolength\topmargin{-1in}
\addtolength\topmargin{-\headheight}\addtolength\topmargin{-\headsep}

\setlength\footnotesep{14H}
\setlength{\skip\footins}{\Cvs \@plus .5\Cdp \@minus .2\Cdp}
\setlength\floatsep    {\Cvs \@plus\z@ \@minus.1\Cvs}%
\setlength\textfloatsep{1.5\Cvs \@plus\z@ \@minus.2\Cvs}%
\setlength\intextsep   {1.5\Cvs \@plus\z@ \@minus.2\Cvs}%
\setlength\dblfloatsep    {\Cvs \@plus\z@ \@minus.1\Cvs}%
\setlength\dbltextfloatsep{1.5\Cvs \@plus\z@ \@minus.2\Cvs}%
\setlength\@fptop\z@skip%{\z@ \@plus 1fil}%
\setlength\@fpsep\Cvs%{\z@ \@plus 2fil}%
\setlength\@fpbot\z@skip%{\z@ \@plus 1fil}%
\setlength\partopsep{\z@}
\def\@listi{\leftmargin\leftmargini
  \topsep \z@
  \parsep \z@
  \itemsep\parsep%\z@\relax
}
\let\@listI\@listi
\@listi
\def\@listii{\leftmargin\leftmarginii
   \labelwidth\leftmarginii \advance\labelwidth-\labelsep
   \topsep \z@
   \parsep \z@
   \itemsep\parsep}
\def\@listiii{\leftmargin\leftmarginiii
   \labelwidth\leftmarginiii \advance\labelwidth-\labelsep
   \topsep \z@
   \parsep \z@
   \itemsep\parsep}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}

\let\clone@underline\underline
% \RequirePackage{plext}%pLaTeX package file

\setlength\columnsep{2\Cwd}
\setlength\columnseprule{0\p@}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\setlength\lineskiplimit{1\p@}
\setlength\normallineskiplimit{1\p@}
\renewcommand{\baselinestretch}{}
\setlength\parskip\z@%default: 0\p@ \@plus \p@}
\setlength\parindent{1zw}

\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301

\setcounter{topnumber}{9}
\setcounter{bottomnumber}{9}
\setcounter{totalnumber}{20}
\setcounter{dbltopnumber}{9}
\renewcommand{\topfraction}{.85}
\renewcommand{\bottomfraction}{.8}
\renewcommand{\textfraction}{.1}
\renewcommand{\floatpagefraction}{.8}
\renewcommand{\dbltopfraction}{.8}
\renewcommand{\dblfloatpagefraction}{.8}

\if@hanmen
  \def\hanmen@TL{\llap{\smash{%
    \rule[-\headsep]{5mm}{.1\p@}\rule[-\headsep]{.1\p@}{5mm}}}}
  \def\hanmen@TR{\rlap{\smash{%
    \rule[-\headsep]{.1\p@}{5mm}\rule[-\headsep]{5mm}{.1\p@}}}}
  \def\hanmen@BL{\llap{\smash{%
    \raisebox{\footskip}{\rule{5mm}{.1\p@}\rule[-5mm]{.1\p@}{5mm}}}}}
  \def\hanmen@BR{\rlap{\smash{%
    \raisebox{\footskip}{\rule[-5mm]{.1\p@}{5mm}\rule{5mm}{.1\p@}}}}}
\else
  \let\hanmen@TL\relax \let\hanmen@TR\relax
  \let\hanmen@BL\relax \let\hanmen@BR\relax
\fi

\def\ps@plain{\let\@mkboth\@gobbletwo
  \let\ps@jpl@in\ps@plain
  \def\@oddhead{\hbox to \hanmenwidth{%
    \hanmen@TL\hfil\hanmen@TR}\hss}%
  \def\@oddfoot{\hbox to \hanmenwidth{%
    \hanmen@BL\hfil{\ps@nombre@font\thepage}\hfil\hanmen@BR}\hss}%
  \let\@evenhead\@oddhead
  \let\@evenfoot\@oddfoot}
\let\ps@jpl@in\ps@plain
\def\ps@empty{\let\@mkboth\@gobbletwo
  \let\ps@jpl@in\ps@empty
  \def\@oddhead{\hbox to \hanmenwidth{%
    \hanmen@TL\hfil\hanmen@TR}\hss}%
  \def\@oddfoot{\hbox to \hanmenwidth{%
    \hanmen@BL\hfil\hanmen@BR}\hss}%
  \let\@evenhead\@oddhead
  \let\@evenfoot\@oddfoot}
\def\ps@footnombre{\let\@mkboth\@gobbletwo
  \let\ps@jpl@in\ps@footnombre
  \def\@evenfoot{\hanmen@BL\hbox to \textwidth{\ps@nombre@font
    \rlap{\hbox to 7mm{\thepage\hss}}\hss}\hanmen@BR}%
  \def\@oddfoot{\hanmen@BL\hbox to \textwidth{\hss\ps@nombre@font
    \llap{\hbox to 7mm{\hss\thepage}}}\hanmen@BR}%
  \def\@oddhead{\hanmen@TL\hfil\hanmen@TR}%
  \let\@evenhead\@oddhead}

\newcommand{\ps@nombre@font}{\reset@font
  \sffamily\fontseries\bfdefault\fontsize{13\JQ}{10H}\selectfont}

\newcommand{\ps@head@font}{\reset@font
  \sffamily\fontsize{10\JQ}{10H}\selectfont
  \let\\\relax}

\def\ps@bothstyle{\let\ps@jpl@in\ps@footnombre
  \def\@oddhead{%
    \clone@underline{\hbox to \hanmenwidth{%
      \hanmen@TL\hfill
        \scalebox{.90}[1]{\ps@head@font\rightmark}%
      \hanmen@TR}}\hss}%
  \def\@evenhead{%
    \clone@underline{\hbox to \hanmenwidth{%
      \hanmen@TL
        \scalebox{.90}[1]{\ps@head@font\leftmark}%
      \hfill\hanmen@TR}}\hss}%
  \def\@oddfoot{\hbox to \hanmenwidth{%
    \hanmen@BL\hfill\rlap{\hb@xt@4mm{\hss
      \ps@nombre@font\thepage}}\hanmen@BR}\hss}%
  \def\@evenfoot{\hbox to \hanmenwidth{%
    \hanmen@BL\llap{\hb@xt@4mm{%
      \ps@nombre@font\thepage\hss}}\hfill\hanmen@BR}\hss}%
  \let\@mkboth\markboth
  \def\chaptermark##1{\markboth{%
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \@chapapp\thechapter\@chappos\hskip1zw\relax
      \fi
    \fi
    ##1}{%
    \if@mainmatter
      \if@appendix
        \@chapapp\thechapter\@chappos\hskip1zw\relax ##1\inhibitglue
      \fi
    \else
      %%前付け、後付け
      ##1\inhibitglue
    \fi}}%
  \def\sectionmark##1{\markright{%
    \ifnum \c@secnumdepth >\z@
      \if@mainmatter
        \thesection\hskip1zw
      \fi
    \fi
    ##1}}%
}

\def\rightmark{\expandafter\@rightmark\botmark\@empty\@empty}%\firstmark

\newcommand*{\chaptermark}[1]{}
\setcounter{secnumdepth}{2}

\newcounter{part}
\newcounter{chapter}
\newcounter{section}[chapter]
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]

% \renewcommand{\thepart}{\@arabic\c@part}
\renewcommand{\thechapter}{\@arabic\c@chapter}
\renewcommand{\thesection}{\thechapter.\@arabic\c@section}
\renewcommand{\thesubsection}{\thesection.\@arabic\c@subsection}
\renewcommand{\thesubsubsection}{%
   \thesubsection.\@arabic\c@subsubsection}
\renewcommand{\theparagraph}{%
   \thesubsubsection.\@arabic\c@paragraph}
\renewcommand{\thesubparagraph}{%
   \theparagraph.\@arabic\c@subparagraph}

\newcommand{\@chapapp}{\prechaptername}
\newcommand{\@chappos}{\postchaptername}

% \def\cleardoublepage{\clearpage\if@twoside\ifodd\c@page\else
%   \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\let\cleardoublepage@right\cleardoublepage
\def\cleardoublepage@left{\clearpage\if@twoside\ifodd\c@page
  \hbox{}\thispagestyle{empty}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\let\clearoddpage\cleardoublepage@left

%% \grnchry@clearpage{<selector>@<breakxxxxx>}
\def\grnchry@clearpage#1{%
  \def\grnchry@tmp{page}%
  \expandafter\ifx\csname grnchry@#1\endcsname\grnchry@tmp
    \clearpage
  \else\def\grnchry@tmp{left}%
  \expandafter\ifx\csname grnchry@#1\endcsname\grnchry@tmp
    \cleardoublepage@left
  \else\def\grnchry@tmp{right}%
  \expandafter\ifx\csname grnchry@#1\endcsname\grnchry@tmp
    \cleardoublepage@right
  \else
    \grnchry@error{No such value of #1: \csname grnchry@#1\endcsname}%
  \fi\fi\fi
}

\newcommand\frontmatter{%
  \grnchry@clearpage{frontmatter@@breakbefore}%
  \@frontmattertrue\@mainmatterfalse\@backmatterfalse\@appendixfalse
  \pagenumbering{roman}%
  \setcounter{chapter}{-100}%
}
\newcommand{\mainmatter}{%
  \grnchry@clearpage{mainmatter@@breakbefore}%
  \@frontmatterfalse\@mainmattertrue\@backmatterfalse\@appendixfalse
  \if@bvpaper\sethanmen@mainmatter\fi
  \pagenumbering{arabic}%
  \setcounter{chapter}{0}%
}
\newcommand{\backmatter}{%
  \grnchry@clearpage{backmatter@@breakbefore}%
  \@frontmatterfalse\@mainmatterfalse\@backmattertrue\@appendixfalse
  \immediate\write\@auxout{\string\@writefile{toc}{%
    \string\onelineskip}}%
}

\newcommand{\appendix}{%
  \grnchry@clearpage{appendix@@breakbefore}%
\if@mainmatter
  \@frontmatterfalse\@mainmattertrue%<- 本文中の付録
    \@backmatterfalse\@appendixtrue
  \setcounter{chapter}{100}%
  \renewcommand{\thechapter}{\@Alph{\numexpr\c@chapter - 100}}%
  \renewcommand{\@chapapp}{\appendixname}%
  \renewcommand{\@chappos}{\relax}%
  \renewcommand{\thesection}{\thechapter.\@arabic\c@section}%
  \renewcommand{\thefigure}{\thechapter.\@arabic\c@figure}%
  \renewcommand{\thetable}{\thechapter.\@arabic\c@table}%
\else\if@backmatter
  \@frontmatterfalse\@mainmatterfalse\@backmattertrue%<- 後付け中の付録
    \@appendixtrue
  \setcounter{chapter}{100}%
  \renewcommand{\thechapter}{\relax}%
  \renewcommand{\@chapapp}{\relax}%
  \renewcommand{\@chappos}{\relax}%
  \renewcommand{\thesection}{\@arabic\c@section}%
  \renewcommand{\thefigure}{\@arabic\c@figure}%
  \renewcommand{\thetable}{\@arabic\c@table}%
\fi\fi
}

\def\sethanmen@mainmatter{%
  \clearpage
  \global\textwidth\clone@textwidth
  \global\hanmenwidth\clone@hanmenwidth
  \global\marginparwidth\clone@marginparwidth \global\marginparsep\clone@marginparsep
  \setlength\@tempdima{\grnchry@gutter}
  \addtolength\@tempdima{-1in}
  \setlength\@tempdimb{\paperwidth}
  \addtolength\@tempdimb{-2in}
  \addtolength\@tempdimb{-\@tempdima}
  \addtolength\@tempdimb{-\hanmenwidth}
  \global\oddsidemargin\@tempdima
  \global\evensidemargin\@tempdimb
  \global\columnwidth\hanmenwidth
  \global\hsize\columnwidth
  \global\linewidth\columnwidth
  \global\textheight\hanmenheight
  \global\@twocolumnfalse
  \col@number \@ne
  \@floatplacement
}

\def\sethanmen@tableofcontents{%
  \clearpage
  \global\textwidth=\dimexpr\clone@textwidth - 60mm + \grnchry@gutter\relax
  \global\hanmenwidth=\dimexpr\clone@hanmenwidth - 60mm + \grnchry@gutter\relax
  \global\marginparwidth\clone@marginparwidth \global\marginparsep\clone@marginparsep
  \setlength\@tempdima{60mm}
  \addtolength\@tempdima{-1in}
  \setlength\@tempdimb{\paperwidth}
  \addtolength\@tempdimb{-2in}
  \addtolength\@tempdimb{-\@tempdima}
  \addtolength\@tempdimb{-\hanmenwidth}
  \global\oddsidemargin\@tempdima
  \global\evensidemargin\@tempdimb
  \global\columnwidth\hanmenwidth
  \global\hsize\columnwidth
  \global\linewidth\columnwidth
  \global\textheight\hanmenheight
  \global\@twocolumnfalse
  \col@number \@ne
  \@floatplacement
}

%% 部扉：画像を貼り付けられるだけ
\newcommand{\part}{%
  \cleardoublepage
  \thispagestyle{empty}%
  % \if@twocolumn\onecolumn\@restonecoltrue\else\@restonecolfalse\fi
  \secdef\@part\@spart}

\def\@part[#1]#2{%
  \ifnum \c@secnumdepth >-2\relax
    \refstepcounter{part}%
    \if@mainmatter\if@appendix\phantomsection\else
      % \addcontentsline{toc}{part}{%
      %    \prepartname\space\thepart\space\postpartname\hspace{1zw}#1}%
      \addcontentsline{toc}{part}{#1}%
    \fi\fi
  \else
    \addcontentsline{toc}{part}{#1}%
  \fi
  \markboth{#1}{#1}%
  \@makeparthead{#2}%
  % \if@restonecol\twocolumn\else\newpage\fi
  \newpage
  \global\let\@partpageimage\relax
}

\newcommand*\partpageimage[1]{\gdef\@partpageimage{#1}}
\let\@partpageimage\@empty

\def\@makeparthead#1{\begingroup
  \parindent\z@
  \boxmaxdepth\z@
  \lineskiplimit\z@
  \lineskip\z@
  \reset@font
  %%扉デザイン
  \vbox to \z@{%
    \vbox to \dimexpr\paperheight + 2\pdfcutoffset{%
      \vskip-\dimexpr\grnchry@head + \pdfcutoffset + \topskip\relax
      \hbox to \textwidth{\hskip-\dimexpr\grnchry@gutter + \pdfcutoffset\relax
        \hbox to \dimexpr\paperwidth + 2\pdfcutoffset{\hss
          \includegraphics[hiresbb]{\@partpageimage}%
        \hss}%
      \hss}%
    \vss}%
  \vss}%
\endgroup}

\newcommand{\chapter}{%
  \if@mainmatter
    \cleardoublepage
    \thispagestyle{empty}%
    % \if@twocolumn\onecolumn\@restonecoltrue\else\@restonecolfalse\fi
  \else
    \if@frontmatter
      \clearpage
      \thispagestyle{footnombre}%
      \@afterindenttrue
    \else
      \if@backmatter\if@appendix
        \cleardoublepage
        \thispagestyle{empty}%
      \else
        \clearpage
        \thispagestyle{footnombre}%
        \@afterindenttrue
      \fi\fi
    \fi
  \fi
  \global\@topnum\z@
  \secdef\@chapter\@schapter}

\def\@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{chapter}%
    \if@mainmatter
      \if@appendix
        %%本文付録
        \phantomsection%
        \typeout{\@chapapp\space\thechapter\space\@chappos}%
        \addcontentsline{toc}{chapter}%section
          {\protect\numberline{\@chapapp\thechapter\@chappos}#1}%
      \else
        %%本文
        \typeout{\@chapapp\space\thechapter\space\@chappos}%
        \addcontentsline{toc}{chapter}%
          {\protect\numberline{\@chapapp\thechapter\@chappos}#1}%
      \fi
    \else
      \if@frontmatter
        %%前付け
        \phantomsection
        \addcontentsline{toc}{extchapter}{#1}%section,chapter
      \else
        \if@backmatter\if@appendix
          %%後付け付録
          \addcontentsline{toc}{chapter}{#1}%
        \else
          %%後付け
          \phantomsection
          \addcontentsline{toc}{extchapter}{#1}%section,chapter
        \fi\fi
      \fi
    \fi
  \else
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \if@mainmatter\else
    \sectionmark{#1}%
  \fi
  % \addtocontents{lof}{\protect\addvspace{\Cvs}}%
  % \addtocontents{lot}{\protect\addvspace{\Cvs}}%
  \if@mainmatter
    \@makechapterhead{#2}%
    \newpage
  \else
    \if@frontmatter
      \@makeextchapterhead{#2}%
      \@afterheading
    \else
      \if@backmatter\if@appendix
        \@makechapterhead{#2}%
        \newpage
      \else
        \@makeextchapterhead{#2}%
        \@afterheading
      \fi\fi
    \fi
  \fi
  \global\setbox\chaplead@box\box\voidb@x\relax
}

\DeclareFixedFont{\chapnum@kfont}{\grnchry@JYn}{hmc}{bx}{n}{26\JQ}
\def\chapnum@font{\reset@font
  \rmfamily\fontseries\bfdefault
  \if@bvpaper\fontsize{70\JQ}{90H}\else\fontsize{60\JQ}{80H}\fi\selectfont
  \chapnum@kfont}

\def\chaphead@font{\reset@font
  \rmfamily\fontseries\bfdefault
  \mcfamily\kanjiseries{bx}%
  \if@bvpaper\fontsize{44\JQ}{56H}\else\fontsize{36\JQ}{44H}\fi\selectfont
  \mathversion{bold}\ybaselineshift.0125em}

\def\@makechapterhead#1{\begingroup
  \parindent\z@
  \boxmaxdepth\z@
  \lineskiplimit\z@
  \lineskip\z@
  \reset@font
  %%扉デザイン
  \vbox to \z@{%
    \vbox to \dimexpr\paperheight + 2\pdfcutoffset{%
      \vskip-\dimexpr\grnchry@head + \pdfcutoffset + \topskip\relax
      \hbox to \textwidth{\hskip-\dimexpr\grnchry@gutter + \pdfcutoffset\relax
        \hbox to \dimexpr\paperwidth + 2\pdfcutoffset{\hss
          \includegraphics[hiresbb]{images/nxtpubbk-\grnchry@papersize kdd-part.ai}%
        \hss}%
      \hss}%
    \vss}%
  \vss}%
  \vskip-\Cvs\relax
  %%第N章
  \vbox to \z@{%
    \vskip-4H\relax
    \if@bvpaper\vskip-4H\fi
    \raggedleft
    \ifnum \c@secnumdepth >-2\relax
      \leavevmode
      \bgroup\chapnum@font\@chapapp\thechapter\@chappos\egroup\@@par
    \fi
  \vss}%
  \vskip-\Cvs
  %%タイトル
  \vbox to \z@{%
    \vskip74H
    \if@bvpaper\vskip12H\fi
    \raggedleft
    \chaphead@font
    \interlinepenalty\@M\vphantom{Mg}#1\par
  \vss}%
  %%扉リード文
  \ifvoid\chaplead@box\else
    \vfill
    \hfill
    \parbox{72mm}{\chaplead@font
      \unhbox\chaplead@box}%
    \vspace*{22.5mm}%
    \if@bvpaper\vspace*{-3.5mm}\fi
  \fi
\endgroup}

\def\chaplead@font{\reset@font
  \rmfamily\fontseries\bfdefault
  \mcfamily\kanjiseries{bx}\fontsize{13\JQ}{22H}\selectfont
  \mathversion{bold}%
  \parindent\z@\relax}

\newbox\chaplead@box
\newenvironment{lead}{%
  \global\setbox\chaplead@box\hbox\bgroup
    \begin{minipage}{72mm}
      \chaplead@font\ignorespaces
  }{\unskip\end{minipage}\egroup}

\def\extchaphead@font{\reset@font
  \bfseries\fontsize{18\JQ}{\Cvs}\selectfont
  \mathversion{bold}}

\def\@makeextchapterhead#1{\null\bgroup
  \parindent\z@
  \boxmaxdepth\z@
  \lineskiplimit\z@
  \lineskip\z@
  \reset@font
  \setbox\grnchry@boxa\hbox{%
    \begin{minipage}{\hanmenwidth}
      \extchaphead@font
      \interlinepenalty\@M\mbox{}\inhibitglue #1\vphantom{Mg}\par
    \end{minipage}}%
  \grnchry@cnta\dimexpr(\ht\grnchry@boxa + \dp\grnchry@boxa)/\Cvs\relax
  % \typeout{!!! \the\grnchry@cnta}%debug
  \vbox to \grnchry@cnta\Cvs{%
    \vskip-\topskip
    \hbox to \hsize{%
      \raise\dp\grnchry@boxa\box\grnchry@boxa\hss}%
  \vss}%
\egroup\nobreak}

\def\@schapter#1{%
%% 後付け中の付録
  \if@backmatter
    \if@appendix
      \@makechapterhead{#1}%
      \newpage
    \else
%% otherwise
      \@makeextchapterhead{#1}%
      \@afterheading
    \fi
  \else
    % \@makeschapterhead{#1}%
    \@makeextchapterhead{#1}%
    \@afterheading
  \fi
}

\newcount\@ssect@currlevel

%% \@startsection {NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}
\def\@startsection#1#2#3#4#5#6{%
  \@ifundefined{allowdisplaybreaks}{}{%
    \displaywidowpenalty-\@highpenalty%\z@
    \interdisplaylinepenalty-\@highpenalty%\z@
    \predisplaypenalty-\@highpenalty%\z@
    \postdisplaypenalty-\@highpenalty%\z@
  }%
  \grnchry@dima\lastskip\ifdim\grnchry@dima=10sp\vspace{-.5\intextsep}\fi
  \if@noskipsec \leavevmode \fi
  \par
  \grnchry@skipa #4\relax
  \@afterindenttrue
  \ifdim \grnchry@skipa <\z@
    \grnchry@skipa -\grnchry@skipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty
    \ifdim \grnchry@skipa >\z@
      \addvspace\grnchry@skipa
    \fi
  \fi
  \global\@ssect@currlevel=#2\relax
  \noindent
  \@ifstar
    {\@ssect{#3}{#4}{#5}{#6}}%
    {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}

\def\section@seccntformat#1{\csname the#1\endcsname\quad}%\quad
\def\subsection@seccntformat#1{\csname the#1\endcsname\quad}%\quad
\def\subsubsection@seccntformat#1{\csname the#1\endcsname\quad}

\def\@sect@section#1#2{\bgroup
  \@hangfrom{\hskip #1\relax\@svsec}%
  \interlinepenalty\@M\mbox{}\inhibitglue #2\vphantom{Mg}\par
\egroup}

\def\@sect@subsection#1#2{\bgroup
  \parindent\z@
  \boxmaxdepth\z@
  \lineskiplimit\z@
  \lineskip\z@
  \reset@font
  \setbox\grnchry@boxa\hbox{%
    \begin{minipage}[b]{\hanmenwidth}%%節見出し
      \subsecthead@font
      \@hangfrom{\hskip #1\relax\@svsec}%
      \interlinepenalty\@M\mbox{}\inhibitglue #2\vphantom{Mg}%
      \rule[-1mm]{0mm}{1mm}\par
    \end{minipage}}%
  \grnchry@cnta\dimexpr(\ht\grnchry@boxa + \dp\grnchry@boxa)/\Cvs\relax
  % \typeout{!!! Subsection \thesection: \the\grnchry@cnta lines}%debug
  \vbox to \grnchry@cnta\Cvs{%
    \hbox to \hsize{\sect@underline{0.1mm}{\box\grnchry@boxa}\hss}%
  \vss}%
\egroup\nobreak}

\newcommand*\sect@underline[3][-1mm]{{%
  \setbox0=\hbox{#3}%
  \ooalign{\copy0\cr\rule[\dimexpr#1-#2\relax]{\wd0}{#2}}}}

%% \@sect{NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}[ARG1]{ARG2}
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\csname #1@seccntformat\endcsname{#1}\relax}%
    \if@mainmatter\else\let\@svsec\@empty\fi
  \fi
  \grnchry@skipa #5\relax
  \ifdim \grnchry@skipa>\z@
    \begingroup
      \interlinepenalty\@M
      #6{\ifnum#2=\@ne
           \@sect@section{#3}{#8}%
         \else\ifnum#2=\tw@
           \@sect@subsection{#3}{#8}%
         \else
           \@hangfrom{\hskip #3\relax\@svsec}%
             \inhibitglue #8\par
         \fi\fi}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \if@mainmatter
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}%
    \else
      \if@backmatter\if@appendix
        \addcontentsline{toc}{#1}{#7}%
      \fi\fi
    \fi
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}

%% \@xsect{AFTERSKIP}
\def\@xsect#1{%
  \grnchry@skipa #1\relax
  \ifdim \grnchry@skipa>\z@
    \par \nobreak
    \vskip \grnchry@skipa
    \@afterheading
  \else
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \begingroup \@svsechd \endgroup
        \unskip
        \grnchry@skipa #1\relax
        \hskip -\grnchry@skipa
      \else
        \clubpenalty \@clubpenalty
        \everypar{%
          \opgbrkt@hook%default: (none)
        }%
      \fi
      \opgbrkt@hook%default: (none)
    }%
  \fi
  \@@par
  \ignorespaces}

%% \@ssect{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}{ARG}
\def\@ssect#1#2#3#4#5{%
  \grnchry@skipa #3\relax
  \ifdim \grnchry@skipa>\z@
    \begingroup
      \let\@svsec\@empty
      \interlinepenalty\@M
      #4{\ifnum\@ssect@currlevel=\@ne
           \@sect@section{#1}{#5}%
         \else\ifnum\@ssect@currlevel=\tw@
           \@sect@subsection{#1}{#5}%
         \else
           \@hangfrom{\hskip #1\relax\@svsec}%
             \inhibitglue #5\par
         \fi\fi}%
    \endgroup
  \else
    \def\@svsechd{#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}}

\def\newpage{%
  \if@noskipsec
    \ifx \@nodocument\relax
      \leavevmode
      \global \@noskipsecfalse
    \fi
  \fi
  \if@inlabel
    \leavevmode
    \global \@inlabelfalse
  \fi
  \if@nobreak
    \@nobreakfalse
    \everypar{%
      \opgbrkt@hook%default: (none)
    }%
  \fi
  \par
  \vfil
  \penalty -\@M}

\def\@doendpe{%
  \@endpetrue
  \def\par{%
    \@restorepar
    \everypar{%
      \if@nobreak\else
        \clubpenalty\@clubpenalty%\z@, \@clubpenalty
      \fi
      \opgbrkt@hook%default: (none)
    }%
    \par\@endpefalse}%
  \everypar{%
    {\setbox\z@\lastbox}%
    \if@nobreak \else
      \clubpenalty\@clubpenalty%\z@, \@clubpenalty
    \fi
    \everypar{%
      \opgbrkt@hook%default: (none)
    }%
    \@endpefalse
    \opgbrkt@hook%default: (none)
  }%
}
\def\@afterheading{%
  \@nobreaktrue
  \everypar{%
    \if@nobreak
      \@nobreakfalse
      \clubpenalty\@clubpenalty%\z@, \@clubpenalty; default: \@M
      \if@afterindent \else
        {\setbox\z@\lastbox}%
      \fi
    \else
      \clubpenalty \@clubpenalty
      \everypar{%
        \opgbrkt@hook%default: (none)
      }%
    \fi
    \opgbrkt@hook%default: (none)
  }%
}

\def\@item[#1]{%
  \if@noparitem
    \@donoparitem
  \else
    \if@inlabel
      \indent \par
    \fi
    \ifhmode
      \unskip\unskip \par
    \fi
    \if@newlist
      \if@nobreak
        \@nbitem
      \else
        \addpenalty\@beginparpenalty
        \addvspace\@topsep
        \addvspace{-\parskip}%
      \fi
    \else
      \addpenalty\@itempenalty
      \addvspace\itemsep
    \fi
    \global\@inlabeltrue
  \fi
  \everypar{%
    \@minipagefalse
    \global\@newlistfalse
    \if@inlabel
      \global\@inlabelfalse
      {\setbox\z@\lastbox
       \ifvoid\z@
         \kern-\itemindent
       \fi}%
      \box\@labels
      \penalty\z@
    \fi
    \if@nobreak
      \@nobreakfalse
      \clubpenalty\@clubpenalty%\z@, \@clubpenalty; default: \@M
    \else
      \clubpenalty \@clubpenalty
      \everypar{%
        \opgbrkt@hook%default: (none)
      }%
    \fi
    \opgbrkt@hook%default: (none)
  }%
  \if@noitemarg
    \@noitemargfalse
    \if@nmbrlist
      \refstepcounter\@listctr
    \fi
  \fi
  \sbox\grnchry@boxa{\makelabel{#1}}%
  \global\setbox\@labels\hbox{%
    \unhbox\@labels
    \hskip \itemindent
    \hskip -\labelwidth
    \hskip -\labelsep
    \ifdim \wd\grnchry@boxa >\labelwidth
      \box\grnchry@boxa
    \else
      \hbox to\labelwidth {\unhbox\grnchry@boxa}%
    \fi
    \hskip \labelsep}%
  \ignorespaces
  \opgbrkt@hook%\inhibitglue; default: (none)
}
\let\clone@@item\@item

\def\secthead@font{\reset@font
  \sffamily\fontseries\bfdefault
  \gtfamily\kanjiseries{bx}\fontsize{20\JQ}{\Cvs}\selectfont
  \mathversion{bold}}

\newcommand{\section}{\@startsection{section}{1}{\z@}%
   {2\Cvs \@plus\z@ \@minus.2\Cvs}%
   {\Cvs \@plus\z@ \@minus.2\Cvs}%
   {\reset@font\secthead@font}}

\def\subsecthead@font{\reset@font
%FIXME: sans serifのExtraBold
  \sffamily\fontseries\bfdefault
  \gtfamily\kanjiseries{eb}\fontsize{14\JQ}{\Cvs}\selectfont
  \mathversion{bold}}

\newcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
   {\Cvs \@plus\z@ \@minus.1\Cvs}%
   {.00001\Cvs \@plus\z@ \@minus.1\Cvs}%
   {\reset@font\subsecthead@font}}

\def\subsubsecthead@font{\reset@font
  \sffamily\fontseries\bfdefault
  \gtfamily\kanjiseries{bx}\fontsize{\grnchry@Qnum\JQ}{\Cvs}\selectfont
  \mathversion{bold}}

\newcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
   {\Cvs \@plus\z@ \@minus.1\Cvs}%
   {.00001\Cvs \@plus\z@ \@minus.1\Cvs}%
   {\reset@font\subsubsecthead@font}}

\def\parahead@font{\reset@font
  \sffamily\fontseries\bfdefault
  \gtfamily\kanjiseries{bx}\fontsize{\grnchry@Qnum\JQ}{\Cvs}\selectfont
  \mathversion{bold}}

\newcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
   {\Cvs \@plus\z@ \@minus.1\Cvs}%
   {-1zw}%
   {\reset@font\parahead@font}}

\def\subparahead@font{\reset@font
  \sffamily\gtfamily\fontsize{\grnchry@Qnum\JQ}{\Cvs}\selectfont}

\newcommand{\subparagraph}{\@startsection{subparagraph}{5}{\z@}%
   {\Cvs \@plus\z@ \@minus.1\Cvs}%
   {-1zw}%
   {\reset@font\subparahead@font}}

\setlength\leftmargini {2zw}
\setlength\leftmarginii  {2zw}
\setlength\leftmarginiii {2zw}
\setlength\leftmarginiv  {2zw}
\setlength\leftmarginv {1zw}
\setlength\leftmarginvi{1zw}
\setlength  \labelsep  {.5zw}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty\z@ %default: -\@lowpenalty
\@endparpenalty\z@   %default: -\@lowpenalty
\@itempenalty\z@     %default: -\@lowpenalty

\renewcommand{\theenumi}{\@arabic\c@enumi}
\renewcommand{\theenumii}{\@alph\c@enumii}
\renewcommand{\theenumiii}{\@roman\c@enumiii}
\renewcommand{\theenumiv}{\@Alph\c@enumiv}
\newcommand{\labelenumi}{\theenumi.}
\newcommand{\labelenumii}{(\theenumii)}
\newcommand{\labelenumiii}{\theenumiii.}
\newcommand{\labelenumiv}{\theenumiv.}
\renewcommand{\p@enumii}{\theenumi}
\renewcommand{\p@enumiii}{\theenumi(\theenumii)}
\renewcommand{\p@enumiv}{\p@enumiii\theenumiii}

\renewenvironment{enumerate}
  {\ifnum \@enumdepth >\thr@@\@toodeep\else
   \advance\@enumdepth\@ne
   \displaymath@smallskip@setup
   \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
   \list{\csname label\@enumctr\endcsname}{%
          \topsep.5\baselineskip%as default
            \ifnum\@enumdepth>\@ne\topsep\z@\fi
            \ifnum\@itemdepth>\z@\topsep\z@\fi
            % \ifnum\@descrdepth>\z@\topsep\z@\fi
         \parskip\z@ \itemsep\z@ \parsep\z@
         %\settowidth\labelwidth{\csname label\@enumctr\endcsname}
         \labelwidth2zw
         \labelsep1zw
         \leftmargin3zw%as default
           \ifnum\@enumdepth>\@ne\leftmargin2zw\fi
           \ifnum\@itemdepth>\z@\leftmargin2zw\fi
           % \ifnum\@descrdepth>\z@\leftmargin2zw\fi
         \listparindent\z@
         \clubpenalty\z@
         \widowpenalty\z@
         \@itempenalty\z@
         \usecounter{\@enumctr}%
         \def\makelabel##1{\hss\llap{##1}}}%
   \fi}{\endlist}


\newcommand{\labelitemi}{%
  \leavevmode\raise.05zh\hbox to 1zw{\hss\textbullet\hss}}
\newcommand{\labelitemii}{%
  \leavevmode\hbox to 1zw{\hss ・\hss}}
\newcommand{\labelitemiii}{%
  \leavevmode\hbox to 1zw{\hss\textasteriskcentered\hss}}
\newcommand{\labelitemiv}{%
  \leavevmode\hbox to 1zw{\hss\textperiodcentered\hss}}

\renewenvironment{itemize}
  {\ifnum \@itemdepth >\thr@@\@toodeep\else
   \advance\@itemdepth\@ne
   \displaymath@smallskip@setup
   \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
   \list{\csname \@itemitem\endcsname}{%
          \topsep.5\baselineskip%as default
            \ifnum\@enumdepth>\z@\topsep\z@\fi
            \ifnum\@itemdepth>\@ne\topsep\z@\fi
            % \ifnum\@descrdepth>\z@\topsep\z@\fi
         \parskip\z@ \itemsep\z@ \parsep\z@
         \labelwidth1zw
         \labelsep\z@
         \leftmargin2zw%as default
           \ifnum\@enumdepth>\z@\leftmargin1zw\fi
           \ifnum\@itemdepth>\@ne\leftmargin1zw\fi
           % \ifnum\@descrdepth>\z@\leftmargin1zw\fi
         \ifdim\leftskip>\z@\advance\leftmargin\leftskip\fi
         \ifdim\rightskip>\z@\advance\rightmargin\rightskip\fi
         \listparindent1zw
         \clubpenalty\z@
         \widowpenalty\z@
         \@itempenalty\z@
         \def\makelabel##1{\hss\llap{##1}}}%
   \fi}{\endlist}

% \newcount\@descrdepth \@descrdepth\z@
\newenvironment{description}{%
  % \ifnum\@descrdepth>\@ne\@toodeep\else
  %   \advance\@descrdepth\@ne
  \list{}{%
    \topsep\baselineskip \parskip\z@ \itemsep\z@ \parsep\z@
    \labelwidth\leftmargin
    \labelsep1zw
    \advance\labelwidth -\labelsep
    \let\makelabel\descriptionlabel}%
  % \fi
}{\endlist}

\newcommand*\descriptionlabel[1]{\normalfont\bfseries #1\hfil}

\newenvironment{verse}
  {\let\\\@centercr
   \list{}{%
     \topsep\z@\parsep\z@\partopsep\z@\itemsep\z@
     \itemindent 2zw
     \listparindent\itemindent
     \rightmargin\leftmargin \advance\leftmargin 2zw
  }%
  \item\relax}{\endlist}

\let\quote@font\relax

\newenvironment{quotation}
  {\list{}{%
     \topsep\baselineskip\parsep\z@\partopsep\z@\itemsep\z@
     \listparindent\parindent
     \itemindent\listparindent
     \rightmargin\z@
     % \leftmargin2zw
  }%
  \quote@font
  \item\relax}{\endlist}

\newenvironment{quote}
  {\list{}{%
     \topsep\baselineskip\parsep\z@\partopsep\z@\itemsep\z@
     \rightmargin\z@
     % \leftmargin2zw
  }%
  \quote@font
  \item\relax}{\endlist}

\def\@begintheorem#1#2{%
  \trivlist
    \labelsep1zw\relax
    \item[\hskip\labelsep{\bfseries #1\ #2}]}
\def\@opargbegintheorem#1#2#3{%
  \trivlist
    \labelsep1zw\relax
    \item[\hskip\labelsep{\bfseries #1\ #2（#3）}]}

%% define the float type H
\let\@float@Hx\@xfloat
\def\@xfloat#1[{\@ifnextchar{H}{\@float@HH{#1}[}{\@float@Hx{#1}[}}
\newsavebox\float@box
\def\@float@HH#1[H]{%
  \expandafter\let\csname end#1\endcsname\float@endH
  \let\@currbox\float@box
  \def\@captype{#1}%
  \def\@fps{H}%
  \setbox\@currbox\color@vbox\normalcolor
    \vbox\bgroup \hsize\columnwidth \@parboxrestore
      \@floatboxreset \@setnobreak
  \ignorespaces}
\newcommand\float@endH{\@endfloatbox
  \vskip\z@skip
  \vspace{\intextsep}%
  \box\@currbox
  \vspace{\intextsep}%
  \vskip\dimexpr\cht-\cvs
  \vskip10sp\relax%%<- specific skip
}

\newcounter{figure}[chapter]
\renewcommand{\thefigure}{%
  \ifnum\c@chapter>\z@\thechapter.\fi\@arabic\c@figure}
\def\fps@figure{H}%htb
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}
  {\@tempdima\lastskip
   \ifdim\@tempdima=10sp\vspace{-\intextsep}\fi
   \fig@setup
   \abovecaptionskip0H \belowcaptionskip2H \captionwidth.9\hsize
   \@float{figure}}
  {\end@float}
\newenvironment{figure*}
  {\fig@setup
   \abovecaptionskip0H \belowcaptionskip2H \captionwidth.9\hsize
   \@dblfloat{figure}}
  {\end@dblfloat}


\newcounter{table}[chapter]
\renewcommand{\thetable}{%
  \ifnum\c@chapter>\z@\thechapter.\fi\@arabic\c@table}
\def\fps@table{H}%htb
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
  {\@tempdima\lastskip
   \ifdim\@tempdima=10sp\vspace{-\intextsep}\fi
   \tab@setup
   \abovecaptionskip2H \belowcaptionskip6H \captionwidth.9\hsize
   \@float{table}}
  {\end@float}
\newenvironment{table*}
  {\tab@setup
   \abovecaptionskip2H \belowcaptionskip6H \captionwidth.9\hsize
   \@dblfloat{table}}
  {\end@dblfloat}

\newlength\abovecaptionskip
\newlength\belowcaptionskip
\newlength\captionwidth

\def\tabhead@font{\reset@font
  \sffamily\kanjifamily{mg}\fontsize{11\JQ}{14H}\selectfont}

\def\tabtext@font{\reset@font
  \sffamily\gtfamily\fontsize{11\JQ}{14H}\selectfont}

\def\tab@setup{%
  \let\bfseries\tabhead@font
  \tabtext@font
  \float@setup
}

\def\figtext@font{\reset@font
  \rmfamily\mcfamily\fontsize{11\JQ}{14H}\selectfont}

\def\fig@setup{%
  \let\source\figure@source
  \let\sourcewidth\captionwidth
  \figtext@font
  \float@setup
}

\def\figure@source@font{\reset@font
  \rmfamily\mcfamily\fontsize{8\JQ}{10H}\selectfont}

\newcommand*\figure@source[1]{%
  \vskip\abovecaptionskip
  \parbox[t]{\sourcewidth}{\raggedleft\figure@source@font #1}%
}

\def\float@setup{%
  \let\center\float@center \let\endcenter\endfloat@center
}

\def\float@center{%
  \topsep\z@\parsep\z@\partopsep\z@\itemsep\z@
  \trivlist \centering\item\relax}
\def\endfloat@center{\endtrivlist}

\AtEndOfClass{%
% %% hyperref.sty: overwrite original latex.ltx's \@caption
\long\def\@caption#1[#2]#3{%
  \par
  % \addcontentsline{\csname ext@#1\endcsname}{#1}%
  %   {\protect\numberline{\csname the#1\endcsname}{\ignorespaces #2}}%
  \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \small
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}
\let\clone@caption\@caption
\AtBeginDocument{%
  %% overwrite original latex.ltx's one when loading hyperref outside class file
  \@ifpackageloaded{hyperref}{\let\@caption\clone@caption}{}\relax}
}

\def\@floatboxreset{%
  \reset@font
  \small
  \setlength\tabcolsep{.5zw}%
  \setlength\arrayrulewidth{.15mm}%線幅
  \@setminipage
}

\let\captionnum@font\relax

\def\caption@font{\reset@font
  \sffamily\kanjifamily{mg}\fontsize{11\JQ}{14H}\selectfont}

\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  %% reset \captionwidth as default in minipage env
  \setbox\grnchry@boxa=\hbox{\let\newline\cr\relax
    \caption@font{\captionnum@font#1}\hskip1zw\shortstack[l]{\inhibitglue#2}}%
  \grnchry@dima=\dimexpr\ht\grnchry@boxa + \dp\grnchry@boxa\relax
  \ifdim\wd\grnchry@boxa > \captionwidth
    \grnchry@dimb=\captionwidth\relax
  \else
    \grnchry@dimb=\wd\grnchry@boxa\relax
  \fi
  \setbox\grnchry@boxb\hbox{\caption@font{\captionnum@font#1}\hskip1zw}%
  \ifdim\grnchry@dima > \baselineskip
    \hfil
    \parbox[t]{\grnchry@dimb}{%
      \hangindent\wd\grnchry@boxb
      \caption@font{\captionnum@font#1}\hskip1zw\inhibitglue#2}\par
  \else
    \ifdim\wd\grnchry@boxa > \captionwidth
      \hfil
      \parbox[t]{\grnchry@dimb}{%
        \hangindent\wd\grnchry@boxb
        \caption@font{\captionnum@font#1}\hskip1zw\inhibitglue#2}\par
    \else
      \hbox to\hsize{\hss\caption@font{\captionnum@font#1}\hskip1zw\inhibitglue#2\hss}\par
    \fi
  \fi
  \vskip\belowcaptionskip
}

\if@kddbkcapnumin\else
\let\fnum@figure\relax
\let\fnum@table\relax
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  %% reset \captionwidth as default in minipage env
  \setbox\grnchry@boxa=\hbox{\let\newline\cr\relax
    \shortstack[l]{\caption@font\inhibitglue#2}}%
  \grnchry@dima=\dimexpr\ht\grnchry@boxa + \dp\grnchry@boxa\relax
  \ifdim\wd\grnchry@boxa > \captionwidth
    \grnchry@dimb=\captionwidth\relax
  \else
    \grnchry@dimb=\wd\grnchry@boxa\relax
  \fi
  %%
  \hfil
  \parbox[t]{\grnchry@dimb}{%
    \caption@font\inhibitglue#2}\par
  \vskip\belowcaptionskip
}
\fi

\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{.5zw}
\newcommand{\@footnoterulewidth}{.1mm}%footnotemark時の罫線
\setlength\arrayrulewidth{.15mm}%表罫
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}

\skip\@mpfootins = \skip\footins

\setlength\fboxsep{.5zw}
\setlength\fboxrule{.2mm}%表罫

\@addtoreset{equation}{chapter}
\renewcommand{\theequation}{%
  \ifnum\c@chapter>\z@\thechapter.\fi \@arabic\c@equation}

\setcounter{tocdepth}{2}
\newcommand{\@pnumwidth}{2\Cwd}%2zw
\newcommand{\@tocrmarg}{3zw}
%% \newcommand{\@dotsep}{4.5}
%% \newdimen\toclineskip\setlength\toclineskip{\z@}
\def\toclineskip{\z@\@plus \z@\@minus \z@}
\newdimen\@lnumwidth

\def\numberline#1{\hbox to\@lnumwidth{#1\hfil}}

\def\toccdotsfil{\nobreak{\reset@font
  \leaders\hbox to .3333zw{\hss\hbox{.}\hss}\hfill}\nobreak}

\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \addvspace{\toclineskip}%
    \begingroup
      \leftskip #2\relax
      \rightskip\@tocrmarg
      \parfillskip-\rightskip
      \parindent #2\relax
      \@afterindenttrue
      \interlinepenalty\@M
      \leavevmode
      \@lnumwidth #3\relax
      \advance\leftskip\@lnumwidth
      \hbox{}%
      \hskip-\leftskip
      #4\nobreak\toccdotsfil\nobreak
      \hbox to\@pnumwidth{\hss\reset@font\normalcolor #5}\par
    \endgroup
  \fi}

\def\addcontentsline#1#2#3{%
  \protected@write\@auxout
    {\let\label\@gobble \let\index\@gobble \let\glossary\@gobble
  \grnchry@tokena{\thepage}}%
    {\string\@writefile{#1}%
       {\protect\contentsline{#2}{#3}{\the\grnchry@tokena}}}%
}

\DeclareRobustCommand*{\DOCnewline}{\\}
\DeclareRobustCommand*{\TOCnewline}{\relax}

\newenvironment{TOC}{%
}{}

\newcommand{\tableofcontents}{%
  \if@bvpaper\sethanmen@tableofcontents\fi
  % \if@twocolumn\@restonecoltrue\onecolumn\else\@restonecolfalse\fi
  \grnchry@clearpage{toc@@breakbefore}%
  \begin{TOC}%
    \let\DOCnewline\relax\let\TOCnewline\\\relax
    \thispagestyle{footnombre}%
    \@makeextchapterhead{\contentsname}%
    \@mkboth{\contentsname}{\contentsname}%
    \@startmodifiedtoc{toc}%\@starttoc{toc}%
  \end{TOC}%
  % \if@restonecol\twocolumn\fi
  \clearpage
}

\def\@startmodifiedtoc#1{%
  \begingroup
    \makeatletter
    \IfFileExists{\jobname.m#1}{%
      \@input{\jobname.m#1}%
    }{%
      \@input{\jobname.#1}%
    }%
    \if@filesw
      \expandafter\newwrite\csname tf@#1\endcsname
      \immediate\openout \csname tf@#1\endcsname \jobname.#1\relax
    \fi
    \@nobreakfalse
  \endgroup}

\def\tocparthead@font{\reset@font
  \sffamily\kanjifamily{mg}\fontsize{26\JQ}{\Cvs}\selectfont}
\def\tocpartnum@font{\tocparthead@font}

\newcommand*{\l@part}[2]{%
  \ifnum \c@tocdepth >-2\relax
    \pagebreak[3]%
    \addpenalty{-\@highpenalty}%
    \addvspace{1.5\Cvs \@plus.5\Cvs \@minus.5\Cvs}%
    \begingroup
      \leftskip\z@\relax
      \parindent\z@
      \setbox\grnchry@boxa\hbox{\tocchapnum@font\space #2}%
      \def\@pnumwidth{\wd\grnchry@boxa}%
      \rightskip\@pnumwidth
      \parfillskip-\rightskip
      \leavevmode\tocparthead@font
      \setlength\@lnumwidth{5\Cwd}%
      \interlinepenalty\@M
      \advance\leftskip\@lnumwidth
      \hskip-\leftskip
      \inhibitglue #1\inhibitglue\nobreak\hfill\nobreak% \toccdotsfil\nobreak
      % \hbox to \@pnumwidth{\hss\tocpartnum@font #2}%
      \par\nobreak
      \kern1.5mm
      \begingroup
      % \color{black!50}%
      \hrule\@width\hanmenwidth\@height.2mm
      \endgroup
      \vspace*{-.5\Cvs \@plus.1\Cvs \@minus.01\Cvs}%
    \endgroup
    \global\@nobreaktrue
    \everypar{\global\@nobreakfalse\everypar{}}%
  \fi}

\def\tocchaphead@font{\reset@font
  \sffamily\fontsize{20\JQ}{\Cvs}\selectfont}
\def\tocchapnum@font{\tocchaphead@font}

\newcommand*{\l@chapter}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \addvspace{\Cvs \@plus.25\Cvs \@minus.25\Cvs}%
    \begingroup
      \leftskip\z@\relax
      \parindent\z@
      \setbox\grnchry@boxa\hbox{\tocchapnum@font\space #2}%
      \def\@pnumwidth{\wd\grnchry@boxa}%
      \rightskip\@pnumwidth
      \parfillskip-\rightskip
      \leavevmode\tocchaphead@font
      \setlength\@lnumwidth{4.5zw}%
      \interlinepenalty\@M
      \advance\leftskip\@lnumwidth
      \hskip-\leftskip
      \inhibitglue #1\inhibitglue\nobreak\hfill\nobreak% \toccdotsfil\nobreak
      % \hbox to \@pnumwidth{\hss\tocchapnum@font #2}
      \par
      % \penalty\@highpenalty
    \endgroup
    \global\@nobreaktrue
    \everypar{\global\@nobreakfalse\everypar{}}%
  \fi}

\def\tocsecthead@font{\reset@font
  \fontsize{12\JQ}{20H}\selectfont}
\def\tocsectnum@font{\tocsecthead@font}

\newcommand*{\l@section}[2]{%
  \addpenalty{-\@lowpenalty}%
  \addvspace{\toclineskip}%
  \begingroup
    \leftskip\Cwd\relax
    \setbox\grnchry@boxa\hbox{\tocsectnum@font\space #2}%
    \def\@pnumwidth{\wd\grnchry@boxa}%
    \rightskip\@pnumwidth
    \parfillskip-\rightskip
    \parindent5mm\relax
    \@afterindenttrue
    \interlinepenalty\@M
    \leavevmode\tocsecthead@font
    \setlength\@lnumwidth{3.5zw}%
    \advance\leftskip\dimexpr\@lnumwidth\relax
    \hskip-\leftskip
    \inhibitglue #1\inhibitglue\nobreak\toccdotsfil\nobreak
    \hbox to \@pnumwidth{\hss\tocsectnum@font #2}\@@par
  \endgroup
}

\def\tocextsecthead@font{\tocsecthead@font}
\def\tocextsectnum@font{\tocsecthead@font}

\newcommand*{\l@extchapter}[2]{%
  \addvspace{\toclineskip}%
  \begingroup
    \leftskip\Cwd\relax
    \setbox\grnchry@boxa\hbox{\tocextsectnum@font\space #2}%
    \def\@pnumwidth{\wd\grnchry@boxa}%
    \rightskip\@pnumwidth
    \parfillskip-\rightskip
    \parindent10mm\relax
    \@afterindenttrue
    \interlinepenalty\@M
    \leavevmode\tocextsecthead@font
    \setlength\@lnumwidth{4.5zw}%
    \advance\leftskip\dimexpr\@lnumwidth\relax
    \hskip-\leftskip
    \inhibitglue #1\inhibitglue\nobreak\toccdotsfil\nobreak
    \hbox to \@pnumwidth{\hss\tocextsectnum@font #2}\@@par
  \endgroup
}


\def\tocsubsecthead@font{\tocsecthead@font}
\def\tocsubsectnum@font{\tocsecthead@font}

\newcommand*{\l@subsection}[2]{%
  \addpenalty{-\@lowpenalty}%
  \addvspace{\toclineskip}%
  \begingroup
    \leftskip\Cwd\relax
    \setbox\grnchry@boxa\hbox{\tocsubsectnum@font\space #2}%
    \def\@pnumwidth{\wd\grnchry@boxa}%
    \rightskip\@pnumwidth
    \parfillskip-\rightskip
    \parindent4\Cwd\relax
    \@afterindenttrue
    \interlinepenalty\@M
    \leavevmode\tocsubsecthead@font
    \setlength\@lnumwidth{3.5zw}%
    \advance\leftskip\dimexpr\@lnumwidth\relax
    \hskip-\leftskip
    \inhibitglue #1\inhibitglue\nobreak\toccdotsfil\nobreak
    \hbox to \@pnumwidth{\hss\tocsubsectnum@font #2}\@@par
  \endgroup
}

\AtBeginDocument{%
\ifnum\c@tocdepth>\tw@
\let\l@subsection\@gobbletwo
\fi
}
\let\l@subsubsection\@gobbletwo
\let\l@paragraph\@gobbletwo
\let\l@subparagraph\@gobbletwo

%% 参考文献
\def\biblbody@font{\reset@font
  \small\loosehyphen}

\newdimen\bibindent
\setlength\bibindent{1.5em}
\newcommand{\newblock}{\hskip .11em\@plus.33em\@minus.07em}

\newenvironment{thebibliography}[1]{%
   \subsubsection*{\bibname}%
   \biblbody@font
   \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \topsep\z@\parsep\z@\partopsep\z@\itemsep\z@
         \@openbib@code
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy
   \clubpenalty4000
   \@clubpenalty\clubpenalty
   \widowpenalty4000
   \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
   \endlist}
\let\@openbib@code\@empty

\def\@biblabel#1{[#1]}

%% 索引
\def\theindex@font{\reset@font
  \fontsize{10\JQ}{13H}\selectfont\loosehyphen}

\RequirePackage{makeidx}\makeindex
\let\clone@printindex\printindex
\renewcommand*\printindex{%
  \if@backmatter\if@appendix
    \immediate\write\@auxout{\string\@writefile{toc}{%
      \string\onelineskip}}%
  \fi\fi
  \clone@printindex}

\RequirePackage{multicol}
\RequirePackage{needspace}
\newenvironment{theindex}{%
   % \if@twocolumn\@restonecolfalse\else\@restonecoltrue\fi
   \grnchry@clearpage{idx@@breakbefore}%
   \columnsep 2zw
   \columnseprule .2mm
   \begin{multicols}{2}[\@makeextchapterhead{\indexname}\vspace*{-\Cvs}]%
   \theindex@font
   \thispagestyle{footnombre}%
   \refstepcounter{chapter}%
   \addcontentsline{toc}{extchapter}{\indexname}%for PDF bookmark
   \@mkboth{\indexname}{\indexname}%
   \parindent\z@
   \parskip\z@
   \lineskiplimit\z@
   \lineskip\z@
   \raggedbottom
   \raggedcolumns
   \theindex@raggedright
   \let\item\@idxitem}
  {\end{multicols}%
   % \if@restonecol\onecolumn\else\clearpage\fi
   \clearpage
}

\def\theindex@raggedright{%
  \let\\\@centercr
  \@rightskip -.25mm plus 1fil %\@flushglue
  \rightskip\@rightskip
  \leftskip\z@skip
  \parindent\z@}

\newcommand{\@idxitem}{\par\leavevmode\hangindent1zw\inhibitglue}
\newcommand{\subitem}{\@idxitem\hangindent2zw\hspace*{1zw}\inhibitglue}
\newcommand{\subsubitem}{\@idxitem\hangindent3zw\hspace*{2zw}\inhibitglue}
\newcommand{\indexspace}{\par\vskip\baselineskip\relax}

\newcommand\idxdelim{\nobreak{\reset@font\space
  \leaders\hbox to .3333zw{\hss\hbox{.}\hss}\hfill\space}\nobreak}

\newcommand{\symbolindexname}{記号・数字}

\def\idxhead@font{\reset@font
  \bfseries\fontsize{10\JQ}{13H}\selectfont}

\def\makeidxhead#1{\edef\@temp{#1}\ifx\@temp\@empty\relax\else
  \needspace{2\baselineskip}%
  \@tempskipa\baselineskip
  \vskip-\prevdepth \prevdepth\z@ \vskip\baselineskip
  \advance\@tempskipa-2\baselineskip
  \vspace{\baselineskip}%
  \vspace*{\@tempskipa}\par
  \hbox to \columnwidth{%
    \raise.5mm\hbox{\clone@underline{\hbox to \columnwidth{\@makeidxhead@background{#1}\hss}}}\hss}\par
  \nopagebreak
\fi}

\def\@makeidxhead@background#1{%
  \leavevmode\idxhead@font #1}

\def\footnotemark@font{\reset@font
  \fontsize{.65\dimexpr\grnchry@Qnum\JQ}{.65\dimexpr\grnchry@Qnum\JQ}\selectfont}

\def\footnote@font{\reset@font
  \fontsize{10\JQ}{14H}\selectfont}

\let\clone@footnote\footnote
\let\clone@footnotemark\footnotemark
\def\footnote{\unskip\inhibitglue\penalty\@M\clone@footnote}
\def\footnotemark{\unskip\inhibitglue\penalty\@M\clone@footnotemark}

\renewcommand{\footnoterule}{%
  \kern-3\p@
  \hrule\@width\hanmenwidth\@height\@footnoterulewidth
  \kern 2.6\p@}

\@addtoreset{footnote}{chapter}

\renewcommand\@makefnmark{\hbox{}\hbox{\smash{\@textsuperscript{%
  \footnotemark@font\@thefnmark}}}\hbox{}}

\newcommand\@makefntext[1]{%
  \clubpenalty\@M
  \widowpenalty\@M
  \noindent
  \footnote@font
  \@hangfrom{\hbox to 2.75zw{%
    \let\@textsuperscript\relax
    \@makefnmark\hss}}\relax\inhibitglue #1}

\newcommand{\prepartname}{第}
\newcommand{\postpartname}{部}
\newcommand{\prechaptername}{第}
\newcommand{\postchaptername}{章}
\newcommand{\contentsname}{目次}
%% \newcommand{\listfigurename}{図目次}
%% \newcommand{\listtablename}{表目次}
\newcommand{\bibname}{参考文献}
\newcommand{\indexname}{索引}
\newcommand{\figurename}{図}
\newcommand{\tablename}{表}
\newcommand{\appendixname}{付録}

\def\opgbrkt@inhibitglue{%
  \inhibitglue}
\def\opgbrkt@hook{\futurelet\@let@token\@opgbrkt@hook}
%% \let\opgbrkt@hook\relax
\def\@opgbrkt@hook{%
  \ifx\@let@token（\opgbrkt@inhibitglue
  \else\ifx\@let@token〔\opgbrkt@inhibitglue
  \else\ifx\@let@token［\opgbrkt@inhibitglue
  \else\ifx\@let@token｛\opgbrkt@inhibitglue
  \else\ifx\@let@token〈\opgbrkt@inhibitglue
  \else\ifx\@let@token《\opgbrkt@inhibitglue
  \else\ifx\@let@token「\opgbrkt@inhibitglue
  \else\ifx\@let@token『\opgbrkt@inhibitglue
  \else\ifx\@let@token【\opgbrkt@inhibitglue
  \fi\fi\fi\fi\fi\fi\fi\fi\fi
}

\smallskipamount=.25\Cvs \@plus.1\Cdp \@minus.1\Cdp
\medskipamount  =.5\Cvs \@plus.1\Cdp \@minus.1\Cdp
\bigskipamount  =\Cvs \@plus.1\Cdp \@minus.1\Cdp

\def\makelines#1{%
  \grnchry@cnta\z@\relax
  \def\@makeline@f@size{\f@size}%
  \@whilenum\grnchry@cnta<#1\do{%
    \advance\grnchry@cnta\@ne\relax
    \noindent\rlap{\the\grnchry@cnta}\nobreak
    \makelines@neline\par}%
}
\def\makelines@unit@#10#2\relax{%
  \ifx!#2!\relax □\else\relax ■\fi}%
\newcounter{makelines@unit}
\def\makelines@neline{%
  \c@makelines@unit\@ne
  \@whilenum\c@makelines@unit<\dimexpr(\textwidth + \Cwd)/\Cwd\do{%
    \expandafter\makelines@unit@\the\c@makelines@unit0\relax
  \advance\c@makelines@unit\@ne}%
}

%% useful local macros
%% include fullpage graphics
\newcommand*\includefullpagegraphics{%
  \clearpage
  \ltx@ifstar
    {\@includefullpagegraphics}%
    {\thispagestyle{empty}\@includefullpagegraphics}
}

\newcommand*\@includefullpagegraphics[2][]{%
  \iftdir
    \vbox to \hanmenwidth{%
      \ifodd\c@page
        \vskip-\dimexpr\evensidemargin - .5\topskip + 1in\relax
      \else
        \vskip-\dimexpr\oddsidemargin - .5\topskip + 1in\relax
      \fi
      \vbox to \paperwidth{\vss
        \hbox to \hanmenheight{%
          \hskip-\grnchry@head\relax
          \hbox to \paperheight{\hss
            \rotatebox{90}{\includegraphics[#1]{#2}}%
          \hss}%
        \hss}%
      \vss}%
    \vss}%
  \else
    \vbox to \textheight{%
      \vskip-\grnchry@head
      \vbox to \paperheight{\vss
        \hbox to \textwidth{%
          \ifodd\c@page
            \hskip-\dimexpr\oddsidemargin + 1in\relax
          \else
            \hskip-\dimexpr\evensidemargin + 1in\relax
          \fi
          \hbox to \paperwidth{\hss
            \includegraphics[#1]{#2}%
          \hss}%
        \hss}%
      \vss}%
    \vss}%
  \fi
  \clearpage
}

%% 均等
\newcommand*{\kintou}[2]{%
  \leavevmode
  \hbox to #1{%
    \kanjiskip=0pt plus 1fil minus 1fil
    \xkanjiskip=\kanjiskip
    #2}}

%% ルビ
%%  * グループルビ
\DeclareRobustCommand*\ruby[2]{%
  \leavevmode% \setbox0=\hbox{#1}\setbox1=\hbox{\tiny#2}%
  \begingroup
    %% \@tempdima\f@size\p@\relax \divide\@tempdima by \tw@
    \@tempdima=\f@size\p@\relax
    \@tempdima=\nxtpub@ruby@@fontsizescale\@tempdima\relax
    \def\tiny{\@setfontsize\tiny{\@tempdima}{\z@}}%
    \setbox\z@=\hbox{#1}\setbox\@ne=\hbox{\tiny#2}%
      \ifdim\wd\z@>\wd\@ne\dimen\z@=\wd\z@\else\dimen\z@=\wd\@ne\fi
      \penalty\@lowpenalty
      \smash{\hbox{\kanjiskip=\fill
        \vbox{% \hbox to \dimen\z@{\hfil\box\@ne\hfil}%
          \hbox to \dimen\z@{\tiny\hspace*{.125zw}\hfil#2\hfil\hspace*{.125zw}}%
          \nointerlineskip\hbox to \dimen\z@{\hfil\box\z@\hfil}}}}%
  \endgroup}
\let\clone@ruby\ruby

%% 半行アキ、１行アキ、白ページ
\newcommand\halflineskip{\par\vskip.5\baselineskip\par}
\newcommand\onelineskip{\par\vskip\baselineskip\par}
\newcommand\oneblankpage{\clearpage\thispagestyle{empty}%
  \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi}

\newcommand*{\loosehyphen}{%
  \hyphenpenalty=50\relax\exhyphenpenalty=50\relax}

%% url コマンド
\DeclareRobustCommand\url@grnchry@font{\relax}
\AtBeginDocument{%
  \@ifpackageloaded{url}{}{\RequirePackage{url}}%%
  %% modified url.sty
  %% default style assignments
  \def\UrlBreaks{%
    \do\0\do\1\do\2\do\3\do\4\do\5\do\6\do\7\do\8\do\9%
    \do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M\do\N%
    \do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X\do\Y\do\Z%
    \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j\do\k\do\l\do\m\do\n%
    \do\o\do\p\do\q\do\r\do\s\do\t\do\u\do\v\do\w\do\x\do\y\do\z%
    %%
    \do\.\do\@\do\\\do\/\do\!\do\_\do\|\do\;\do\>\do\]%
    \do\)\do\,\do\?\do\&\do\'\do+\do\=\do\#}%
  \def\UrlBigBreaks{\do\:\do@url@hyp}%
  \def\UrlNoBreaks{\do\(\do\[\do\{\do\<}%
  % any ordinary characters that aren't usually:
  \def\UrlOrds{\do\*\do\-\do\~\do\'\do\"\do\-}%
  \def\UrlSpecials{\do\ {\Url@space}\do\%{\Url@percent}\do\^^M{\Url@space}%
     \Url@force@Tilde}% package option may force faked text-ascii-tilde
  %%
  \def\url@grnchrystyle{\def\UrlFont{\url@grnchry@font}}%we use \relax as default
  \urlstyle{grnchry}%
  \let\URL\url\relax
}

%% stuff ends here

\postbreakpenalty\jis"2146=10000%"             %2146 ‘
\prebreakpenalty\jis"2147=10000 %"default: 5000%2147 ’
\postbreakpenalty\jis"2148=10000%"default: 5000%2148 “
\prebreakpenalty\jis"2149=10000 %"default: 5000%2149 ”
\postbreakpenalty`（=10000%214A （
\prebreakpenalty`）=10000 %214B ）
\postbreakpenalty`〔=10000%214C 〔
\prebreakpenalty`〕=10000 %214D 〕
\postbreakpenalty`［=10000%214E ［
\prebreakpenalty`］=10000 %214F ］
\postbreakpenalty`｛=10000%2150 ｛
\prebreakpenalty`｝=10000 %2151 ｝
\postbreakpenalty`〈=10000%2152 〈
\prebreakpenalty`〉=10000 %2153 〉
\postbreakpenalty`《=10000%2154 《
\prebreakpenalty`》=10000 %2155 》
\postbreakpenalty`「=10000%2156 「
\prebreakpenalty`」=10000 %2157 」
\postbreakpenalty`『=10000%2158 『
\prebreakpenalty`』=10000 %2159 』
\postbreakpenalty`【=10000%215A 【
\prebreakpenalty`】=10000 %215B 】

\prebreakpenalty`"=10000
\prebreakpenalty`℃=10000
\prebreakpenalty`　=10000
\prebreakpenalty`・=10000
\prebreakpenalty`〜=10000
\prebreakpenalty`ー=10000
\prebreakpenalty`？=10000
\prebreakpenalty`！=10000
% \postbreakpenalty"5C=10000%"\textquotedblleft: 92/OT1
\postbreakpenalty"10=10000%"\textquotedblleft: 16/T1

\inhibitxspcode`〒=2
\xspcode`+=3
\xspcode`\%=3
\grnchry@cnta="80 \@whilenum\grnchry@cnta<"100 \do{%
  \xspcode\grnchry@cnta=3\advance\grnchry@cnta\@ne}

\def\sloppy{%
  \tolerance9999
  \hbadness9999
  \emergencystretch 3zw
  \hfuzz .5\p@
  \vfuzz\hfuzz}

\tolerance5000%5000; default: 200
\hbadness5000 %5000; default: 1000
\pretolerance\m@ne%\m@ne; default: 100
%% \vbadness10001%10001; default: 1000
\clubpenalty\z@ %\z@; default: 150
\widowpenalty\z@%\z@; default: 150

\kanjiskip\z@ \@plus.25zw \@minus\z@\relax
\xkanjiskip.25zw \@plus.25zw \@minus.125zw\relax
%% \emergencystretch 3zw

\pagestyle{bothstyle}
\pagenumbering{arabic}
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
  \raggedbottom% default: \flushbottom
\fi

%% \AtEndOfClass{%
%% }

\AtBeginDocument{%
\everypar{\opgbrkt@hook}%
%% amsmath: for Japanese script
\@ifundefined{allowdisplaybreaks}{}{%
  \displaywidowpenalty\z@
  \interdisplaylinepenalty\z@
  \predisplaypenalty\z@
  \postdisplaypenalty\z@
}%
%% colortbl: for colored cell
\@ifundefined{CT@setup}{}{%
  \def\@cline#1-#2\@nil{%
    \noalign{\vskip-\arrayrulewidth}%
    \omit
    \@multicnt#1%
    \advance\@multispan\m@ne
    \ifnum\@multicnt=\@ne\@firstofone{&\omit}\fi
    \@multicnt#2%
    \advance\@multicnt-#1%
    \advance\@multispan\@ne
    {\CT@arc@\leaders\hrule\@height\arrayrulewidth\hfill}%
    \cr
  }%
}%
%% geometry: not support one
\@ifpackageloaded{geometry}{%
  \grnchry@error{'kddbook.cls' does not support the package 'geometry'.}%
}{}\relax
}

%% \AtEndDocument{%
%% }

\RequirePackage[dvipdfmx, \if@pdfhyperlink\else draft,\fi
  bookmarks=true,
  bookmarksnumbered=true,
  hidelinks,
  setpagesize=false,
  % bookmarksdepth=2,
  pdftrapped=false,
  pdflang=ja,
]{hyperref}
\RequirePackage[dvipdfmx]{pxjahyper}

\iftombow
  \hoffset=\dimexpr (210mm - \paperwidth)/2 - 1in\relax
  \voffset=\dimexpr (297mm - \paperheight)/2 - 1in\relax
\fi

\AtBeginDvi{%
\iftombow
  \special{papersize=210mm,297mm}%a4
\else\if@mentuke\else
  \special{papersize=\the\pdfpaperwidth,\the\pdfpaperheight}%
\fi\fi
}

\AtBeginShipout{%
\iftombow
  \setbox\AtBeginShipoutBox=\hbox{%
    %%MB
    \grnchry@dima=210mm\relax\grnchry@dimb=297mm\relax%%a4
    \grnchry@pdf@set@p@{\grnchry@pdf@mbwidth}{\grnchry@dima}%
    \grnchry@pdf@set@p@{\grnchry@pdf@mbheight}{\grnchry@dimb}%
    %%TB
    \grnchry@pdf@set@p@{\grnchry@pdf@tbhoffset}{\dimexpr\hoffset + 1in}%
    \grnchry@pdf@set@p@{\grnchry@pdf@tbvoffset}{\dimexpr\voffset + 1in}%
    \grnchry@pdf@set@p@{\grnchry@pdf@tbwidth}{\dimexpr\paperwidth + \hoffset + 1in}%
    \grnchry@pdf@set@p@{\grnchry@pdf@tbheight}{\dimexpr\paperheight + \voffset + 1in}%
    %%BB
    \grnchry@dima=\dimexpr\hoffset - \pdfcutoffset + 1in\relax
    \if@spreadbleedbox\ifodd\c@page
      \grnchry@dima=\dimexpr\hoffset + 1in\relax
    \fi\fi
    \grnchry@pdf@set@p@{\grnchry@pdf@bbhoffset}{\grnchry@dima}%
    \grnchry@pdf@set@p@{\grnchry@pdf@bbvoffset}{\dimexpr\voffset - \pdfcutoffset + 1in}%
    \grnchry@dima=\dimexpr\paperwidth + \hoffset + \pdfcutoffset + 1in\relax
    \if@spreadbleedbox\ifodd\c@page\else
      \grnchry@dima=\dimexpr\paperwidth + \hoffset + 1in\relax
    \fi\fi
    \grnchry@pdf@set@p@{\grnchry@pdf@bbwidth}{\grnchry@dima}%
    \grnchry@pdf@set@p@{\grnchry@pdf@bbheight}{\dimexpr\paperheight + \voffset + \pdfcutoffset + 1in}%
    \special{pdf: put @thispage <<
      /MediaBox[0 0 \grnchry@pdf@mbwidth\space\grnchry@pdf@mbheight]
      /TrimBox[\grnchry@pdf@tbhoffset\space\grnchry@pdf@tbvoffset\space\grnchry@pdf@tbwidth\space\grnchry@pdf@tbheight]
      % /ArtBox[\grnchry@pdf@tbhoffset\space\grnchry@pdf@tbvoffset\space\grnchry@pdf@tbwidth\space\grnchry@pdf@tbheight]
      /BleedBox[\grnchry@pdf@bbhoffset\space\grnchry@pdf@bbvoffset\space\grnchry@pdf@bbwidth\space\grnchry@pdf@bbheight]
    >>}%
    \box\AtBeginShipoutBox}%
\else\if@mentuke\else
  \setbox\AtBeginShipoutBox=\hbox{%
    %%MB=BB
    \grnchry@dima=\pdfpaperwidth\relax
    \if@spreadbleedbox\ifodd\c@page\else
      \ifdim\dimexpr\grnchry@papercutoffset>\z@\relax
        \grnchry@dima=\dimexpr\pdfpaperwidth - \hoffset\relax
      \fi
    \fi\fi
    \grnchry@pdf@set@p@{\grnchry@pdf@mbwidth}{\grnchry@dima}%
    \grnchry@pdf@set@p@{\grnchry@pdf@mbheight}{\pdfpaperheight}%
    \grnchry@dima=\z@\relax
    \if@spreadbleedbox\ifodd\c@page
      \ifdim\dimexpr\grnchry@papercutoffset>\z@\relax
        \grnchry@dima=\hoffset\relax
      \fi
    \fi\fi
    \grnchry@pdf@set@p@{\grnchry@pdf@mbhoffset}{\grnchry@dima}%
    \grnchry@pdf@set@p@{\grnchry@pdf@mbvoffset}{\z@}%
    %%TB
    \grnchry@pdf@set@p@{\grnchry@pdf@tbhoffset}{\hoffset}%
    \grnchry@pdf@set@p@{\grnchry@pdf@tbvoffset}{\voffset}%
    \grnchry@pdf@set@p@{\grnchry@pdf@tbwidth}{\dimexpr\paperwidth + \hoffset}%
    \grnchry@pdf@set@p@{\grnchry@pdf@tbheight}{\dimexpr\paperheight + \voffset}%
    %%BB when setting spread page
    \grnchry@dima=\pdfpaperwidth\relax
    \if@spreadbleedbox\ifodd\c@page\else
      \ifdim\dimexpr\grnchry@papercutoffset>\z@\relax
        \grnchry@dima=\dimexpr\pdfpaperwidth - \hoffset\relax
      \fi
    \fi\fi
    \grnchry@pdf@set@p@{\grnchry@pdf@bbwidth}{\grnchry@dima}%
    \grnchry@pdf@set@p@{\grnchry@pdf@bbheight}{\pdfpaperheight}%
    \grnchry@dima=\z@\relax
    \if@spreadbleedbox\ifodd\c@page
      \ifdim\dimexpr\grnchry@papercutoffset>\z@\relax
        \grnchry@dima=\hoffset\relax
      \fi
    \fi\fi
    \grnchry@pdf@set@p@{\grnchry@pdf@bbhoffset}{\grnchry@dima}%
    \grnchry@pdf@set@p@{\grnchry@pdf@bbvoffset}{\z@}%
    \special{pdf: put @thispage <<
%      /MediaBox[0 0 \grnchry@pdf@mbwidth\space\grnchry@pdf@mbheight]
      /MediaBox[\grnchry@pdf@mbhoffset\space\grnchry@pdf@mbvoffset\space\grnchry@pdf@mbwidth\space\grnchry@pdf@mbheight]
      /TrimBox[\grnchry@pdf@tbhoffset\space\grnchry@pdf@tbvoffset\space\grnchry@pdf@tbwidth\space\grnchry@pdf@tbheight]
      % /ArtBox[\grnchry@pdf@tbhoffset\space\grnchry@pdf@tbvoffset\space\grnchry@pdf@tbwidth\space\grnchry@pdf@tbheight]
%      /BleedBox[0 0 \grnchry@pdf@mbwidth\space\grnchry@pdf@mbheight]
      /BleedBox[\grnchry@pdf@bbhoffset\space\grnchry@pdf@bbvoffset\space\grnchry@pdf@bbwidth\space\grnchry@pdf@bbheight]
    >>}%
    \box\AtBeginShipoutBox}%
\fi\fi
}

\newdimen\grnchry@pdf@dim
\newcommand\grnchry@pdf@set@p@[2]{%
  \grnchry@pdf@dim=.9963#2\relax
  \edef#1{\expandafter\@grnchry@PDF@GET@P@\the\grnchry@pdf@dim}}
{\catcode`p=12\catcode`t=12\gdef\@grnchry@PDF@GET@P@#1pt{#1}}

\listfiles
\endinput

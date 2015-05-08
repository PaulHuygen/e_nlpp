\documentclass[twoside,oldtoc]{artikel3}
\pagestyle{headings}
\usepackage{pdfswitch}
\usepackage{figlatex}
\usepackage{makeidx}
\renewcommand{\indexname}{General index}
\makeindex
\newcommand{\thedoctitle}{Standardised English NLP pipeline}
\newcommand{\theauthor}{Paul Huygen <paul.huygen@@huygen.nl>}
\newcommand{\thesubject}{Standardised English pipeline}
\newcommand{\CLTL}{\textsc{cltl}}
\newcommand{\EHU}{\textsc{ehu}}
\newcommand{\NAF}{\textsc{naf}}
\newcommand{\NED}{\textsc{ned}}
\newcommand{\NER}{\textsc{ner}}
\newcommand{\NERC}{\textsc{nerc}}
\newcommand{\NLP}{\textsc{nlp}}
\newcommand{\SRL}{\textsc{srl}}
\def\CaptionTextFont{\small\slshape}
\title{\thedoctitle}
\author{\theauthor}
\date{\today \\ m4_time_of_day~h.}
% Packages.
\usepackage{a4wide}
\usepackage{alltt}
\usepackage{color}
%\usepackage{lmodern}
%\usepackage[latin1]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage[british]{babel}
%
% Commands for frequently used constructions
%
\newcommand{\pdf}{\textsc{pdf}}
\newcommand{\HTML}{\textsc{html}}
\newcommand{\URI}{\textsc{uri}}
\newcommand{\URL}{\textsc{url}}
%
% PDF-specific settings
%
\ifpdf
% \usepackage[pdftex]{graphicx}       %%% graphics for dvips
% \usepackage[pdftex]{thumbpdf}      %%% thumbnails for ps2pdf
% \usepackage[pdftex]{thumbpdf}      %%% thumbnails for pdflatex
% \usepackage[pdftex,                %%% hyper-references for pdflatex
% bookmarks=true,%                   %%% generate bookmarks ...
% bookmarksnumbered=true,%           %%% ... with numbers
% a4paper=true,%                     %%% that is our papersize.
% hypertexnames=false,%              %%% needed for correct links to figures !!!
% breaklinks=true,%                  %%% break links if exceeding a single line
% linkbordercolor={0 0 1}]{hyperref} %%% blue frames around links
% %                                  %%% pdfborder={0 0 1} is the
% %                                  default
% \hypersetup{
%   pdfauthor   = {\theauthor},
%   pdftitle    = {\thedoctitle},
%   pdfsubject  = {web program},
%  }
 \renewcommand{\NWlink}[2]{\hyperlink{#1}{#2}}
 \renewcommand{\NWtarget}[2]{\hypertarget{#1}{#2}}
 \renewcommand{\NWsep}{$\diamond$\rule[-1\baselineskip]{0pt}{1\baselineskip}}
\makeatletter
\if@@oldtoc
  \renewcommand\toc@@font[1]{\relax}
\else
  \renewcommand*\toc@@font[1]{%
    \ifcase#1\relax
    \chaptocfont
    \or\slshape
    \or\rmfamily
    \fi}
\fi
\makeatother
\else
%\usepackage[dvips]{graphicx}        %%% graphics for dvips
%\usepackage[latex2html,             %%% hyper-references for ps2pdf
%bookmarks=true,%                   %%% generate bookmarks ...
%bookmarksnumbered=true,%           %%% ... with numbers
%hypertexnames=false,%              %%% needed for correct links to figures !!!
%breaklinks=true,%                  %%% breaks lines, but links are very small
%linkbordercolor={0 0 1},%          %%% blue frames around links
%pdfborder={0 0 112.0}]{hyperref}%  %%% border-width of frames 
\usepackage{html}
\renewcommand{\NWlink}[2]{\hyperlink{#1}{#2}}
\renewcommand{\NWtarget}[2]{\hypertarget{#1}{#2}}
\fi
%
% Settings
%
\raggedbottom
\newcommand{\chaptocfont}{\large\bfseries}

\newcommand{\pdfpsinc}[2]{%
\ifpdf
  \input{#1}
\else
  \input{#2}
\fi
}
\begin{document}
\maketitle
\begin{abstract}
  This is a description and documentation of the installation of english \NLP{}
  modules. It uses the infrastructure of nlpp (\url{git@@github.com:PaulHuygen/nlpp.git})
\end{abstract}
\tableofcontents

\section{Introduction}
\label{sec:Introduction}


This document describes the current set-up of pipeline that annotates
english texts in order to extract knowledge. The pipeline has been set
up by menbers of the Newsreader project~\footnote{http://www.newsreader-project.eu}. 

Apart from describing the pipeline set-up, the document actually sets
up the pipeline. It uses the infra-structure that has been created for
the dutch pipeline (\url{n4_nlpprepo}).

The installation has been parameterized. The locations and names that
you read (and that will be used to build the pipeline) have been read
from variables in file \texttt{inst.m4} in the nuweb directory.  


\section{How it works}
\label{sec:how}

This thing can be placed in a directory that also contains an
installation of \texttt{nlpp}. This installation supplies a suitable
java complier and a virtual environment for Python. 

When this thing is activated, it downloads the modules for the english
pipeline from a newsreader repository and it generates scripts that
apply the modules on a \NAF{} file. A test script demonstrates that
the pipeline actually works.

The following Makefile performs everything.

@o ../Makefile -t @{
configure_modules:
	@< configure modules @>

@< rules of Makefile @>

@| @}


@d variables of Makefile @{nlpproot = /home/paul/projecten/cltl/pipelines/nlpp
@| @}


@o ../bin/configure_modules @{#!/usr/bin/env python
import string
import os
import sys
from subprocess import call
nlpproot = "/home/paul/projecten/cltl/pipelines/nlpp"
projroot = "/home/paul/projecten/cltl/pipelines/e_nlpp"
comproot = "/home/paul/projecten/cltl/pipelines/e_nlpp/components"

@< methods in configure_modules @>

@| @}




\section{Computer environment}
\label{sec:computerenvironment}

The modules use the environment that has been set up for the dutch pipeline.

@d load progenvironment @{source /home/paul/projecten/cltl/pipelines/nlpp/bin/progenv
export modulesdir=/home/paul/projecten/cltl/pipelines/e_nlpp/components
@| @}



\section{Download the modules}
\label{sec:download}


@d rules of Makefile @{updatemods:
	rsync -azr -e "ssh -i nrkey -p 2223" newsreader`'@@`'u017940.si.ehu.es`':components .
@| @}



\subsection{Tokenizer}
\label{sec:tokenizer}
We can run the tokenizer that we use in the Dutch pipeline.

Script to run the tokenizer:

@o ../bin/tok @{#!/bin/bash
@< load progenvironment @>
JARFILE=/home/paul/projecten/cltl/pipelines/nlpp/env/java/jars/ixa-pipe-tok-1.8.0.jar
java -Xmx1000m -jar $JARFILE tok -l en --inputkaf

@| @}

\subsection{Pos}
\label{sec:pos}

Script to run the pos-tagger:

@o ../bin/pos @{#!/bin/bash
@< load progenvironment @>
rootDir=/home/paul/projecten/cltl/pipelines/e_nlpp/components/EHU-pos
java -jar ${rootDir}/ixa-pipe-pos-1.2.0.jar tag

@| @}



\subsection{NERC}
\label{sec:nerc}

Use the \NERC{} module from the dutch pipeline, because it is more
recent. However, the resource4s needed form the Englisfh version
contain absolute, hence obsolete, paths. Change these paths.

@d variables of Makefile @{nercresourcepropfile=${nlpproot}/modules/EHU-nerc/nerc-resources/en-brown-clark-600-conll03-testa
@|nercresourcepropfile @}

It has to do the following:

\begin{itemize}
\item Check whether the string \verb|/home/newsreader|  is still in
  it. Otherwise we are ready
\item Read the file in a string
\item Replace \verb|/home/newsreader/components| by \verb|/home/paul/projecten/cltl/pipelines/nlpp/modules|.
\item Overwrite the original file.
\end{itemize}

@o ../bin/configure_modules @{nercresourcepropfile = nlpproot + "/modules/EHU-nerc/nerc-resources/en/en-brown-clark-600-conll03-testa.prop"
obspart = "/home/newsreader/components"
replpart = nlpproot + "/modules"
repl_strings_in_file(nercresourcepropfile, obspart, replpart)
@| @}





Script to run the \NERC{} module:

@o ../bin/nerc @{#!/bin/bash
@< load progenvironment @>
MODDIR=$PIPEMODD/EHU-nerc
JAR=$JARDIR/ixa-pipe-nerc-1.3.6.jar
MODEL=en-brown-clark-600-conll03-testa.bin
 cat | java -Xmx1000m -jar $JAR tag -m $MODDIR/nerc-resources/en/$MODEL
@| @}


\subsection{Constituent parser}
\label{sec:constituentparser}

Script to run the \verb|EHU-parse| module:

@o ../bin/constparse @{#!/bin/bash
@< load progenvironment @>
MODDIR=/home/paul/projecten/cltl/pipelines/e_nlpp/components/EHU-parse
JAR=$MODDIR/ixa-pipe-parse-1.0.2.jar
java -Xmx1000m -jar $JAR  parse -g sem

@| @}


\subsection{Corefgraph}
\label{sec:corefgraph}

The corefgraph module \verb|EHU-corefgraph| is a Python
module. According to the doc (\verb|EHU-INSTALL|) it needs python
modules \verb|networkx| and \verb|pyyaml| that have already been
installed in \verb|nlpp|. Furthermore, it needs the \verb|pynaf|
module from \EHU{}. For now, we consider it done. According to Ridrigo
Agerri the final varsion of pynaf needs to be combined with corefgraph
version 2.1. 

Script to run the \verb|EHU-parse| module:

@o ../bin/corefgraph @{#!/bin/bash
@< load progenvironment @>
rootDir=/home/paul/projecten/cltl/pipelines/e_nlpp/components/EHU-corefgraph.v21
cd $rootDir
python -m corefgraph.process.file --reader NAF --writer NAF
@| @}

However, the script yields errors, even when run on its own
test-naf. I sent a message to Rodrigo.


\subsection{Opinion-miner}
\label{sec:opinionminer}

Component \verb|VUA-opinion-miner| contains a config file with
absolute pathnames in it. So, first correct that.

@o ../bin/configure_modules @{opinionconfigfile = comproot + "/VUA-opinion-miner/final_models/en/mpqa/config.cfg"
obspart = "/home/newsreader/components"
replpart = comproot
repl_strings_in_file(opinionconfigfile, obspart, replpart)

@| @}


@o ../bin/opinion  @{#!/bin/bash
@< load progenvironment @>
root=/home/paul/projecten/cltl/pipelines/e_nlpp/components/VUA-opinion-miner
export CRF_SUITE_PATH=$root/crfsuite/bin/crfsuite
export PATH=$PATH:$CRF_SUITE_PATH
python $root/classify_kaf_naf_file.py -m $root/final_models/en/mpqa/
@| @}


\subsection{UKB}
\label{sec:UKB}

UKB needs boost libraries and Perl version 5. For now, we consider them installed.


@o ../bin/ukb @{#!/bin/bash
@< load progenvironment @>
export PERL5LIB=$PERL5LIB:/home/newsreader/opt/lib/perl5
rootDir=../components/EHU-ukb
${rootDir}/naf_ukb/naf_ukb.pl -x ${rootDir}/ukb/bin/ukb_wsd -K ${rootDir}/wn30-ili_lkb/wn30g.bin64 -D ${rootDir}/wn30-ili_lkb/wn30.lex - -- --dict_weight --dgraph_dfs --dgraph_rank ppr

@| @}

\subsection{WSD}
\label{sec:wsd}

The module \verb|VUA-ims-wsd| seems to need Java version 1.6, so we
have to install it.

@o ../bin/configure_modules @{javasock = comproot + "/VUA-ims-wsd" 
javapath = javasock + "/jre1.6.0_45/bin" 
javaball = "jre-6u45-linux-x64.bin" 
javaballpath = projroot + "/jre-6u45-linux-x64.bin"
if ( not os.path.exists(javapath) ):
    if (not os.path.exists(javaballpath)):
       print "Please put jre-6u45-linux-x64.bin in /home/paul/projecten/cltl/pipelines/e_nlpp."
       sys.exit(1)
    shellcom = "cd " + javasock + "; chmod 775 " + javaballpath + " ; " + javaballpath
    call(shellcom, shell = True)
@| @}

@d set java 1.6 environment @{export JAVA_HOME=$rootDir/jre1.6.0_45
export PATH=$JAVA_HOME/bin:$PATH
@| @}

Change the java instructions in \verb|ims/testPlain.bash|

@o ../bin/configure_modules @{socket = comproot + "/VUA-ims-wsd"
pathtoims = socket + "/ims" 
badbashfile = "testPlain.bash"
badbashpath = pathtoims + "/" + badbashfile
obspart = "/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.0.x86_64/jre/bin/java"
replpart = "java"
repl_strings_in_file(badbashpath, obspart, replpart)
@| @}



Furthermore, a python script contains an absolute path, that we must
change.

@o ../bin/configure_modules @{scriptpath = socket + "/path_to_ims.py"  
pathinstruction = "PATH_TO_IMS = \"" + comproot + "/VUA-ims-wsd/ims\"\n"
fout = open(scriptpath, 'w')
fout.write(pathinstruction)
fout.close()

@| @}




@o ../bin/ims-wsd @{#!/bin/bash
@< load progenvironment @>
rootDir=/home/paul/projecten/cltl/pipelines/e_nlpp/components/VUA-ims-wsd
@< set java 1.6 environment @>
python $rootDir/call_ims.py -ili30

@| @}


\subsection{Ned}
\label{sec:ned}

@o ../bin/ned @{#!/bin/bash
@< load progenvironment @>
rootDir=/home/paul/projecten/cltl/pipelines/e_nlpp/components/EHU-ned
java -jar ${rootDir}/ixa-pipe-ned-1.1.1.jar -p 2020 -e candidates

@| @}


\subsection{srl}
\label{sec:srl}

Currently, module \verb|EHU-srl.v21| results in a null-pointer
exception when applied to the testfile from the \textsc{ned} module:

\begin{verbatim}
java.lang.NullPointerException
	at is2.parser.Decoder.decode(Decoder.java:82)
	at is2.parser.Parser.parse(Parser.java:478)
	at is2.parser.Parser.apply(Parser.java:503)
	at se.lth.cs.srl.preprocessor.Preprocessor.preprocess(Preprocessor.java:94)
	at ixa.srl.MatePipeline.parse(MatePipeline.java:128)
	at ixa.srl.MatePipeline.parseCoNLL09(MatePipeline.java:268)
	at ixa.srl.MatePipeline.Pipeline(MatePipeline.java:233)
	at ixa.srl.Annotate.annotate(Annotate.java:208)
	at ixa.srl.Annotate.SRLToKAF(Annotate.java:72)
	at ixa.srl.SRL.main(SRL.java:43)

\end{verbatim}

However, the module still produces a valid \NAF{} file.

Note that the \testsc{srl} module seems to require 2,5G of
memory. Take this into account when you want to apply
parallellisation.

@o ../bin/srl @{#!/bin/bash
@< load progenvironment @>
rootDir=/home/paul/projecten/cltl/pipelines/e_nlpp/components/EHU-srl.v21
exec java -jar -Xms2500m ${rootDir}/IXA-EHU-srl-2.0.jar en
@| @}

\subsection{Time}
\label{sec:time}

Note that this module utilises \verb|awk|

@o ../bin/time @{#!/bin/bash
@< load progenvironment @>
rootDir=/home/paul/projecten/cltl/pipelines/e_nlpp/components/FBK-time.v23
BEGINTIME=`date '+%Y-%m-%dT%H:%M:%S%z'`
YAMCHA=$rootDir/tools
timdir=`mktemp -d -t time.XXXXXX`
FILETXP=$timdir/TimePro.txp
CHUNKIN=$timdir/TimePro.naf
FILEOUT=$timdir/TimeProOUT.txp
TIMEPRONORMIN=$timdir/TimeProNormIN.txp
cd $rootDir
cat > $CHUNKIN
cat $CHUNKIN | java -cp "lib/jdom-2.0.5.jar:lib/kaflib-naf-1.0.2.jar:lib/NAFtoTXP_v10.jar" eu.fbk.newsreader.naf.NAFtoTXP_v10 $FILETXP chunk+entity timex

#echo "Saving... $FILETXP"
tail -n +4 $FILETXP | awk -f resources/english-rules > $FILEOUT
head -n +4 $FILETXP > $TIMEPRONORMIN

cat $FILEOUT | $YAMCHA/yamcha-0.33/usr/local/bin/yamcha -m models/tempeval3_silver-data.model >> $TIMEPRONORMIN
cat $TIMEPRONORMIN | $JAVA_HOME/bin/java -cp "lib/scala-library.jar:lib/timenorm-0.9.0.jar:lib/threetenbp-0.8.1.jar:lib/TimeProNorm_v2.4.jar" eu.fbk.timePro.TimeProNormApply $FILETXP


java -Dfile.encoding=UTF8 -cp "lib/TXPtoNAF_v3.jar:lib/jdom-2.0.5.jar:lib/kaflib-naf-1.0.2.jar" eu.fbk.newsreader.naf.TXPtoNAF_v3 $CHUNKIN $FILETXP "$BEGINTIME" TIMEX3 



#cat $FILETXP.out
#rm $FILETXP
#rm $FILETXP.out
rm $CHUNKIN

rm -rf $timdir
@| @}




\section{Miscellaneous}
\label{sec:misc}

\subsection{Replace strings in config files}
\label{sec:replstrings}

The following Python method replaces copies of an obsolete string
\verb|obs| by a replacement string \verb|repl| in a given file. 

@d methods in configure_modules @{def repl_strings_in_file( filepath, obs, repl):
    fin = open(filepath, 'r')
    sin = fin.read()
    fin.close()
    if (sin.find(obs) >= 0):
        sout = sin.replace(obs, repl)
        fout = open(filepath, 'w')
        fout.write(sout)
        fout.close()

@| @}


\section{Test}
\label{sec:test}

@d rules of Makefile @{test: nuweb/test.in.naf
	cd /home/paul/projecten/cltl/pipelines/e_nlpp/bin && chmod 775 test
	cd /home/paul/projecten/cltl/pipelines/e_nlpp/test && /home/paul/projecten/cltl/pipelines/e_nlpp/bin/test

@| @}

@o ../bin/test @{#!/bin/bash
ROOT=/home/paul/projecten/cltl/pipelines/e_nlpp
TESTDIR=$ROOT/test
BIND=$ROOT/bin
mkdir -p $TESTDIR
cd $TESTDIR
cat $TESTDIR/test.srl.naf | $BIND/time > $TESTDIR/test.time.naf


@| @}



\section{Perform}
\label{sec:perform}

@d rules of Makefile @{
sources :
	mkdir -p /home/paul/projecten/cltl/pipelines/e_nlpp/bin
	mkdir -p /home/paul/projecten/cltl/pipelines/e_nlpp/test
	cd nuweb && stripnw e_nlpp
	cd nuweb && nuweb e_nlpp.w
	chmod 775 bin/test
	chmod 775 bin/tok
	chmod 775 bin/pos
	chmod 775 bin/nerc
	chmod 775 bin/constparse
	chmod 775 bin/corefgraph
	chmod 775 bin/opinion
	chmod 775 bin/ukb
	chmod 775 bin/ims-wsd
	chmod 775 bin/ned
	chmod 775 bin/srl
	chmod 775 bin/time
	chmod 775 bin/configure_modules
	bin/configure_modules

@| @}


m4_include(inst.m4)m4_dnl
m4_sinclude(local.m4)m4_dnl
\documentclass[twoside,oldtoc]{artikel3}
@% \documentclass[twoside]{article}
\pagestyle{headings}
\usepackage{pdfswitch}
\usepackage{figlatex}
\usepackage{makeidx}
\renewcommand{\indexname}{General index}
\makeindex
\newcommand{\thedoctitle}{m4_doctitle}
\newcommand{\theauthor}{m4_author}
\newcommand{\thesubject}{m4_subject}
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
\date{m4_docdate}
m4_include(texinclusions.m4)m4_dnl
\begin{document}
\maketitle
\begin{abstract}
  This is a description and documentation of the installation of english \NLP{}
  modules. It uses the infrastructure of nlpp (\url{m4_nlpprepo})
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

@o ../Makefile -t @{@%
@% @< variables of Makefile @>

configure_modules:
	@< configure modules @>

@< rules of Makefile @>

@| @}


@d variables of Makefile @{@%
nlpproot = m4_asocket/nlpp
@| @}


@o m4_bindir/configure_modules @{@%
#!/usr/bin/env python
import string
import os
import sys
from subprocess import call
nlpproot = "m4_asocket/nlpp"
projroot = "m4_aprojroot"
comproot = "m4_amoddir"

@< methods in configure_modules @>

@| @}


@o m4_bindir/installmisc @{@%
#!/bin/bash
@| @}



\section{Computer environment}
\label{sec:computerenvironment}

The modules use the environment that has been set up for the dutch pipeline.

@d load progenvironment @{@%
source m4_aprogenvscript
export modulesdir=m4_amoddir
@| @}



\section{Download the modules}
\label{sec:download}


@d rules of Makefile @{@%
updatemods:
	rsync -azr -e "ssh -i m4_nrkey -p m4_nwrrepoport" m4_nwruser`'@@`'m4_nwrrepo`':components .
@| @}



\subsection{Tokenizer}
\label{sec:tokenizer}
We can run the tokenizer that we use in the Dutch pipeline.

Script to run the tokenizer:

@o m4_bindir/tok @{@%
#!/bin/bash
@< load progenvironment @>
JARFILE=m4_dp_jardir/m4_tokenizerjar
@% rootDir=m4_amoddir/EHU-tok
@% java -jar ${rootDir}/ixa-pipe-tok-1.5.0.jar tok -l en --inputkaf
java -Xmx1000m -jar $JARFILE tok -l en --inputkaf

@| @}

\subsection{Pos}
\label{sec:pos}

Script to run the pos-tagger:

@o m4_bindir/pos @{@%
#!/bin/bash
@< load progenvironment @>
rootDir=m4_amoddir/EHU-pos
java -jar ${rootDir}/ixa-pipe-pos-1.2.0.jar tag

@| @}



\subsection{NERC}
\label{sec:nerc}

Use the \NERC{} module from the dutch pipeline, because it is more
recent. However, the resource4s needed form the Englisfh version
contain absolute, hence obsolete, paths. Change these paths.

@d variables of Makefile @{@%
nercresourcepropfile=${nlpproot}/modules/EHU-nerc/nerc-resources/m4_anercresourcefilename
@|nercresourcepropfile @}

It has to do the following:

\begin{itemize}
\item Check whether the string \verb|/home/newsreader|  is still in
  it. Otherwise we are ready
\item Read the file in a string
\item Replace \verb|/home/newsreader/components| by \verb|m4_asocket/nlpp/modules|.
\item Overwrite the original file.
\end{itemize}

@o m4_bindir/configure_modules @{@%
nercresourcepropfile = nlpproot + "/modules/EHU-nerc/nerc-resources/en/m4_anercresourcefilename.prop"
obspart = "/home/newsreader/components"
replpart = nlpproot + "/modules"
repl_strings_in_file(nercresourcepropfile, obspart, replpart)
@% fin = open(nercresourcepropfile, 'r')
@% sin = fin.read()
@% fin.close()
@% if (sin.find(obspart) >= 0):
@%     sout = sin.replace(obspart, replpart)
@%     fout = open(nercresourcepropfile, 'w')
@%     fout.write(sout)
@%     fout.close()
@| @}


@% @o m4_bindir/configure_modules @{@%
@% nercresourcepropfile=$nlpproot/modules/EHU-nerc/nerc-resources/m4_anercresourcefilename
@% nerctmp=`mktemp -d -t nerctmp.XXXXXX`
@% cp nercresourcepropfile $nerctmp
@% sed s/\/home\/newsreader\/components\/EHU-nerc/\nerc-resources
@% @| @}



Script to run the \NERC{} module:

@o m4_bindir/nerc @{@%
#!/bin/bash
@< load progenvironment @>
MODDIR=$PIPEMODD/EHU-nerc
JAR=$JARDIR/ixa-pipe-nerc-1.3.6.jar
MODEL=en-brown-clark-600-conll03-testa.bin
@% cat | java -Xmx1000m -jar $JAR tag -p $MODDIR/nerc-resources/en/$MODEL
 cat | java -Xmx1000m -jar $JAR tag -m $MODDIR/nerc-resources/en/$MODEL
@| @}


\subsection{Constituent parser}
\label{sec:constituentparser}

Script to run the \verb|EHU-parse| module:

@o m4_bindir/constparse @{@%
#!/bin/bash
@< load progenvironment @>
MODDIR=m4_amoddir/EHU-parse
JAR=$MODDIR/m4_cparserjar<!!>-<!!>m4_cparserversion<!!>.jar
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

@o m4_bindir/corefgraph @{@%
#!/bin/bash
@< load progenvironment @>
@% #!/bin/bash
@% 
@% export PYTHONPATH=$PYTHONPATH:/home/newsreader/opt/lib/python2.7/
rootDir=m4_amoddir/m4_corefgraphmodule
cd $rootDir
python -m corefgraph.process.file --reader NAF --writer NAF
@| @}

However, the script yields errors, even when run on its own
test-naf. I sent a message to Rodrigo.


\subsection{Opinion-miner}
\label{sec:opinionminer}

Component \verb|VUA-opinion-miner| contains a config file with
absolute pathnames in it. So, first correct that.

@o m4_bindir/configure_modules @{@%
opinionconfigfile = comproot + "/m4_opimineconffilepath"
obspart = "/home/newsreader/components"
replpart = comproot
repl_strings_in_file(opinionconfigfile, obspart, replpart)
@% fin = open(nercresourcepropfile, 'r')
@% sin = fin.read()
@% fin.close()
@% if (sin.find(obspart) >= 0):
@%     sout = sin.replace(obspart, replpart)
@%     fout = open(nercresourcepropfile, 'w')
@%     fout.write(sout)
@%     fout.close()

@| @}


@o m4_bindir/opinion  @{@%
#!/bin/bash
@< load progenvironment @>
root=m4_amoddir/VUA-opinion-miner
export CRF_SUITE_PATH=$root/crfsuite/bin/crfsuite
export PATH=$PATH:$CRF_SUITE_PATH
python $root/classify_kaf_naf_file.py -m $root/final_models/en/mpqa/
@| @}


\subsection{UKB}
\label{sec:UKB}

UKB needs boost libraries and Perl version 5. For now, we consider them installed.

@% For \textsc{ukb} we need to install boost.
@% 
@% @o m4_bindir/install_things @{@%
@% #!/bin/bash
@% @< load progenvironment @>
@% boostdir=`mktemp -d -t boost.XXXXXX`
@% cd $boostdir
@% wget http://downloads.sourceforge.net/project/boost/boost/1.54.0/boost_1_54_0.tar.bz2
@% tar xjf boost_1_54_0.tar.bz2
@% cd boost_1_54_0
@% ./bootstrap.sh --prefix=/home/newsreader/opt --with-libraries=graph,system,filesystem,program_options,regex
@% sudo ./b2 install --layout=system
@% sudo ldconfig
@% cd
@% rm -fr $boostdir
@% 
@% @| @}

@o m4_bindir/ukb @{@%
#!/bin/bash
@< load progenvironment @>
export PERL5LIB=$PERL5LIB:/home/newsreader/opt/lib/perl5
rootDir=m4_moddir/EHU-ukb
${rootDir}/naf_ukb/naf_ukb.pl -x ${rootDir}/ukb/bin/ukb_wsd -K ${rootDir}/wn30-ili_lkb/wn30g.bin64 -D ${rootDir}/wn30-ili_lkb/wn30.lex - -- --dict_weight --dgraph_dfs --dgraph_rank ppr

@| @}

\subsection{WSD}
\label{sec:wsd}

The module \verb|VUA-ims-wsd| seems to need Java version 1.6, so we
have to install it.

@o m4_bindir/configure_modules @{@%
javasock = comproot + "/m4_wsdmodule" 
javapath = javasock + "/m4_java16pack/bin" 
javaball = "m4_java16ball" 
javaballpath = projroot + "/m4_java16ball"
if ( not os.path.exists(javapath) ):
    if (not os.path.exists(javaballpath)):
       print "Please put m4_java16ball in m4_aprojroot."
       sys.exit(1)
    shellcom = "cd " + javasock + "; chmod 775 " + javaballpath + " ; " + javaballpath
    call(shellcom, shell = True)
@| @}

@d set java 1.6 environment @{@%
export JAVA_HOME=$rootDir/m4_java16pack
export PATH=$JAVA_HOME/bin:$PATH
@| @}

Change the java instructions in \verb|ims/testPlain.bash|

@o m4_bindir/configure_modules @{@%
socket = comproot + "/m4_wsdmodule"
pathtoims = socket + "/ims" 
badbashfile = "m4_bad_ims_bashfile"
badbashpath = pathtoims + "/" + badbashfile
obspart = "/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.0.x86_64/jre/bin/java"
replpart = "java"
repl_strings_in_file(badbashpath, obspart, replpart)
@| @}



Furthermore, a python script contains an absolute path, that we must
change.

@o m4_bindir/configure_modules @{@%
@% pathtoims = comproot + "/m4_wsdmodule/ims" 
scriptpath = socket + "/m4_bad_wsd_pythonscript"  
@% scriptsocket = 
pathinstruction = "PATH_TO_IMS = \"" + comproot + "/m4_wsdmodule/ims\"\n"
fout = open(scriptpath, 'w')
fout.write(pathinstruction)
fout.close()

@% PATH_TO_IMS = '/home/newsreader/components/VUA-ims-wsd.v21/ims'
@| @}




@o m4_bindir/ims-wsd @{@%
#!/bin/bash
@< load progenvironment @>
rootDir=m4_amoddir/m4_wsdmodule
@< set java 1.6 environment @>
@% export PYTHONPATH=$PYTHONPATH:.:${compDir}/../opt/lib/python2.7/:${compDir}
@% export PATH=$JAVA_HOME/bin:$PATH:${compDir}:${compDir}/ims:.
python $rootDir/call_ims.py -ili30

@| @}


\subsection{Ned}
\label{sec:ned}

It seems that we can use the \NED{} module of the dutch pipeline, so
let us do that.

The \NED{} module needs to connect to a DBPedia server that needs 8GB
of memory. That means that when the dutch ane the engloish pipeline
run at the same time, 16GB of memory is occupied by the DBpedia
servers.

Anyway, before we run the \NED{} module, we chack whether the DBPedia
server is available and install it if this is not the case.



@d start the Spotlight server @{@%
cd m4_aspotlightdir
@% java  -Xmx8g -jar m4_spotlightjar nl http://localhost:m4_spotlight_nl_port/rest
java -jar -Xmx8g dbpedia-spotlight-0.7-jar-with-dependencies-candidates.jar en_2+2 http://localhost:<!!>m4_spotlight_en_port<!!>/rest  &
@% java -jar -Xmx8g dbpedia-spotlight-0.7-jar-with-dependencies-candidates.jar nl http://localhost:2060/rest  &
@| @}


@d check/start the Spotlight server @{@%
spottasks=`netstat -an | grep :m4_spotlight_en_port | wc -l`
if
  [ $spottasks -eq 0 ]
then
  @< start the Spotlight server @>
  sleep 120
fi
@| @}



@o m4_bindir/ned @{@%
#!/bin/bash
@< load progenvironment @>
@< check/start the Spotlight server @>
rootDir=m4_amoddir/m4_nedmodule
java -Xmx1000m -jar m4_dp_jardir/m4_nedjar -p m4_spotlight_en_port -e candidates

@| @}


\subsection{srl}
\label{sec:srl}

@% Currently, module \verb|m4_srlmodule| results in a null-pointer
@% exception when applied to the testfile from the \textsc{ned} module:
@% 
@% \begin{verbatim}
@% java.lang.NullPointerException
@% 	at is2.parser.Decoder.decode(Decoder.java:82)
@% 	at is2.parser.Parser.parse(Parser.java:478)
@% 	at is2.parser.Parser.apply(Parser.java:503)
@% 	at se.lth.cs.srl.preprocessor.Preprocessor.preprocess(Preprocessor.java:94)
@% 	at ixa.srl.MatePipeline.parse(MatePipeline.java:128)
@% 	at ixa.srl.MatePipeline.parseCoNLL09(MatePipeline.java:268)
@% 	at ixa.srl.MatePipeline.Pipeline(MatePipeline.java:233)
@% 	at ixa.srl.Annotate.annotate(Annotate.java:208)
@% 	at ixa.srl.Annotate.SRLToKAF(Annotate.java:72)
@% 	at ixa.srl.SRL.main(SRL.java:43)
@% 
@% \end{verbatim}
@% 
@% However, the module still produces a valid \NAF{} file.

Note that the \testsc{srl} module seems to require 2,5G of
memory. Take this into account when you want to apply
parallellisation.

@o m4_bindir/srl @{@%
#!/bin/bash
@< load progenvironment @>
rootDir=m4_amoddir/m4_srlmodule
exec java -jar -Xms2500m ${rootDir}/IXA-EHU-srl-2.0.jar en
@% exec java -jar -Xms2500m ${rootDir}/IXA-EHU-srl-1.0.jar en
@| @}

\subsection{Time}
\label{sec:time}

Note that this module utilises \verb|awk|

@o m4_bindir/time @{@%
#!/bin/bash
@< load progenvironment @>
rootDir=m4_amoddir/m4_timemodule
BEGINTIME=`date '+%Y-%m-%dT%H:%M:%S%z'`
YAMCHA=$rootDir/tools
timdir=`mktemp -d -t time.XXXXXX`
FILETXP=$timdir/TimePro.txp
CHUNKIN=$timdir/TimePro.naf
FILEOUT=$timdir/TimeProOUT.txp
TIMEPRONORMIN=$timdir/TimeProNormIN.txp
@% RANDOM=`bash -c 'echo $RANDOM'`
@% FILETXP=/tmp/$RANDOM-TimePro.txp
@% CHUNKIN=/tmp/$RANDOM-TimePro.naf
@% FILEOUT=/tmp/$RANDOM-TimeProOUT.txp
@% TIMEPRONORMIN=/tmp/$RANDOM-TimeProNormIN.txp
cd $rootDir
@% cat $1 > $CHUNKIN
cat > $CHUNKIN
cat $CHUNKIN | java -cp "lib/jdom-2.0.5.jar:lib/kaflib-naf-1.0.2.jar:lib/NAFtoTXP_v10.jar" eu.fbk.newsreader.naf.NAFtoTXP_v10 $FILETXP chunk+entity timex

#echo "Saving... $FILETXP"
tail -n +4 $FILETXP | awk -f resources/english-rules > $FILEOUT
head -n +4 $FILETXP > $TIMEPRONORMIN

cat $FILEOUT | $YAMCHA/yamcha-0.33/usr/local/bin/yamcha -m models/tempeval3_silver-data.model >> $TIMEPRONORMIN
cat $TIMEPRONORMIN | $JAVA_HOME/bin/java -cp "lib/scala-library.jar:lib/timenorm-0.9.0.jar:lib/threetenbp-0.8.1.jar:lib/TimeProNorm_v2.4.jar" eu.fbk.timePro.TimeProNormApply $FILETXP

@% rm $FILEOUT
@% rm $TIMEPRONORMIN

java -Dfile.encoding=UTF8 -cp "lib/TXPtoNAF_v3.jar:lib/jdom-2.0.5.jar:lib/kaflib-naf-1.0.2.jar" eu.fbk.newsreader.naf.TXPtoNAF_v3 $CHUNKIN $FILETXP "$BEGINTIME" TIMEX3 



#cat $FILETXP.out
#rm $FILETXP
#rm $FILETXP.out
rm $CHUNKIN

rm -rf $timdir
@| @}

\subsection{Event-coreference}
\label{sec:eventcoreference}

Try the instance from the Dutch pipeline.

@o m4_bindir/evcoref @{@%
#!/bin/bash
@< load progenvironment @>
JARDIR=m4_dp_jardir
MODROOT=$PIPEMODD/m4_eventcorefmodule
RESOURCESDIR=$MODROOT/resources
JARFILE=$JARDIR/m4_eventcorefjar
JAVAMODULE=eu.newsreader.eventcoreference.naf.EventCorefWordnetSim
JAVAOPTIONS="--method leacock-chodorow"
JAVAOPTIONS="$JAVAOPTIONS  --wn-lmf $RESOURCESDIR/wneng-30.lmf.xml.xpos" 
JAVAOPTIONS="$JAVAOPTIONS  --sim 2.0"
@% JAVAOPTIONS="$JAVAOPTIONS  --relations XPOS_NEAR_SYNONYM#HAS_HYPERONYM#HAS_XPOS_HYPERONYM"
JAVAOPTIONS="$JAVAOPTIONS  --relations has_hyperonym#event#has_hypernym"
java -Xmx812m -cp $JARFILE $JAVAMODULE  $JAVAOPTIONS

@| @}

\subsection{Timerel}
\label{sec:timerel}

@o m4_bindir/timerel  @{@%
#!/bin/bash
@< load progenvironment @>
rootDir=m4_amoddir/m4_timerelmodule
cd $rootDir
BEGINTIME=`date '+%Y-%m-%dT%H:%M:%S%z'`
timdir=`mktemp -d -t timerel.XXXXXX`
FILETXP=$timdir/TimePro.txp
CHUNKIN=$timdir/TimePro.naf
FILEOUT=$timdir/TimeProOUT.txp
TIMEPRONORMIN=$timdir/TimeProNormIN.txp
@% RANDOM=`bash -c 'echo $RANDOM'`
@% JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.25.x86_64
@% #JAVA_HOME=/usr
YAMCHA=./tools
@% 
@% FILETXP=/tmp/$RANDOM-TimePro.txp
@% CHUNKIN=/tmp/$RANDOM-TimePro.naf
@% FILEOUT=/tmp/$RANDOM-TimeProOUT.txp
@% TIMEPRONORMIN=/tmp/$RANDOM-TimeProNormIN.txp

cat > $CHUNKIN
cat $CHUNKIN | java -cp "lib/jdom-2.0.5.jar:lib/kaflib-naf-1.0.2.jar:lib/NAFtoTXP_v10.jar" eu.fbk.newsreader.naf.NAFtoTXP_v10 $FILETXP chunk+entity timex

#echo "Saving... $FILETXP"
tail -n +4 $FILETXP | awk -f resources/english-rules > $FILEOUT
head -n +4 $FILETXP > $TIMEPRONORMIN

cat $FILEOUT | $YAMCHA/yamcha-0.33/usr/local/bin/yamcha -m models/tempeval3_silver-data.model >> $TIMEPRONORMIN
cat $TIMEPRONORMIN | java -cp "lib/scala-library.jar:lib/timenorm-0.9.0.jar:lib/threetenbp-0.8.1.jar:lib/TimeProNorm_v2.4.jar" eu.fbk.timePro.TimeProNormApply $FILETXP

@% rm $FILEOUT
@% rm $TIMEPRONORMIN

java -Dfile.encoding=UTF8 -cp "lib/TXPtoNAF_v3.jar:lib/jdom-2.0.5.jar:lib/kaflib-naf-1.0.2.jar" eu.fbk.newsreader.naf.TXPtoNAF_v3 $CHUNKIN $FILETXP "$BEGINTIME" TIMEX3 

#cat $FILETXP.out
#rm $FILETXP
#rm $FILETXP.out
@% rm $CHUNKIN
rm -rf $timdir

@| @}

\subsection{Causalrel}
\label{sec:causalrel}

The script \verb|causalrel-pipeline-per-file.sh| contains pathnames
beginning with \verb|/tmp|. However, in some cases \verb|/tmp| is not
the best place for tempfiles, so we include the content of this script
in the main script that runs the module.




@o m4_bindir/causalrel @{@%
#!/bin/bash
@< load progenvironment @>
rootDir=m4_amoddir/m4_causalrelmodule
cd $rootDir
BEGINTIME=`date '+%Y-%m-%dT%H:%M:%S%z'`
timdir=`mktemp -d -t timerel.XXXXXX`
FILETXP=$timdir/Causalrel
@% FILETXPcsignalcol=$timdir/Causalrel.csignal.col
@% FILETXPcsignals=$timdir/Causalrel.csignals
NAF=$timdir/Causalrel.naf

cat > $NAF

cat $NAF | java -cp "lib/kaflib-naf-1.0.2.jar:lib/NAFtoTXP_v10.jar:lib/jdom-2.0.5.jar" eu.fbk.newsreader.naf.NAFtoTXP_v10 $FILETXP chunk+entity+event+timex+connectives+srl+dep+morpho+dct+main_verb+tlink train

@% sh causalrel-pipeline-per-file.sh $FILETXP ./tools/
@< include causalrel-pipeline-per-file @>

#java -jar TXPtoNAF.jar $NAF $FILETXP.clinks $BEGINTIME CLINK
java -Dfile.encoding=UTF8 -cp "lib/TXPtoNAF_v3.jar:lib/jdom-2.0.5.jar:lib/kaflib-naf-1.0.2.jar" eu.fbk.newsreader.naf.TXPtoNAF_v3 $NAF $FILETXP.clinks "$BEGINTIME" CLINK


@% rm $FILETXP
@% rm $FILETXP.clinks
@% rm $NAF
rm -rf $timdir


@| @}


@d include causalrel-pipeline-per-file @{@%
python buildCSignalColumnFeatures.py $FILETXP > $FILETXP.csignal.col
./tools/yamcha-0.33/usr/local/bin/yamcha -m models/csignal.model < $FILETXP.csignal.col | cut -f1,12 > $FILETXP.csignals

python buildCRelPairFeatures.py $FILETXP $FILETXP.csignals > $FILETXP.clink.col

./tools/yamcha-0.33/usr/local/bin/yamcha -m models/clink.model < $FILETXP.clink.col | cut -f1,2,24,30 | awk -F"\t" '$4=="CLINK" || $4=="CLINK-R" { print ; }' > $FILETXP.clinks

rm $FILETXP.csignals $FILETXP.csignal.col $FILETXP.clink.col

@| @}


\subsection{Factuality}
\label{sec:factuality}


To use the factuality module we have to use perl.

\url{http://search.cpan.org/CPAN/authors/id/R/RK/RKRIMEN/Scalar-MoreUtils-0.02.tar.gz}

@o m4_bindir/installmisc @{@%
instdir=`mktemp -d -t inst.XXXXXX`
cd $instdir
export PERL5LIB=m4_perllib:$PERL5LIB
mkdir -p m4_perllib
wget m4_moreutils_url
tar -xzf m4_moreutils_pack.tar.gz
cd m4_moreutils_pack
perl Makefile.PL INSTALL_BASE=m4_perlbase
make
make test
make install
cd ..
@% rm $instdir
@| @}




@o m4_bindir/factuality @{@%
#!/bin/bash
@< load progenvironment @>
rootDir=m4_amoddir/m4_factualmodule
# use non standard location for perl libraries
export PERL5LIB=m4_perllib:$PERL5LIB

cd ${rootDir}

#RANDOM=`bash -c 'echo $RANDOM'`
TMPDIR=`mktemp -d -t  factu.XXXXXX`

# Create a begin timestamp so we can log how long it takes to process a file
# [1] creates "begintimestamp.txt"
perl beginTimestamp.pl > ${TMPDIR}/begintimestap.txt

# Convert NAF file to Mallet input file 
perl NAFToMalletInputFactuality.pl ${TMPDIR}/temp.naf > ${TMPDIR}/malletinput.tab

# Run the mallet classifier 
mallet-2.0.7/bin/csv2classify --input ${TMPDIR}/malletinput.tab --output ${TMPDIR}/malletoutput.txt --classifier MyMaxEntFactuality.classifier

# Sort the output in order to be able to select the best prediction and its confidence
perl sortMalletOutput.pl ${TMPDIR}/malletoutput.txt > ${TMPDIR}/malletoutput.sorted

# Write back to NAF 
# [1] uses  "begintimestamp.txt"
perl convertMalletToNAF.pl ${TMPDIR}/temp.naf ${TMPDIR}/malletoutput.sorted ${TMPDIR}/begintimestap.txt 

# Clean up
#rm temp.naf malletinput.tab malletoutput.txt malletoutput.sorted begintimestamp.txt

rm -fr ${TMPDIR} >& /dev/null
@| @}


\section{Miscellaneous}
\label{sec:misc}

\subsection{Replace strings in config files}
\label{sec:replstrings}

The following Python method replaces copies of an obsolete string
\verb|obs| by a replacement string \verb|repl| in a given file. 

@d methods in configure_modules @{@%
def repl_strings_in_file( filepath, obs, repl):
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

@d rules of Makefile @{@%
test: nuweb/m4_atestfile
	cd m4_abindir && chmod 775 test
	cd m4_atestdir && m4_abindir/test

@| @}

@o m4_bindir/test @{@%
#!/bin/bash
ROOT=m4_aprojroot
TESTDIR=$ROOT/test
BIND=$ROOT/bin
mkdir -p $TESTDIR
cd $TESTDIR
cat $ROOT/nuweb/m4_atestfile | $BIND/tok > $TESTDIR/test.tok.naf
cat test.tok.naf | $BIND/pos > $TESTDIR/test.pos.naf
cat test.pos.naf | $BIND/nerc > $TESTDIR/test.nerc.naf
cat $TESTDIR/test.nerc.naf | $BIND/constparse > $TESTDIR/test.const.naf
cat $TESTDIR/test.const.naf | $BIND/corefgraph > $TESTDIR/test.corefg.naf
cat $TESTDIR/test.corefg.naf | $BIND/opinion > $TESTDIR/test.opin.naf
cat $TESTDIR/test.opin.naf | $BIND/ukb > $TESTDIR/test.ukb.naf
cat test.ukb.naf | $BIND/ims-wsd > $TESTDIR/test.wsd.naf
cat $TESTDIR/test.wsd.naf | $BIND/ned  > $TESTDIR/test.ned.naf
cat $TESTDIR/test.ned.naf | $BIND/srl  > $TESTDIR/test.srl.naf
cat $TESTDIR/test.srl.naf | $BIND/time > $TESTDIR/test.time.naf
cat $TESTDIR/test.time.naf | $BIND/evcoref  > $TESTDIR/test.ecrf.naf
cat $TESTDIR/test.ecrf.naf | $BIND/timerel  > $TESTDIR/test.trel.naf
cat $TESTDIR/test.trel.naf | $BIND/causalrel  > $TESTDIR/test.crel.naf
cat $TESTDIR/test.crel.naf | $BIND/factuality  > $TESTDIR/test.out.naf


@| @}



\section{Perform}
\label{sec:perform}

@d rules of Makefile @{@%

sources :
	mkdir -p m4_abindir
	mkdir -p m4_atestdir
	cd nuweb && stripnw m4_progname
	cd nuweb && nuweb m4_progname.w
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
	chmod 775 bin/evcoref
	chmod 775 bin/timerel
	chmod 775 bin/causalrel
	chmod 775 bin/factuality
	chmod 775 bin/installmisc
	bin/installmisc
	chmod 775 bin/configure_modules
	bin/configure_modules

@| @}


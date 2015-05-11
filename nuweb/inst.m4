m4_dnl
m4_dnl Titles
m4_dnl
m4_define(m4_progname, `e_nlpp')m4_dnl
m4_define(m4_doctitle, `Standardised English NLP pipeline')m4_dnl
m4_define(m4_docdate, `\today \\ m4_time_of_day~h.')m4_dnl
m4_define(m4_author, `Paul Huygen <paul.huygen@@huygen.nl>')m4_dnl
m4_define(m4_subject, `Standardised English pipeline')m4_dnl
m4_dnl
m4_dnl Paths and URL's
m4_dnl
m4_dnl
m4_define(m4_aprojroot, m4_regexp(m4_esyscmd(pwd), `\(^[a-zA-Z0-9/-_]+\)/nuweb$', `\1'))m4_dnl
m4_define(m4_projroot, `..')m4_dnl
m4_define(m4_asocket,  m4_regexp(m4_esyscmd(pwd), `\(^[a-zA-Z0-9/-_]+\)/e_nlpp/nuweb$', `\1'))m4_dnl
m4_define(m4_abindir, m4_aprojroot`/bin')m4_dnl     Binaries
m4_define(m4_bindir, m4_projroot`/bin')m4_dnl     Binaries
m4_define(m4_atestdir, m4_aprojroot`/test')m4_dnl     Binaries
m4_define(m4_testdir, m4_projroot`/test')m4_dnl     Binaries
m4_define(m4_amoddir, m4_aprojroot`/components')m4_dnl     Modules
m4_define(m4_moddir, m4_projroot`/components')m4_dnl     Modules
m4_define(m4_nrkey, nrkey)m4_dnl
m4_define(m4_nwrrepo, u017940.si.ehu.es)m4_dnl
m4_define(m4_nwrrepoport, 2223)m4_dnl
m4_define(m4_nwruser, newsreader)m4_dnl
m4_define(m4_anlpproot, m4_asocket/nlpp)m4_dnl
m4_define(m4_aprogenvscript, m4_anlpproot/bin/progenv)m4_dnl
m4_define(m4_atestfile, test.in.naf)m4_dnl
m4_dnl
m4_dnl Paths and URL's of Dutch pipeline
m4_dnl
m4_define(m4_nlpphost, `../..')m4_dnl
m4_define(m4_nlpprepo, git@@github.com:PaulHuygen/nlpp.git)m4_dnl
m4_define(m4_anlpproot, m4_asocket/nlpp)m4_dnl
m4_define(m4_dp_envdir, m4_anlpproot/env)m4_dnl
m4_define(m4_dp_jardir, m4_dp_envdir/java/jars)m4_dnl
m4_dnl
m4_dnl Perl
m4_define(m4_perlbase, m4_anlpproot/env/perl)m4_dnl
m4_define(m4_perllib, m4_perlbase/lib/perl5)m4_dnl
m4_define(m4_moreutils_url, http://search.cpan.org/CPAN/authors/id/R/RK/RKRIMEN/Scalar-MoreUtils-0.02.tar.gz)m4_dnl
m4_define(m4_moreutils_pack, Scalar-MoreUtils-0.02)m4_dnl
m4_dnl
m4_dnl Spotlight
m4_dnl
m4_define(m4_spotlight_nl_port, 2060)m4_dnl
m4_define(m4_spotlight_en_port, 2020)m4_dnl
m4_define(m4_aspotlightdir, m4_dp_envdir/spotlight)m4_dnl
m4_define(m4_spotlighturl, http://spotlight.sztaki.hu)m4_dnl
m4_define(m4_spotlight_download_url, m4_spotlighturl/downloads)m4_dnl
m4_define(m4_spotlightjarversion, 0.7)m4_dnl
m4_define(m4_simple_spotlightjar, dbpedia-spotlight-`'m4_spotlightjarversion`'.jar)m4_dnl
m4_define(m4_spotlightjar, dbpedia-spotlight-`'m4_spotlightjarversion`'-jar-with-dependencies-candidates.jar)m4_dnl
m4_define(m4_spotlight_nl_model, nl.tar.gz)m4_dnl
m4_define(m4_spotlight_en_model, en_2+2.tar.gz)m4_dnl
m4_define(m4_spotlight_en_port, 2020)m4_dnl
m4_dnl
m4_dnl Components
m4_dnl
m4_dnl EHU-tok
m4_define(m4_tokenizerversion, `1.8.0')m4_dnl
m4_define(m4_tokenizerjar, ixa-pipe-tok-`'m4_tokenizerversion.jar)m4_dnl
m4_dnl NERC
m4_define(m4_nercjar, ixa-pipe-nerc)m4_dnl
m4_define(m4_nercversion, 1.2.0)m4_dnl
m4_define(m4_anercresourcefilename, en-brown-clark-600-conll03-testa)m4_dnl
m4_dnl
m4_dnl EHU-parse
m4_define(m4_cparserjar, ixa-pipe-parse)m4_dnl
m4_define(m4_cparserversion, 1.0.2)m4_dnl
m4_dnl EHU-corefgraph
m4_define(m4_corefgraphmodule, EHU-corefgraph.v21)m4_dnl
m4_define(m4_cparserversion, 1.0.2)m4_dnl
m4_dnl VUA-opinionminer
m4_define(m4_opiminemodule, VUA-opinion-miner)m4_dnl
m4_define(m4_opimineconffilepath, m4_opiminemodule/final_models/en/mpqa/config.cfg)m4_dnl
m4_define(m4_cparserjar, ixa-pipe-parse)m4_dnl
m4_define(m4_cparserversion, 1.0.2)m4_dnl
m4_dnl VUA-ims-wsd
m4_define(m4_wsdmodule, VUA-ims-wsd)m4_dnl
m4_define(m4_bad_wsd_pythonscript, path_to_ims.py)m4_dnl
m4_define(m4_bad_ims_bashfile, testPlain.bash)m4_dnl
m4_dnl Java 1.6
m4_define(m4_java16pack, jre1.6.0_45)m4_dnl
m4_define(m4_java16ball, `jre-6u45-linux-x64.bin')m4_dnl
m4_define(m4_javabindir, m4_amoddir/m4_wsdmodule/)m4_dnl
m4_dnl EHU-ned
m4_define(m4_nedmodule, EHU-ned)m4_dnl
m4_define(m4_ned_version, 1.1.1)m4_dnl
m4_define(m4_nedgit, https://github.com/ixa-ehu/ixa-pipe-ned.git)m4_dnl
m4_define(m4_ned_commitname, d35d4df5cb71940bf642bb1a83e2b5b7584010df)m4_dnl  
m4_define(m4_neddir, ixa-pipe-ned)m4_dnl  Subdir. of modules
m4_dnl m4_define(m4_nedjar, ixa-pipe-ned-1.0.jar)m4_dnl
m4_define(m4_nedjar, ixa-pipe-ned-`'m4_ned_version`'.jar)m4_dnl
m4_define(m4_nedspotmodel_nl_tarball, nl.tar.gz)m4_dnl
m4_define(m4_nedspotmodel_nl_url, http://spotlight.sztaki.hu/downloads/`'m4_nedspotmodel_nl_tarball)m4_dnl
 
m4_define(m4_nedscript, ned)m4_dnl
m4_define(m4_wikipediadbmodule, wikipedia-db)m4_dnl
m4_define(m4_wikipediadbmodule_url, http://ixa2.si.ehu.es/ixa-pipes/models/`'wikipediamodule`'.v1.tar.gz)m4_dnl

m4_dnl EHU-srl
m4_dnl m4_define(m4_srlmodule, EHU-srl)m4_dnl
m4_define(m4_srlmodule, EHU-srl.v21)m4_dnl
m4_dnl FBK-time
m4_define(m4_timemodule, FBK-time.v23)m4_dnl
m4_dnl VUA-eventcoref
m4_define(m4_eventcorefmodule, vua-eventcoreference_v2)m4_dnl
m4_define(m4_eventcorefjar, EventCoreference-1.0-SNAPSHOT-jar-with-dependencies.jar)m4_dnl
m4_dnl FBK-temprel
m4_define(m4_temprelmodule, FBK-temprel.v23)m4_dnl
m4_dnl FBK-causalrel
m4_define(m4_causalrelmodule, FBK-causalrel.v23)m4_dnl
m4_dnl VUA-factuality
m4_define(m4_factualmodule, VUA-factuality)m4_dnl
m4_dnl
m4_dnl
m4_dnl
m4_changequote(`<!',`!>')m4_dnl
m4_define(m4_header, <!m4_esyscmd(date +'%Y%m%d at %H%Mh'| tr -d '\012'): Generated by nuweb from a_!>m4_progname<!.w!>)
m4_define(m4_time_of_day, <!m4_esyscmd(date +'%H:%M'| tr -d '\012')!>)m4_dnl
m4_define(m4_index4ht, <!tex '\def\filename{{!>m4_progname<!}{idx}{4dx}{ind}} \input idxmake.4ht'!>)m4_dnl
m4_define(m4_nuwebbindir, <!m4_projroot!>/nuweb/bin)m4_dnl

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
m4_define(m4_dp_jardir, m4_anlpproot/env/java/jars)m4_dnl
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
m4_dnl EHU-srl
m4_dnl m4_define(m4_srlmodule, EHU-srl)m4_dnl
m4_define(m4_srlmodule, EHU-srl.v21)m4_dnl
m4_dnl FBK-time
m4_define(m4_timemodule, FBK-time.v23)m4_dnl
m4_dnl VUA-eventcoref
m4_define(m4_eventcorefmodule, vua-eventcoreference_v2)m4_dnl
m4_define(m4_eventcorefjar, EventCoreference-1.0-SNAPSHOT-jar-with-dependencies.jar)m4_dnl
m4_dnl FBK-timerel
m4_define(m4_timerelmodule, FBK-time.v23)m4_dnl
m4_dnl
m4_dnl
m4_dnl
m4_changequote(`<!',`!>')m4_dnl

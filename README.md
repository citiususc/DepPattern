# DepPattern parsers and grammar compiler

## DESCRIPTION
This software contains four rule-based, dependency-based syntactic parsers for 4 languages (English, Spanish, Galician, and Portuguese), as well as MetaRomance, a multilingual parser suited for Romance languages. The parsers were implemented in PERL and are stored in the `parsers` folder. They were generated from dependency grammars, stored in the `grammars` folder. 

The software also contains a compiler (compi-beta.rb), implemented in Ruby, which generate parsers in PERL from DepPattern grammars. To write formal grammars using DepPattern, please, look up the [tutorial of the formal grammar](http://gramatica.usc.es/pln/tools/deppattern/html_tutorial/tutorialGrammar.html). 
Besides, the software provides the PoS tagger of [Linguakit](https://github.com/citiususc/Linguakit), also developed by our group.


## REQUIREMENTS
GNU/LINUX, Perl and Ruby (for the grammar compiler) 


## HOW TO INSTALL
You only need to download the repository.

### ZIP Download

Download [Linguakit-master.zip](https://github.com/citiususc/DepPattern/archive/master.zip) and then: 

```bash
unzip DepPattern-master.zip
```

### Using Git

```bash
git clone https://github.com/citiususc/DepPattern.git
```

## HOW TO USE
Run `./deppattern --help` to see the modules:

```
usage: deppattern <lang> [--help|-h] [-m|--meta-romance] [-g|--grammar] 
       		  	 [-ng|--no-iteration-grammar] [-p|--parser] [-f|--file] [-a] [-fa] [-c]

required positional arguments:
  <lang>          Choose the language 
		  Choices: [en, es, gl, pt], case insensitive

optional named arguments:
  --help, -h                               ? show this help message and exit
  -m, --meta-romance                       ? MetaRomance Parser
  -g, --grammar <grammar>                  ? Path of the file grammar (with iterations)
  -ng, --no-iteration-grammar <grammar>    ? Path of the file grammar (without iterations)
  -p, --parser <parser>                    ? Path of the parser, or name of the parser generated from grammar (i.e. metaromance)
  -f, --file <file>                        ? Path of the file input (default stdin)
  -a                                       ? Simple dependency analysis
  -fa                                      ? Full dependency analysis
  -conll                                   ? Full dependency analysis with CoNLL format
  -c                                       ? Tagged text with syntactic information (for correction rules)
```

## HOW TO USE IN WINDOWS

The same syntax with `deppattern.bat` command.


## EXAMPLES

Return a syntactic analysis for Portuguese in -a format:
```
./deppattern pt -f test/test-pt -a
```

Return a syntactic analysis for English in -conll format:
```
./deppattern en -f test/test-en -conll
```

Generate a parser (parser.perl) from the English grammar using the compiler:

```
./deppattern en -g grammars/grammar-devel-en/grammar-en.dp`
```

Return a syntactic analysis using the Spanish grammar, with -conll format:

```
./deppattern en -f test/test-es -g grammars/grammar-devel-es/grammar-es.dp -conll`
```

You also may enter the input text in pipeline:
```
echo "Mary is eating fish." |./deppattern en -a
```

## Configuration files
Each grammar directory must contain the following files: 

* the grammar (the name of the file is chosen by the user)
* tagset.conf
* dependencies.conf
* lexical_classes.conf
 
For more details, look up the  [tutorial of DepPattern](http://gramatica.usc.es/pln/tools/deppattern/html_tutorial/tutorialGrammar.html)

## MetaRomance
One of the parsers provided by the package is MetaRomance, made of Universal Dependencies for Romance languages, and one of the systems that participated at CoNLL-2017 Shared Task on multilingual dependency parsing. If the input text is in Portuguese, the command to run MetaRomance would be the following:

```
    ./deppattern pt -m -f tests/test-pt -a
```
More information in:

Garcia, Marcos and Pablo Gamallo (2017) "A rule-based system for cross-lingual parsing of Romance languages with Universal Dependencies", ConLL-2017, Vancouver, Canada.


## INPUT FILE
The input file must be in plain text format, and codified in UTF8.


## GRAMMAR FILE
The file containing the grammar must be in plain text format. 
Below, you'll find a toy example of a grammar with 4 dependency-based rules:


###### GRAMMAR #########
```
AdjnR:  NOUN  ADJ
Agr: number, genre
%

SpecL:  DT  NOUN 
Agr: number, genre
%

SubjL:  NOUN  [ADV]* VERB
Agr: number
%

DobjR:  VERB [ADV]* NOUN
%
```

Look up the tutorial stored in the doc directory. 



## OUTPUT FORMAT 
### BASIC ANALYSIS (flag -a):
Option -a means that deppattern generates a specific output based on triples. Each analysed sentence consists of two elements:

1. A line containing the POS tagged lemmas of the sentence. This line begins with the tag SENT. The set of tags used here are listed in file TagSet.txt. All lemmas are identified by means of a position number from 1 to N, where N is the size of the sentence.

2. All dependency triples identified by the grammar. A triple consists of:

(relation;head_lemma;dependent_lemma)

For instance, the sentence "I am a man." generates the following output:

```
SENT::<I_PRO_0_<number:0|lemma:I|possessor:0|case:0|genre:0|person:0|politeness:0|type:P|token:I|> am_VERB_1_<number:0|mode:0|lemma:be|genre:0|tense:0|person:0|type:S|token:am|> a_DT_2_<number:0|lemma:a|possessor:0|genre:0|person:0|type:0|token:a|> man_NOUN_3_<number:S|lemma:man|genre:0|person:3|type:C|token:man|> ._SENT>

(Subj;be_VERB_1;I_PN_0)
(Spec;man_NOM_3;a_DT_2)
(Dobj;be_VERB_1;man_NOM_3)
```

The set of dependency relationships used by the 5 grammars can be consulted and modified in the corresponding configuration file: `grammars/grammar-devel-LING/dependencies.conf`.

Morpho-syntactic information is provided by the POS tagger, also included in [Linguakit](https://github.com/citiususc/Linguakit) . 

### FULL ANALYSIS (flag -fa):
Option -fa gives rise to a full represention of the output triples. Each triple is associated with two pieces of information: morpho-syntactic features of both the head and the dependent. 


### TAGGED TEXT (flag -c):
Option -c allows us to generate a file with the same input (a tagged text) but with some corrections proposed by the grammar. This option is useful to identify and correct regular errors of PoS taggers using grammatical rules. 

### CONLL FORMAT (flag -conll):
It is also possible to get an output file with the format defined by CoNLL-X, inspired by Lin (1998). This format was adopted by the evaluation tasks defined in CoNLL.

## AUTHORS
Pablo Gamallo, Isaac González, Marcos Garcia, César Piñeiro, Grupo ProLNat@GE, CiTIUS,  University of Santiago de Compostela, Galiza.

## REFERENCES
>Gamallo P. , González I. (2011) A Grammatical Formalism Based on Patterns of Part-of-Speech Tags , International Journal of Corpus Linguistics , 16(1), 45-71. ISNN:1384-6655 

>Gamallo, P. 2015. Dependency Parsing with Compression Rules, The 14th International Conference on Parsing Technologies (IWPT-2015) p. 107-117, Bilbao. ISBN 978-1-941643-98-3 

>Gamallo, P., González, I. 2012. DepPattern: A Multilingual Dependency Parser, Demo Session of the International Conference on Computational Processing of the Portuguese Language (PROPOR 2012) , April 17-20, Coimbra, Portugal. 



	
